//
//  AppDelegate.h
//  multiview1
//
//  Created by Yandong Liu on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapDetectingWindow.h"
//#import "AboutViewController.h"
//#import "BoardListViewController.h"
//#import "Util_download_pages.h"
//#import "view1.h"
//#import "TestScrollViewController.h"
//#import "TestToolBarViewController.h"
#import "AllViewControllers.h"

//#import "TabbarViewController.h"

@class view1;
@class AllViewControllers;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TapDetectingWindow* tapWindow;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) AllViewControllers *allVC;



@end
