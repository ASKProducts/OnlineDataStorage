//
//  ODSViewController.m
//  OnlineDataStorage
//
//  Created by Aaron Kaufer on 1/9/13.
//  Copyright (c) 2013 Aaron Kaufer. All rights reserved.
//

#import "ODSViewController.h"
#import "ODSDataStorage.h"

@interface ODSViewController ()

@end

@implementation ODSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[ODSDataStorage removeValueWithKey:@"287058"];
    
    //[ODSDataStorage submitDataForThisApp:[NSDictionary dictionaryWithObjectsAndKeys:@"13",@"age",@"aaron",@"aaron", nil]];
    //[ODSDataStorage setData:@"aaron" forThisAppWithKey:@"name"];
    //NSLog(@"%@",[ODSDataStorage onlineDataForThisApp]);
    [NSTimer scheduledTimerWithTimeInterval:(1.0/25.0) target:self selector:@selector(update) userInfo:nil repeats:YES];
}

-(void)update{
    NSString *chatText = [ODSDataStorage getDataForThisAppWithKey:@"chat"];
    [self.ChatBox setText:chatText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
    NSString *currentChat = [ODSDataStorage getDataForThisAppWithKey:@"chat"];
    NSString *newChat = self.inputText.text;
    self.inputText.text = @"";
    [ODSDataStorage setData:[NSString stringWithFormat:@"%@\n%@",currentChat,newChat] forThisAppWithKey:@"chat"];
}
@end
