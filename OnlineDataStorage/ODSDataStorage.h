//
//  ODSDataStorage.h
//  OnlineDataStorage
//
//  Created by Aaron Kaufer on 1/9/13.
//  Copyright (c) 2013 Aaron Kaufer. All rights reserved.
//

#define ONLINE_DATA_STORAGE_APP_KEY @"287171"

#import <Foundation/Foundation.h>

@interface NSString (HTMLEntities)

- (NSString *)stringByDecodingHTMLEntities;

@end


@interface ODSDataStorage : NSObject
+(void)loadURL:(NSString*)aurl forMethod:(NSString*)method;
+(NSMutableDictionary*)onlineData;
+(NSString*)getValueForKey:(NSString*)key;
+(NSString*)addValue:(NSString*)value;
+(void)removeValueWithKey:(NSString*)key;
+(void)setValue:(NSString*)value withKey:(NSString*)key;
+(NSDictionary*)onlineDataForThisApp;
+(void)submitDataForThisApp:(NSDictionary*)data;
+(id)getDataForThisAppWithKey:(NSString*)key;
+(void)setData:(id)data forThisAppWithKey:(NSString*)key;
@end
