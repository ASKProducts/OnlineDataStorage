//
//  ODSViewController.h
//  OnlineDataStorage
//
//  Created by Aaron Kaufer on 1/9/13.
//  Copyright (c) 2013 Aaron Kaufer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ODSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *ChatBox;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
- (void)send:(UIButton*)button;
- (IBAction)clear:(id)sender;

- (IBAction)refresh:(id)sender;
@end
