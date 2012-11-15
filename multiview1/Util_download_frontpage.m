//
//  Util_download_frontpage.m
//  multiview1
//
//  Created by Yandong Liu on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util_download_frontpage.h"
#import "MyUtils.h"

@implementation Util_download_frontpage

@synthesize queue = _queue;

@synthesize regex_article_t = _regex_article_t;
@synthesize allVC = _allVC;


- (void) init_regex {
    NSError  *error  = NULL;
    self.regex_article_t = [NSRegularExpression 
                            regularExpressionWithPattern:@"<li><a href=\"/article_t/(.+)\" class=.*>(.*?)</a></li>"
                            options:NSRegularExpressionCaseInsensitive
                            error:&error];
}

-(id) initWithAllVC:(AllViewControllers*)a {
    self = [super init];
    if(self) {
        //NSLog(@"init download_front_page.");
        self.allVC = a;
        [self init_regex];
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(unsigned int) indexOf:(char) searchChar fromString:(NSString*) str {
    NSRange searchRange;
    searchRange.location=(unsigned int)searchChar;
    searchRange.length=1;
    NSRange foundRange = [str rangeOfCharacterFromSet:[NSCharacterSet characterSetWithRange:searchRange]];
    return foundRange.location;
}




-(void) parse_mitbbs_articles:(NSData*) data deleteCurrentOne:(NSString*)delete {
    
    //_view1.DOWNLOADING = DOWNLOADING_IDLE;
    self.allVC.vc_mitbbs_frontpage.reloading = YES;

    //NSLog(@"delete:%@", delete);
    if([delete isEqualToString:@"yes"]) {
        //NSLog(@"delete section");

        
        
        [self.allVC.vc_mitbbs_frontpage.tableView beginUpdates];
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for(int i=0;i<[self.allVC.vc_mitbbs_frontpage.allEntries count];i++) {
            [array addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        NSLog(@"%@", array);

        [self.allVC.vc_mitbbs_frontpage.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic ];
        [array release];
        //[_view1.tableView deleteSections:0 withRowAnimation:UITableViewRowAnimationFade];
                [self.allVC.vc_mitbbs_frontpage.allEntries removeAllObjects];
        [self.allVC.vc_mitbbs_frontpage.tableView endUpdates];
    }
        
    //[_view1.tableView reloadData];
    
    //NSRange* range = [regex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    //NSUInteger numberOfMatches = [self.regex_article_t numberOfMatchesInString:content
                                                                       //options:0
                                                                         //range:NSMakeRange(0, [content length])];
    //NSRange *range   = [regex rangeOfFirstMatchInString:string
    //options:0 
    //range:NSMakeRange(0, [string length])];
   // NSLog(@"#matches:%d", numberOfMatches);
    
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingDOSChineseSimplif);
    
    //NSString *cccstring = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.mitbbs.com"] encoding:encoding error:nil];
    
    NSData* data_utf8 = [MyUtils convert_gbk2utf8:data];

    
    NSString * cccstring = [[NSString alloc] initWithData:data_utf8 encoding:NSUTF8StringEncoding];
    //NSLog(@"encoded content:%@", cccstring);
    
    //NSLog(@"html = %@",cccstring);
    
    
    
    NSArray* article_matches = [self.regex_article_t matchesInString:cccstring options:0 range:NSMakeRange(0, [cccstring length])];
    for (NSTextCheckingResult* m in article_matches) {
        //NSLog(@"article_t number of groups captured:%d",[m numberOfRanges]);
        NSRange range_url = [m rangeAtIndex:1];
        NSRange range_title = [m rangeAtIndex:2];
        
        NSString* str_title = [cccstring substringWithRange:range_title];
        NSString* str_url = [cccstring substringWithRange:range_url];
        NSString* str_category = [str_url substringToIndex:[self indexOf:'/' fromString:str_url]];
        //NSLog(@"category:%@", str_category);
        
        MitbbsFrontpageEntry* entry = [[MitbbsFrontpageEntry alloc] initWithTitle:[self decodeHTML:str_title] URL:str_url Category:str_category];
        //[self.allEntries addObject:[content substringWithRange:b.range]];
        
        //[_allEntries insertObject:entry atIndex:insertIdx];
        [self.allVC.vc_mitbbs_frontpage.allEntries addObject:entry];
        
        [entry release];
        
        [self.allVC.vc_mitbbs_frontpage.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.allVC.vc_mitbbs_frontpage.allEntries count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
    //[_view1.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[_view1.allEntries count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    //NSLog(@"Finished frontpage parsing");
    //NSLog(@"obtained #entries:%d", [self.allVC.vc_mitbbs_frontpage.allEntries count]);
    [self.allVC.vc_mitbbs_frontpage.tableView reloadData];
    [cccstring release];
    [self.allVC.vc_mitbbs_frontpage doneLoadingTableViewData];
    
}

- (NSString*) decodeHTML:(NSString*) content {
    NSString* str=content;
    str = [str stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return str;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    //NSLog(@"finished front page request,%@, %@", [request url], request.userInfo);
    [self parse_mitbbs_articles:[request responseData] deleteCurrentOne:[request.userInfo objectForKey:@"delete"] ];
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
