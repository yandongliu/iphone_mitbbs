//
//  UtilSharing.h
//  multiview1
//
//  Created by Mac User on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#define APP_ID @"293010754128663"

@interface UtilFBSharing : NSObject<FBSessionDelegate, FBDialogDelegate> {
    Facebook* _facebook;

    UILabel *messageLabel;
    UIView *messageView;
}
@property (nonatomic, retain) Facebook *facebook;

@property (nonatomic, retain) UILabel *messageLabel;
@property (nonatomic, retain) UIView *messageView;

- (void)showShareDialogWithName:(NSString*) name Link:(NSString*)link Caption:(NSString*) caption Description:(NSString*) desc;

@end
