//
//  view1.h
//  multiview1
//
//  Created by Yandong Liu on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "ArticleContentViewControllerWebView.h"
#import "Util_download_pages.h"
#import "Util_download_frontpage.h"
#import "AppDelegate.h"
//#define DOWNLOADING_IDLE 0
//#define DOWNLOADING_FRONTPAGE 1
//#define DOWNLOADING_PAGES 2

@class Util_download_frontpage;
@class Util_download_pages;
@class  AllViewControllers;

@interface MainViewController : UITableViewController <EGORefreshTableHeaderDelegate> {
    //NSString* str_msgs;
    //NSMutableArray* maMsgs;
EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    //int DOWNLOADING;
    //Util_download_pages* download_page_delegate;
    //Util_download_frontpage* download_frontpage_delegate;
    
    
}
- (void)doneLoadingTableViewData;

//@property(strong,nonatomic) UINavigationController *global_nc;
@property(strong,nonatomic) AllViewControllers* allVC;
@property(assign, nonatomic) BOOL reloading;

//@property (strong, nonatomic)  ArticleContentViewControllerWebView* vc_web;
//@property (retain, nonatomic) Util_download_pages* download_page_delegate;
//@property (retain, nonatomic) AppDelegate* appDelegate;


@property (assign) int DOWNLOADING;

//@property (strong, nonatomic) IBOutlet UILabel* label;
//@property (copy) NSString* str_msgs;


//@property (retain) NSArray *feeds;
@property (retain) NSMutableArray *allEntries;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withVCWeb:(ArticleContentViewControllerWebView*) v withDownloadDelegate:(Util_download_pages*) d;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers*)a;


//@property (retain) ArticleContentViewControllerWebView* vc_web;
@end
