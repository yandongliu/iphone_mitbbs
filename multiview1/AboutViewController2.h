//
//  AboutViewController2.h
//  multiview1
//
//  Created by Mac User on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#define reviewURL  @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=537760582"

@interface AboutViewController2 : UIViewController < MFMailComposeViewControllerDelegate>

- (IBAction)send_email;
- (IBAction)rate_app:(id)sender;
@end
