//
//  UtilWeiboSharing.h
//  multiview1
//
//  Created by Mac User on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"
#define myAppKey @"4274574040"
#define myAppSecret @"aaeed74bb1bafcfd32de336e13825f02"
#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101

@interface UtilWeiboSharing : NSObject<WBEngineDelegate, WBLogInAlertViewDelegate,WBSendViewDelegate,UIAlertViewDelegate>{
        WBEngine *weiBoEngine;
        UIActivityIndicatorView *indicatorView;
    
}
@property (nonatomic, retain) WBEngine *weiBoEngine;
- (id)initWithView:(UIView*) view1;
- (void)showSharingDialogWithName:(NSString*) name andLink:(NSString*) link;
@end
