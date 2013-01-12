//
//  ODSDataStorage.m
//  OnlineDataStorage
//
//  Created by Aaron Kaufer on 1/9/13.
//  Copyright (c) 2013 Aaron Kaufer. All rights reserved.
//

#import "ODSDataStorage.h"

@implementation NSString (HTMLEntities)

- (NSString *)stringByDecodingHTMLEntities {
    // TODO: Replace this with something more efficient/complete
    NSMutableString *string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&apos;" withString:@"'"  options:0 range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&amp;"  withString:@"&"  options:0 range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&lt;"   withString:@"<"  options:0 range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"&gt;"   withString:@">"  options:0 range:NSMakeRange(0, [string length])];
    return string;
}

@end

@implementation ODSDataStorage
+(void)loadURL:(NSString*)aurl forMethod:(NSString*)method{
    NSData *postData = [NSData dataWithBytes:[aurl UTF8String] length:[aurl length]];
    
    if([method isEqualToString:@"GET"]){
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://listmoz.com/actions.php?%@",aurl]]];
        [[[NSURLConnection alloc] initWithRequest:request delegate:nil] description];
    }
    else{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://listmoz.com/actions.php"]];
        [request setURL:url];
        [request setHTTPMethod:method];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    }
}

+(NSMutableDictionary*)onlineData{
    NSString *contents = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://listmoz.com/actions.php?action=get_lists&mod_url=FRPyjD55CBW6wJJ0VBH"] encoding:NSUTF8StringEncoding error:NULL];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    int count = 0;
    NSRange firstrange;
    NSRange secondrange;
    while ((firstrange = [contents rangeOfString:@"id=\"edit"]).length != 0) {
        NSString *key = [contents substringWithRange:NSMakeRange(firstrange.location+firstrange.length, 6)];
        secondrange = [contents rangeOfString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(firstrange.location, contents.length-firstrange.location-10)];
        NSString *value = [contents substringWithRange:NSMakeRange(firstrange.location+16, secondrange.location-(firstrange.location+16))];
        [data setValue:value forKey:key];
        if(count==0)[data setValue:key forKey:@"NewestKey"];
        contents = [contents substringFromIndex:firstrange.location+firstrange.length];
        count++;
    }
    
    return data;
}

+(NSString*)getValueForKey:(NSString*)key{
    NSMutableDictionary *onlineData = [ODSDataStorage onlineData];
    return [onlineData valueForKey:key];
}

+(NSString*)addValue:(NSString*)value{
    NSString *url = [NSString stringWithFormat:@"action=add&mod_url=FRPyjD55CBW6wJJ0VBH&description=%@",value];
    [ODSDataStorage loadURL:url forMethod:@"POST"];
    return [[ODSDataStorage onlineData] valueForKey:@"NewestKey"];
}

+(void)removeValueWithKey:(NSString*)key{
    NSString *url = [NSString stringWithFormat:@"action=delete&mod_url=FRPyjD55CBW6wJJ0VBH&itemID=%@",key];
    [ODSDataStorage loadURL:url forMethod:@"GET"];
}

+(void)setValue:(NSString*)value withKey:(NSString*)key{
    NSString *url = [NSString stringWithFormat:@"action=edit&mod_url=FRPyjD55CBW6wJJ0VBH&itemID=%@&description=%@",key,value];
    [ODSDataStorage loadURL:url forMethod:@"POST"];
}

+(NSDictionary*)onlineDataForThisApp{
    NSString *JSONContentString = [[ODSDataStorage getValueForKey:ONLINE_DATA_STORAGE_APP_KEY] stringByDecodingHTMLEntities];
    NSData *JSONContentData = [JSONContentString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //NSLog(@"%@",JSONContentString);
    NSError *er;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONContentData options:NSJSONReadingMutableContainers error:&er];
    //NSLog(@"%@",er);
    return JSONDictionary;
}

+(void)submitDataForThisApp:(NSDictionary*)data{
    NSData *JSONContentData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONReadingMutableContainers error:nil];
    NSString *JSONContentString = [[NSString alloc] initWithData:JSONContentData encoding:NSUTF8StringEncoding];
    [ODSDataStorage setValue:JSONContentString withKey:ONLINE_DATA_STORAGE_APP_KEY];
}

+(id)getDataForThisAppWithKey:(NSString*)key{
    NSDictionary *onlineData = [ODSDataStorage onlineDataForThisApp];
    return [onlineData valueForKey:key];
}

+(void)setData:(id)data forThisAppWithKey:(NSString*)key{
    NSMutableDictionary *currentData = [NSMutableDictionary dictionaryWithDictionary:[ODSDataStorage onlineDataForThisApp]];
    [currentData setValue:data forKey:key];
    [ODSDataStorage submitDataForThisApp:currentData];
}
@end






