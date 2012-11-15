//
//  Util_download_boarditems.h
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardItemsViewController.h"
#import "ASIHTTPRequest.h"
#import "MitbbsItem.h"

@class AllViewControllers;

@interface Util_download_boarditems : NSObject 
    //BoardItemsViewController* boardItemsViewController;


@property (retain) NSOperationQueue *queue;


@property (retain) NSRegularExpression* regex_items;
@property (strong, nonatomic) AllViewControllers* allVC;

-(id) init_withAllVC:(AllViewControllers*) a;
@end
