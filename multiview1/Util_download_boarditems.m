//
//  Util_download_boarditems.m
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util_download_boarditems.h"
#import "MyUtils.h"

@implementation Util_download_boarditems

@synthesize allVC = _allVC;


@synthesize queue = _queue;

@synthesize regex_items = _regex_items;

- (void) init_regex {
    NSError  *error  = NULL;
    self.regex_items = [NSRegularExpression 
                         regularExpressionWithPattern:@"<a class=\"news1\" href=\"/article_t2?/(\\w+)/(\\w+).html\">●\\s*(.+?)</a>"
                         options:NSRegularExpressionCaseInsensitive
                         error:&error];
}

-(id) init_withAllVC:(AllViewControllers *)a {
    self = [super init];
    if(self) {
        //NSLog(@"init download_boards.");
        self.allVC = a;
        [self init_regex];
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
    
}

-(void) parse_mitbbs_boarditems:(NSData*) data  {
    
    //[self.allVC.boardItemsViewController.tableView beginUpdates];
    [self.allVC.currentBoardItemsViewController.tableView beginUpdates];
    NSMutableArray* array = [[NSMutableArray alloc] init];
    //for(int i=0;i<[self.allVC.boardItemsViewController.allEntries count];i++) {
    for(int i=0;i<[self.allVC.currentBoardItemsViewController.allEntries count];i++) {
        [array addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    //NSLog(@"%@", array);
    
    //[self.allVC.boardItemsViewController.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic ];
    [self.allVC.currentBoardItemsViewController.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic ];
    [array release];
    //[_view1.tableView deleteSections:0 withRowAnimation:UITableViewRowAnimationFade];
    //[self.allVC.boardItemsViewController.allEntries removeAllObjects];
    [self.allVC.currentBoardItemsViewController.allEntries removeAllObjects];
    //[self.allVC.boardItemsViewController.tableView endUpdates];
    [self.allVC.currentBoardItemsViewController.tableView endUpdates];
    
    
    NSData* data_utf8 = [MyUtils convert_gbk2utf8:data];
    
    NSString * cccstring = [[NSString alloc] initWithData:data_utf8 encoding:NSUTF8StringEncoding];
    
    NSArray* article_matches = [self.regex_items matchesInString:cccstring options:0 range:NSMakeRange(0, [cccstring length])];
    for (NSTextCheckingResult* m in article_matches) {
        //NSLog(@"article_t number of groups captured:%d",[m numberOfRanges]);
        NSRange range_1 = [m rangeAtIndex:1];//Boardname
        NSRange range_2 = [m rangeAtIndex:2];//Article No
        NSRange range_3 = [m rangeAtIndex:3];//Title
        
        NSString* str_1 = [cccstring substringWithRange:range_1];
        NSString* str_2 = [cccstring substringWithRange:range_2];
        NSString* str_3 = [cccstring substringWithRange:range_3];
        
        
        //MitbbsFrontpageEntry* entry = [[MitbbsFrontpageEntry alloc] initWithTitle:str_title URL:str_url Category:str_category];
        
        
        //NSLog(@"%@,%@,%@", str_1, str_2, str_3);
        
        MitbbsItem *item = [[MitbbsItem alloc] init];
        item.board = str_1;
        item.title = str_3;
        item.url = [NSString stringWithFormat:@"%@/%@.html", str_1, str_2];

        //[self.allVC.boardItemsViewController.allEntries addObject:item];
        [self.allVC.currentBoardItemsViewController.allEntries addObject:item];
        [item release];
        
        //[self.allVC.boardItemsViewController.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.allVC.boardItemsViewController.allEntries count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [self.allVC.currentBoardItemsViewController.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.allVC.currentBoardItemsViewController.allEntries count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
    //NSLog(@"Finished frontpage parsing");
    //NSLog(@"obtained #entries:%d", [_view1.allEntries count]);
    //[self.allVC.boardItemsViewController.tableView reloadData];
    [self.allVC.currentBoardItemsViewController.tableView reloadData];
    [cccstring release];
    //[_view1 doneLoadingTableViewData];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"finished front page request,%@, %@", [request url], request.userInfo);
    [self parse_mitbbs_boarditems:[request responseData]];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}

- (void) dealloc 
{
    [self.queue release];
    _queue = nil;
    [super dealloc];
}

@end
