//
//  BoardListViewController.h
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Util_download_boardname.h"
#import "BoardItemsViewController.h"
#import "MitbbsBoard.h"
#import "AllViewControllers.h"

@class  Util_download_boardname;
@class  AllViewControllers;

@interface BoardListViewController : UITableViewController <UISearchBarDelegate>

@property (retain, nonatomic) AllViewControllers* allVC;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

@property (retain, nonatomic) NSMutableArray *allEntries;
@property (retain, nonatomic) NSMutableArray *allEntries_copy;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers*) a;

@end
