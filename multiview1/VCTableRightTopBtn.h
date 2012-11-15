//
//  VCTableRightTopBtn.h
//  multiview1
//
//  Created by Mac User on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleContentViewControllerWebView.h"
#import "UtilFBSharing.h"
#import "AllViewControllers.h"

@class ArticleContentViewControllerWebView;
@class AllViewControllers;

@interface VCTableRightTopBtn : UITableViewController {
    NSArray* array_btns;
    ArticleContentViewControllerWebView* web_view;
    AllViewControllers* allVC;
    
}

//- (id)initWithStyle:(UITableViewStyle)style withWebView:(ArticleContentViewControllerWebView*) a;
- (id)initWithStyle:(UITableViewStyle)style withAllVC:(AllViewControllers*) a;

@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) NSString* link;
@property (nonatomic,retain) NSString* caption;
@property (nonatomic,retain) NSString* desc;
@property (nonatomic,retain) NSString* content;

@end
