//
//  VCFavoriteBoards.h
//  multiview1
//
//  Created by Mac User on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllViewControllers.h"

@class  AllViewControllers;
@interface VCFavoriteBoards : UITableViewController


//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic)  AllViewControllers* allVC;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers *)a;

@end
