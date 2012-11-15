//
//  TabbarViewController.h
//  multiview1
//
//  Created by Yandong Liu on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UITextViewDelegate>

@property(strong, nonatomic) IBOutlet UITextView* textview;
@property(strong, nonatomic) IBOutlet UITextField* tf1;
@property(strong, nonatomic) IBOutlet UITextField* tf2;
//@property (strong, nonatomic) IBOutlet UILabel* lblAboutContent;
@property (strong, nonatomic) IBOutlet UILabel* lblAbout;
@property (strong, nonatomic) IBOutlet UITextView* lblAboutContent;
@property (strong, nonatomic) IBOutlet UILabel* lblName;
@property (strong, nonatomic) IBOutlet UILabel* lblEmail;
@property (strong, nonatomic) IBOutlet UILabel* lblSuggestion;

- (IBAction) doneEditing:(id)sender;
//- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) sendEmail:(id)sender;

@end
