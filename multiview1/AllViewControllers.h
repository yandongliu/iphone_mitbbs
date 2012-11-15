//
//  AllViewControllers.h
//  multiview1
//
//  Created by Yandong Liu on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AboutViewController2.h"
#import "BoardListViewController.h"
#import "ArticleContentViewControllerWebView.h"
#import "VCFavWebview.h"
#import "VCFavoriteBoards.h"
#import "Util_download_pages.h"
#import "Util_download_frontpage.h"
#import "Util_download_boardname.h"
#import "Util_download_boarditems.h"
#import "MainViewController.h"
#import "UtilFBSharing.h"
#import "UtilWeiboSharing.h"
#import "UtilBookmark.h"

@class Util_download_pages;
@class Util_download_frontpage;
@class Util_download_boarditems;
@class Util_download_boardname;
@class MainViewController;
@class BoardListViewController;
@class BoardItemsViewController;
@class VCFavoriteBoards;
@class UtilFBSharing;
@class UtilWeiboSharing;
@class UtilBookmark;
@class ArticleContentViewControllerWebView;
@class VCFavWebview;

@interface AllViewControllers : NSObject

@property (strong, nonatomic) AboutViewController2* aboutViewController;
@property (strong, nonatomic) VCFavoriteBoards* favViewController;
@property (strong, nonatomic) BoardListViewController* boardListViewController;
//@property (strong, nonatomic) BoardItemsViewController* boardItemsViewController;
@property (strong, nonatomic) BoardItemsViewController* currentBoardItemsViewController;
@property (strong, nonatomic) ArticleContentViewControllerWebView* vc_web;
@property (strong, nonatomic) VCFavWebview* vc_favweb;
@property (strong, nonatomic) MainViewController* vc_mitbbs_frontpage;
@property (retain, nonatomic) Util_download_pages* download_page_delegate;
@property (retain, nonatomic) Util_download_frontpage* download_frontpage_delegate;

@property (retain, nonatomic) Util_download_boarditems* util_download_boarditems;
@property (retain, nonatomic) Util_download_boardname* util_download_boardname;

@property (retain, nonatomic) UtilFBSharing* util_fbsharing;
@property (retain, nonatomic) UtilWeiboSharing* util_wbsharing;
@property (retain, nonatomic) UtilBookmark* util_bookmark;

@property (strong, nonatomic) UINavigationController *nc_main;
@property (strong, nonatomic) UINavigationController *nc_boards;
@property (strong, nonatomic) UINavigationController *nc_fav;

@property (strong, nonatomic) UITabBarController* tabBarController;

//@property (strong, nonatomic) UINavigationController *nc3;

@end
