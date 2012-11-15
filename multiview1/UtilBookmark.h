//
//  UtilBookmark.h
//  multiview1
//
//  Created by Mac User on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFavoriteBoards.h"

@class  VCFavoriteBoards;

@interface UtilBookmark : NSObject<NSFetchedResultsControllerDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (retain, nonatomic) UITableView* tableView;
@property (retain, nonatomic) VCFavoriteBoards* favBoard;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void) test;

-(void)addBookmark:(NSString*) title andLink:(NSString*) link andContent:(NSString*) content;

@end
