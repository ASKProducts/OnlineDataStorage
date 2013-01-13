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

    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [self.inputText addTarget:self action:@selector(send:) forControlEvents:UIControlEventEditingDidEndOnExit];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)send:(UIButton*)button{
    NSString *currentChat = [ODSDataStorage getDataForThisAppWithKey:@"chat"];
    NSString *newChat = self.inputText.text;
    self.inputText.text = @"";
    [ODSDataStorage setData:[NSString stringWithFormat:@"%@\n%@",currentChat,newChat] forThisAppWithKey:@"chat"];
}

- (IBAction)clear:(id)sender {
    [ODSDataStorage setData:@"" forThisAppWithKey:@"chat"];
}

- (IBAction)refresh:(id)sender {
    NSString *chatText = [ODSDataStorage getDataForThisAppWithKey:@"chat"];
    if(![self.ChatBox.text isEqualToString:chatText])
        [self.ChatBox setText:chatText];
}
@end
