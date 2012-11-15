//
//  TabbarViewController.m
//  multiview1
//
//  Created by Yandong Liu on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "QuartzCore/QuartzCore.h"

@implementation AboutViewController

@synthesize textview = _textview;
@synthesize tf1 = _tf1;
@synthesize tf2= _tf2;
@synthesize lblAboutContent = _lblAboutContent;
@synthesize lblAbout = _lblAbout;
@synthesize lblEmail = _lblEmail;
@synthesize lblName = _lblName;
@synthesize lblSuggestion = _lblSuggestion;

- (void) dealloc {
    [super dealloc];
}

- (IBAction) doneEditing:(id)sender {
    //[sender resignFirstResponder];
    [self.tf1 resignFirstResponder];
    [self.tf2 resignFirstResponder];
    [self.textview resignFirstResponder];
    
    self.lblAbout.hidden = FALSE;
    self.lblAboutContent.hidden = FALSE;
    self.lblEmail.hidden = FALSE;
    self.lblName.hidden = FALSE;
    
    self.tf1.hidden =FALSE;
    self.tf2.hidden=FALSE;
    
    self.lblSuggestion.frame = CGRectMake(12, 219, self.self.lblSuggestion.frame.size.width, self.lblSuggestion.frame.size.height);
    self.textview.frame = CGRectMake(91, 219, self.textview.frame.size.width, 175);

}

- (IBAction) sendEmail:(id)sender {
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    NSLog(@"textViewShouldBeginEditing");
    return TRUE;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing");
    self.lblAbout.hidden = TRUE;
    self.lblAboutContent.hidden = TRUE;
    self.lblEmail.hidden = TRUE;
    self.lblName.hidden = TRUE;
    
    self.tf1.hidden =TRUE;
    self.tf2.hidden=TRUE;
    //CGPoint p = CGPointMake(10, 20);
    self.lblSuggestion.frame = CGRectMake(12, 60, self.self.lblSuggestion.frame.size.width, self.lblSuggestion.frame.size.height);
    self.textview.frame = CGRectMake(91, 60, self.textview.frame.size.width, 160);

}

//- (IBAction) textFieldDoneEditing:(id)sender {
//    NSLog(@"textFieldDoneEditing");
//    [sender resignFirstResponder];
//}
//
//- (IBAction) doneButtonOnKeyboardPressed:(id)sender {
//    NSLog(@"doneButtonOnKeyboardPressed");
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    NSLog(@"textViewDidEndEditing");
//}

-(void) init_webvew {
    //NSString* str = [NSString stringWithFormat:@"<html>Any feedback, please to send from below or email to <a href=mailto:jerrya007?subject='mitbbs_app suggestion'@163.com>jerrya007@163.com</a> Thanks!</html>"];
    //[self.webview loadHTMLString:str baseURL:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"About";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self init_webvew];
    self.textview.layer.borderWidth = 1;
    self.textview.layer.borderColor = [[UIColor grayColor] CGColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
