//
//  BoardItemsViewController.h
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Util_download_boarditems.h"
#import "BoardItemsViewController.h"
#import "MitbbsItem.h"
#import "ArticleContentViewControllerWebView.h"
#import "Util_download_pages.h"

//@class  Util_download_boarditems;
//@class Util_download_pages;
@class AllViewControllers;

@interface BoardItemsViewController : UITableViewController  {
    BOOL frontpage;
    int current_page;
    NSString* current_boardname;
}
    //Util_download_boarditems * util_download_boarditems;


@property (retain, nonatomic) NSMutableArray *allEntries;

//@property (retain, nonatomic) ArticleContentViewControllerWebView* vc_web;

//@property (retain, nonatomic) Util_download_pages* download_page_delegate;

@property (retain, nonatomic) AllViewControllers* allVC;

- (void)update_mitbbs_boarditems:(NSString*)url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers*) a;

@end
