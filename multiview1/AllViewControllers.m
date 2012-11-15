//
//  AllViewControllers.m
//  multiview1
//
//  Created by Yandong Liu on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllViewControllers.h"

@implementation AllViewControllers

@synthesize aboutViewController = _aboutViewController;
@synthesize favViewController = _favViewController;
@synthesize boardListViewController = _boardListViewController;
@synthesize currentBoardItemsViewController = _currentBoardItemsViewController;
//@synthesize boardItemsViewController = _boardItemsViewController;
@synthesize vc_web = _vc_web;
@synthesize vc_favweb;
@synthesize download_page_delegate = _download_page_delegate;
@synthesize download_frontpage_delegate = _download_frontpage_delegate;
@synthesize util_download_boarditems = _util_download_boarditems;
@synthesize util_download_boardname = _util_download_boardname;
@synthesize vc_mitbbs_frontpage = _vc_mitbbs_frontpage;
@synthesize nc_main = _nc_main;
@synthesize nc_boards = _nc_boards;
@synthesize nc_fav;
@synthesize tabBarController = _tabBarController;
@synthesize util_fbsharing;
@synthesize util_wbsharing;
@synthesize util_bookmark;

-(void) dealloc {
    [self.aboutViewController release];
    [self.boardListViewController release];
    
    [self.download_page_delegate release];
    [self.download_frontpage_delegate release];
    [self.util_download_boarditems release];
    [self.util_download_boardname release];
    [self.favViewController release];
    [self.vc_favweb release];
    [self.vc_web release];
    [self.vc_mitbbs_frontpage release];
    [self.util_bookmark release];
    [self.favViewController release];
    [self.nc_main release];
    [self.nc_boards release];
    [self.nc_fav release];


    [super dealloc];
}

-(id) init {
    self = [super init];
    if(self) {
        
        self.vc_mitbbs_frontpage = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil withAllVC:self];        
        self.vc_mitbbs_frontpage.title=@"Main";
        
        //self.vc_web = [[ArticleContentViewControllerWebView alloc] initWithNibName:@"ArticleContentViewControllerWebView" bundle:nil];
        self.vc_web = [[ArticleContentViewControllerWebView alloc] initWithNibName:@"ArticleContentViewControllerWebView" bundle:nil withAllVC:self];
        self.vc_favweb = [[VCFavWebview alloc] initWithNibName:@"VCFavWebview" bundle:nil];
        
        self.download_page_delegate = [[Util_download_pages alloc] initWithAllVC:self];
        self.download_frontpage_delegate = [[Util_download_frontpage alloc] initWithAllVC:self];
        self.util_download_boarditems = [[Util_download_boarditems alloc] init_withAllVC:self];
        self.util_download_boardname = [[Util_download_boardname alloc] init_withAllVC:self];
        
        self.util_bookmark = [[UtilBookmark alloc]init];
        
        self.aboutViewController = [[AboutViewController2 alloc] initWithNibName:@"AboutViewController2" bundle:nil];
        
        self.boardListViewController = [[BoardListViewController alloc] initWithNibName:@"BoardListViewController" bundle:nil withAllVC:self];
        self.favViewController = [[VCFavoriteBoards alloc] initWithNibName:@"VCFavoriteBoards" bundle:nil withAllVC:self];
        
        self.favViewController.fetchedResultsController = self.util_bookmark.fetchedResultsController;
        self.util_bookmark.favBoard = self.favViewController;
        
        
        //self.boardItemsViewController = [[BoardItemsViewController alloc] initWithNibName:@"BoardItemsViewController" bundle:nil withAllVC:self];
        
        self.nc_main = [[UINavigationController alloc] initWithRootViewController:self.vc_mitbbs_frontpage];
        self.nc_boards = [[UINavigationController alloc] initWithRootViewController:self.boardListViewController];
        self.nc_fav = [[UINavigationController alloc] initWithRootViewController:self.favViewController];
        
        self.tabBarController = [[[UITabBarController alloc] init] autorelease] ;
        
        self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.nc_main,  self.nc_boards, self.nc_fav, self.aboutViewController ,nil];
    }
    return self;
}

@end
