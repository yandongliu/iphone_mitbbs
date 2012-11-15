//
//  Util_download_pages.h
//  multiview1
//
//  Created by Yandong Liu on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "MyUtils.h"
#import "MainViewController.h"
#import "AllViewControllers.h"
#define DOWNLOADING_IDLE 0
#define DOWNLOADING_NUM_PAGES 1
#define DOWNLOADING_PAGES 2

//@class view1;
@class AllViewControllers;

@interface Util_download_pages : NSObject <UIWebViewDelegate> {
    //view1* _view1;
    int DOWNLOADING;
}

//-(id) initWithView1:(view1*) __view1;
-(id) initWithAllVC:(AllViewControllers*) a;

@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSOperationQueue *queue_numpages;

@property (nonatomic, copy) NSString* base_url;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) AllViewControllers* allVC;

@property (nonatomic, retain) NSRegularExpression* regex_article_posts;
@property (nonatomic, retain) NSRegularExpression* regex_html_tags;
@property (nonatomic, retain) NSRegularExpression* regex_quotes;
@property (nonatomic, retain) NSRegularExpression* regex_blank_lines;
@property (nonatomic, retain) NSRegularExpression* regex_num_pages;
@property (nonatomic, retain) NSRegularExpression* regex_each_page_num;
@property (nonatomic, retain) NSRegularExpression* regex_author_body;
@property (nonatomic, retain) NSRegularExpression* regex_unsupported_obj;
@property (nonatomic, retain) NSRegularExpression* regex_imgsrc;
@property (nonatomic, retain) NSRegularExpression* regex_signature;

@property (nonatomic, retain) NSMutableArray* ma_msgs;

-(void) parse_mitbbs_one_article_all_pages_with_baseurl:(NSString*) _url Title:(NSString*)t ;

- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
@end
