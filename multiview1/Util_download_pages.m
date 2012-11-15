//
//  Util_download_pages.m
//  multiview1
//
//  Created by Yandong Liu on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util_download_pages.h"
#import "MyUtils.h"
#import "MitbbsPage.h"
#import "MitbbsEntry.h"

@implementation Util_download_pages

@synthesize queue = _queue;
@synthesize queue_numpages = _queue_numpages;
@synthesize base_url = _base_url;
@synthesize title = _title;

@synthesize regex_article_posts = _regex_article_posts;
@synthesize regex_html_tags = _regex_html_tags;
@synthesize regex_num_pages = _regex_num_pages;
@synthesize regex_each_page_num = _regex_each_page_num;
@synthesize regex_quotes = _regex_quotes;
@synthesize regex_blank_lines = _regex_blank_lines;
@synthesize regex_author_body = _regex_author_body; //needed
@synthesize regex_unsupported_obj = _regex_unsupported_obj;
@synthesize regex_imgsrc = _regex_imgsrc;
@synthesize regex_signature = _regex_signature;

@synthesize allVC = _allVC;

@synthesize ma_msgs = _ma_msgs;

- (void) init_regex {
    NSError  *error  = NULL;
    
    self.regex_article_posts = [NSRegularExpression 
                                regularExpressionWithPattern:@"<td  class=\"jiawenzhang-type\">(.*?)</td>"
                                options:NSRegularExpressionDotMatchesLineSeparators 
                                error:&error];
    
    self.regex_html_tags = [NSRegularExpression 
                            regularExpressionWithPattern:@"<[^>]*>"
                            options:NSRegularExpressionDotMatchesLineSeparators 
                            error:&error];
    
    self.regex_quotes = [NSRegularExpression 
                         //regularExpressionWithPattern:@"\n:.*"
                         regularExpressionWithPattern:@"\n[【:].*<br />"
                         options:0 
                         error:&error];
    
    
    self.regex_num_pages = [NSRegularExpression 
                            regularExpressionWithPattern:@"<td class=\"news-bg\" align=\"right\">(.*?)</td>"
                            options:NSRegularExpressionDotMatchesLineSeparators 
                            error:&error];
    
    self.regex_each_page_num = [NSRegularExpression 
                                regularExpressionWithPattern:@"<u>(\\d+)</u>"
                                options:NSRegularExpressionDotMatchesLineSeparators 
                                error:&error];
    
    self.regex_blank_lines = [NSRegularExpression 
                              regularExpressionWithPattern:@"<br\\s*/>\n<br\\s*/>"
                              options:NSRegularExpressionDotMatchesLineSeparators 
                              error:&error];

    
    self.regex_author_body = [NSRegularExpression 
                              //regularExpressionWithPattern:@"发信人:(.*?),.*发信站.*?<br />\n(.*?)<br />\n[-【:]"
                              regularExpressionWithPattern:@"发信人:(.*?),.*?发信站.*?<br />\n(.*)</p>"
                              options:NSRegularExpressionDotMatchesLineSeparators
                              error:&error];
    
    self.regex_unsupported_obj = [NSRegularExpression 
                              regularExpressionWithPattern:@"<object classid=.*>"
                              options:NSRegularExpressionDotMatchesLineSeparators
                              error:&error];
    
    self.regex_imgsrc = [NSRegularExpression 
                                  regularExpressionWithPattern:@"SRC=\"/([^\"]*)\""
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    
    self.regex_signature = [NSRegularExpression 
                         regularExpressionWithPattern:@"--[^-]*?※.*<br />\n(※.*<br />\n)?"
                         options:NSRegularExpressionDotMatchesLineSeparators
                         error:&error];
    
} 

//-(id) initWithView1:(view1*) __view1 {
//     NSLog(@"util_download_pages init");
//    self = [super init];
//    if(self) {
//        _view1 = __view1;
//        self.ma_msgs = [NSMutableArray array];
//        [self init_regex];
//        //[self.queue = [NSOperationQueue alloc] init];
//        //[self.queue_numpages = [NSOperationQueue alloc] init];
//    }
//    return self;
//}

-(id) initWithAllVC:(AllViewControllers*) a {
    NSLog(@"util_download_pages init");
    self = [super init];
    if(self) {
        self.allVC = a;
        self.ma_msgs = [NSMutableArray array];
        [self init_regex];
        //[self.queue = [NSOperationQueue alloc] init];
        //[self.queue_numpages = [NSOperationQueue alloc] init];
    }
    return self;
}



- (void)add_to_pagedownload_queue:(NSString*) str_url withPageNum:(int)pagenum {
    
    if(!self.queue) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    
    
    DOWNLOADING = DOWNLOADING_PAGES;
    // _view1.DOWNLOADING = view1.DOWNLOADING_PAGES;
    NSLog(@"add download_pages request:%@", str_url);
    NSURL* url = [NSURL URLWithString:str_url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(pagedownload_request_done:)];
    [request setDidFailSelector:@selector(pagedownload_reqeust_failed:)];
    request.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:pagenum]  forKey:@"pagenum"];
    [_queue addOperation:request];
}

- (void)add_to_numpagedownload_queue:(NSString*) str_url {
    
    if(!self.queue_numpages) {
        NSLog(@"init queue_numpages");
        self.queue_numpages = [[NSOperationQueue alloc] init];
    }
    
    if(! _queue_numpages) {
        NSLog(@"init2 queue_numpages");
        _queue_numpages = [[NSOperationQueue alloc] init];
    }
    
    //DOWNLOADING = DOWNLOADING_NUM_PAGES;
    NSLog(@"add download_numpages request:%@", str_url);
    NSURL* url = [NSURL URLWithString:str_url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(numpagedownload_request_done:)];
    [request setDidFailSelector:@selector(numpagedownload_reqeust_failed:)];
    [_queue_numpages addOperation:request];
}


//-(int)get_num_pages:(NSString*) url {

    
  // }

- (NSString*) sort_and_get_text {
    NSString* str = [NSString stringWithFormat:@""];
    //[self.ma_msgs sortUsingSelector:comparePersonsUsingSelector];
    //[self.ma_msgs sortUsingSelector:@selector(compare:)];
    
    NSArray* sorted_array = [self.ma_msgs sortedArrayUsingComparator:^(id  a, id b) {
        //return [a compare:b];
        MitbbsPage* a1 = (MitbbsPage*) a;
        MitbbsPage* b1 = (MitbbsPage*) b;
        if (a1.pagenum > b1.pagenum) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (a1.pagenum < b1.pagenum) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    for (MitbbsPage* p in sorted_array) {
        str = [str stringByAppendingFormat:@"%@\n<br/>", [p get_page_text]];
    }
    
    //[sorted_array release];
    
    return str;
}


- (void) parse_one_page:(NSData*) data URL:(NSURL*) url withPageNum:(NSNumber*)pagenum {
    //NSLog(@"pagenum:%@", pagenum);
    
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    //NSStringEncoding encoding_tc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGBK_95);
    
    NSData* data_utf8 = [MyUtils convert_gbk2utf8:data];
    
    NSString * content = [[NSString alloc] initWithData:data_utf8 encoding:NSUTF8StringEncoding];
    
    if(!content) {
        NSLog(@"Content is null. Might be encoding error:%@", url);
        return;
    }
    
    
    //NSLog(@"parsing one page");
    
    //NSLog(@"downloaded content:%@", content);
    
    //NSString *cccstring = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:encoding error:nil];
    //NSString* cccstring = content;
    
    //NSString* str_utf2 = [[NSString alloc] initWithData:<#(NSData *)#> encoding:NSUTF8StringEncoding]
    
    //NSString* str_utf = [[NSString alloc] initWithUTF8String:[content UTF8String]];
    
    NSUInteger numberOfMatches = [self.regex_article_posts numberOfMatchesInString:content
                                                                           options:0
                                                                             range:NSMakeRange(0, [content length])];
    
    if(numberOfMatches <=0)
        return;
    //NSRange *range   = [regex rangeOfFirstMatchInString:string
    //options:0 
    //range:NSMakeRange(0, [string length])];
    //NSLog(@"#one article message matches:%d", numberOfMatches);
    
    MitbbsPage* page = [[MitbbsPage alloc] initWithPagenum:[pagenum intValue] Title:self.title];
    
    
    NSArray* msgs = [self.regex_article_posts matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    for (NSTextCheckingResult* m in msgs) {
        //NSLog(@"messages number of groups captured:%d",[m numberOfRanges]);
        //NSRange range_url = [m range];
        NSRange range_post = [m rangeAtIndex:1];
        NSString* post_content = [content substringWithRange:range_post];
        
        
        
        NSString *no_space =
        [post_content stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //NSLog(@"no space content:%@", no_space);
        
        NSArray* match_imgsrcs = [self.regex_imgsrc matchesInString:no_space options:0 range:NSMakeRange(0, [no_space length])];
        for(NSTextCheckingResult* match_imgsrc in match_imgsrcs) {
            NSString* matched_imgsrc = [no_space substringWithRange:[match_imgsrc rangeAtIndex:1]];
             //NSLog(@"matched img src:%@", matched_imgsrc);
//            if ( [matched_imgsrc substringToIndex:4] != @"http") {
//                
//                no_space = [no_space stringByReplacingOccurrencesOfString:matched_imgsrc withString:[NSString stringWithFormat:@"http://www.mitbbs.com/%@", matched_imgsrc]];
//                 NSLog(@"replacing:%@ with %@", matched_imgsrc, @"http://www.mitbbs.com/-");
//                
//            }
        }
        no_space = [self.regex_imgsrc stringByReplacingMatchesInString:no_space options:0 range:NSMakeRange(0, [no_space length]) withTemplate:@"src=http://mitbbs.com/$1"];
        
        
                
        NSArray* matches = [self.regex_author_body matchesInString:no_space options:0 range:NSMakeRange(0, [no_space length])];
        if (matches.count <=0) {
            NSLog(@"----------------Error. No matches");
            NSLog(@"parsing %@", no_space);
        }
        
        NSTextCheckingResult* m_msgbody = [matches objectAtIndex:0] ;
        NSString* author= [no_space substringWithRange:[m_msgbody rangeAtIndex:1]];
        NSString* body = [no_space substringWithRange:[m_msgbody rangeAtIndex:2]];
        
        //NSLog(@"author:%@", author);
        //NSLog(@"body:%@", body);
        
        
        //NSString* post_no_tag = [self.regex_html_tags stringByReplacingMatchesInString:str_url_no_space options:(0) range:NSMakeRange(0, [str_url_no_space length]) withTemplate:@""];
        
        /*
         NSString* post_content_no_space_no_quote = [self.regex_quotes stringByReplacingMatchesInString:post_content_no_space options:0 range:NSMakeRange(0, [post_content_no_space length]) withTemplate:@""];
         */
        
        body = [self.regex_quotes stringByReplacingMatchesInString:body options:0 range:NSMakeRange(0, [body length]) withTemplate:@""];
        
        body = [self.regex_signature stringByReplacingMatchesInString:body options:0 range:NSMakeRange(0, [body length]) withTemplate:@""];
        
        NSString* body2 = [self.regex_blank_lines stringByReplacingMatchesInString:body options:0 range:NSMakeRange(0, [body length]) withTemplate:@"<br/>"];
        
        while(![body2 isEqualToString:body]) {
            //NSLog(@"replacing blank line mark");
            body = [self.regex_blank_lines stringByReplacingMatchesInString:body2 options:0 range:NSMakeRange(0, [body2 length]) withTemplate:@"<br/>"];
            NSString* tmp = body2;
            body2 = body;
            body = tmp;
        }
        //NSLog(@"done replacing blank line mark");
        
        //NSLog(@"body2:%@",body2);
        
        body = [self.regex_unsupported_obj stringByReplacingMatchesInString:body options:0 range:NSMakeRange(0, [body length]) withTemplate:@"&lt;Unsupported Browser Plugin&gt; "];
        
        if(self.allVC.vc_web.postdesc==nil) {
            int l =body.length;
            if(l<100)
                self.allVC.vc_web.postdesc=[NSString stringWithFormat:@"%@... from MitbbsXViewer for iPhone",[body substringToIndex:l]];
            else
                self.allVC.vc_web.postdesc=[NSString stringWithFormat:@"%@... from MitbbsXViewer for iPhone",[body substringToIndex:100]];
        }
        
        
        //NSLog(@"adding message:%@:%@", author, body);
        //self.str_msgs = [self.str_msgs stringByAppendingFormat:@"%@", str_url];
        MitbbsEntry* entry = [[MitbbsEntry alloc] initWithBody:body withAuthor:author];
        [page addEntry:entry];
        [entry release];
        
        //self.ma_msgs addObject:[NSString stringWithFormat:@"<b>%@:</b><br/>%@", author, body]];
        //[[self ma_msgs] addObject:@"hello"];
        //NSLog(@"parse_one_article:%@", [[self ma_msgs] componentsJoinedByString:@"\n"]);
        //NSLog(@"article message:%@\n\n\n", str_url);
    }
    [self.ma_msgs addObject:page];
    
    [page release];
    [content release];
    
    
    //NSLog(@"add # pages:%d", [self.ma_msgs count]);
    
    //NSString* text_html = [[NSString alloc] initWithFormat:@"%@",[self. ma_msgs componentsJoinedByString:@"<br/><hr/><br/>"]];
    //NSString* text_html = [page get_page_text];
    //NSLog(@"downloader too add text:%@", text_html);
    //[_view1.vc_web.text initWithFormat:@"%@<br />%@", _view1.vc_web.text, text_html];
    
    self.allVC.vc_web.text = [self sort_and_get_text];
    //self.allVC.vc_web.posturl=[url absoluteString];
    self.allVC.vc_web.posttitle = self.title;
    //self.allVC.vc_web.postname=self.allVC.vc_web.posturl;
    [self.allVC.vc_web reloadWebView];
    //[_view1.vc_web webview_addtext:text_html];
    //[text_html release];
    
    //NSLog(@"-----------\n%@", [self sort_and_get_text] );
}



- (void) parse_numpages:(NSData*) data URL:(NSURL*)url {
    
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSError* dnerror = NULL;
    //NSString *cstring = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:encoding error:&dnerror];
    
    NSData* data_utf8 = [MyUtils convert_gbk2utf8:data];
    
    NSString * cstring = [[NSString alloc] initWithData:data_utf8 encoding:NSUTF8StringEncoding];
    
    if(!cstring) 
    {
        NSLog(@"Error. url: returns null:%@", url);
        if(dnerror) {
            NSLog(@"Error:%@", dnerror);
        }
        return;
    }
    
    NSArray* msgs = [self.regex_num_pages matchesInString:cstring options:0 range:NSMakeRange(0, [cstring length])];
    
    
    
    int num_pages = 1;
    for (NSTextCheckingResult* m in msgs) {
        NSRange range_url = [m rangeAtIndex:1];
        NSString* str_url = [cstring substringWithRange:range_url];
        //NSLog(@"page num tag:%@", str_url);
        
        NSArray* msgs2 = [self.regex_each_page_num matchesInString:str_url options:0 range:NSMakeRange(0, [str_url length])];
        
        NSTextCheckingResult* last_page_num_match = [msgs2 lastObject];
        
        NSString* last_page_num = [str_url substringWithRange:[last_page_num_match rangeAtIndex:1]];       
        //NSLog(@"last page_num:--%@--", last_page_num);
        if(last_page_num == nil) {
            num_pages = 1; 
        } else {
            num_pages = [last_page_num intValue];
        }
        break;
    }
//    if (num_pages == nil) {
//        num_pages = 1;
//    }
    
    [cstring release];
    //NSLog(@"num pages to download:%d", num_pages);
    
    // NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingDOSChineseSimplif);
    
    
    [self.ma_msgs removeAllObjects];
    
    [self parse_one_page:data URL:url withPageNum:[NSNumber numberWithInt:1]];

    
    for(int page_number=2;page_number<=num_pages;page_number++) {
        
        NSString* url = [[NSString alloc] initWithFormat:@"http://www.mitbbs.com/article_t1/%@_0_%d.html", [self.base_url substringToIndex:[self.base_url length] - 5],page_number];
        
        [self add_to_pagedownload_queue:url withPageNum:page_number];
        
        [url release];
        
    }

}



-(void) parse_mitbbs_one_article_all_pages_with_baseurl:(NSString*) _url Title:(NSString *)t {
    NSLog(@"parse_mitbbs_one_article_all_pages_with_baseurl");
    
    NSString* num_page_url = [[NSString alloc] initWithFormat:@"http://www.mitbbs.com/article_t/%@.html", [_url substringToIndex:[_url length] - 5]];
    
    //NSLog(@"downloading url:%@",num_page_url);
    [self add_to_numpagedownload_queue:num_page_url];
    
    [num_page_url release];
    
    self.base_url = _url;
    self.title = t;
    
    //int num_pages = [self get_num_pages:num_page_url];
    
    
       
    //NSLog(@"parse_one_article:%@", [[self ma_msgs] componentsJoinedByString:@"\n"]);
    
    //NSLog(@"string:%@",self.str_msgs);
}


-(void) parse_mitbbs_one_article:(NSString*) url {
    
    
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingDOSChineseSimplif);
    
    NSString *cccstring = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:encoding error:nil];
    
    NSUInteger numberOfMatches = [self.regex_article_posts numberOfMatchesInString:cccstring
                                                                           options:0
                                                                             range:NSMakeRange(0, [cccstring length])];
    //NSRange *range   = [regex rangeOfFirstMatchInString:string
    //options:0 
    //range:NSMakeRange(0, [string length])];
    NSLog(@"#one article message matches:%d", numberOfMatches);
    
    [self.ma_msgs removeAllObjects];
    
    NSArray* msgs = [self.regex_article_posts matchesInString:cccstring options:0 range:NSMakeRange(0, [cccstring length])];
    for (NSTextCheckingResult* m in msgs) {
        //NSLog(@"messages number of groups captured:%d",[m numberOfRanges]);
        //NSRange range_url = [m range];
        NSRange range_url = [m rangeAtIndex:1];
        NSString* str_url = [cccstring substringWithRange:range_url];
        NSString *str_url_no_space =
        [str_url stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* post_no_tag = [self.regex_html_tags stringByReplacingMatchesInString:str_url_no_space options:(0) range:NSMakeRange(0, [str_url_no_space length]) withTemplate:@""];
        //NSLog(@"adding message:%@", post_no_tag);
        [self.ma_msgs addObject:post_no_tag];
    }
}

- (void) dealloc 
{
    NSLog(@"util_download_pages dealloc");
    [_queue release];
    _queue = nil;
    [_queue_numpages release];
    _queue_numpages = nil;
    [super dealloc];
}

- (void) pagedownload_request_done:(ASIHTTPRequest*) request {
    //NSLog(@"DOWNLOADING_PAGES done");
    [self parse_one_page:[request responseData] URL:request.url withPageNum:[request.userInfo objectForKey:@"pagenum"]];
    NSError *error = [request error];
    if (error) {
        NSLog(@"requestFinished Error:%@", error);
    }
}

- (void) pagedownload_request_failed:(ASIHTTPRequest*) request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}

- (void) numpagedownload_request_done:(ASIHTTPRequest*) request {
    //NSLog(@"DOWNLOADING_NUM_PAGES done");
    [self parse_numpages:[request responseData] URL:request.url];
    //NSLog(@"encoding:%d", [request responseEncoding] );
    NSError *error = [request error];
    if (error) {
        NSLog(@"requestFinished Error:%@", error);
    }
}

- (void) numpagedownload_request_failed:(ASIHTTPRequest*) request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}



- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //NSLog(@"Downloader webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //NSLog(@"Downloader webViewDidFinishLoad");       
}

@end
