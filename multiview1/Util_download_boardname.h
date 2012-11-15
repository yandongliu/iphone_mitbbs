//
//  Util_download_boardname.h
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "BoardListViewController.h"
#import "MitbbsBoard.h"

@class  AllViewControllers;

@interface Util_download_boardname : NSObject

@property (retain) NSOperationQueue *queue;


@property (retain) NSRegularExpression* regex_boards;
@property (strong, nonatomic) AllViewControllers* allVC;

-(id) init_withAllVC:(AllViewControllers*) a;

@end
