//
//  Util_download_boardname.m
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util_download_boardname.h"
#import "MyUtils.h"
//#import "BoardListViewController.h"

@implementation Util_download_boardname

@synthesize queue = _queue;

@synthesize regex_boards = _regex_boards;
@synthesize allVC = _allVC;

- (void) init_regex {
    NSError  *error  = NULL;
    self.regex_boards = [NSRegularExpression 
                         regularExpressionWithPattern:@"<a href=\"/bbsdoc/(\\w+).html\" class=\"a2\">\\s*(.+).*\\(.*</a></td>"
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



-(void) parse_mitbbs_board:(NSData*) data  {
    
    
    NSData* data_utf8 = [MyUtils convert_gbk2utf8:data];
    
    
    NSString * cccstring = [[NSString alloc] initWithData:data_utf8 encoding:NSUTF8StringEncoding];
    //NSLog(@"encoded content:%@", cccstring);
    
    //NSLog(@"html = %@",cccstring);
    
    
    NSArray* article_matches = [self.regex_boards matchesInString:cccstring options:0 range:NSMakeRange(0, [cccstring length])];
    NSLog(@"# boards:%d", article_matches.count);
    for (NSTextCheckingResult* m in article_matches) {
        //NSLog(@"article_t number of groups captured:%d",[m numberOfRanges]);
        NSRange range_board_eng = [m rangeAtIndex:1];
        NSRange range_board_chn = [m rangeAtIndex:2];
        
        NSString* str_board_eng = [cccstring substringWithRange:range_board_eng];
        NSString* str_board_chn = [cccstring substringWithRange:range_board_chn];
        
        str_board_chn =
        [str_board_chn stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //MitbbsFrontpageEntry* entry = [[MitbbsFrontpageEntry alloc] initWithTitle:str_title URL:str_url Category:str_category];
        //NSString *board =  str_board_chn;
        //TODO:memleak
        MitbbsBoard* board = [[MitbbsBoard alloc]  init];
        board.chn = str_board_chn;
        //NSLog(@"chn:%@", str_board_chn);
        board.eng = str_board_eng;
        [self.allVC.boardListViewController.allEntries addObject:board];
        [self.allVC.boardListViewController.allEntries_copy addObject:board];
        
        [board release];
        
        //NSLog(@"%@,%@", str_board_eng, str_board_chn);
        
        
        [self.allVC.boardListViewController.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.allVC.boardListViewController.allEntries count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
    NSLog(@"Finished frontpage parsing");
    //NSLog(@"obtained #entries:%d", [_view1.allEntries count]);
    [self.allVC.boardListViewController.tableView reloadData];
    [cccstring release];
    //[_view1 doneLoadingTableViewData];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"finished front page request,%@, %@", [request url], request.userInfo);
    [self parse_mitbbs_board:[request responseData]];
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
