//
//  Util_download_frontpage.h
//  multiview1
//
//  Created by Yandong Liu on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "ASIHTTPRequest.h"
#import "MitbbsFrontpageEntry.h"
//#import "MitbbsPage.h"
#import "MyUtils.h"
#import "AllViewControllers.h"

@class AllViewControllers;

@interface Util_download_frontpage : NSObject

-(id) initWithAllVC:(AllViewControllers*) a;

@property (retain) NSOperationQueue *queue;

@property (nonatomic, strong) AllViewControllers* allVC;

@property (retain) NSRegularExpression* regex_article_t;

@end
