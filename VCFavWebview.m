//
//  VCFavWebview.m
//  multiview1
//
//  Created by Mac User on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VCFavWebview.h"

@interface VCFavWebview ()

@end

@implementation VCFavWebview
@synthesize webview;
@synthesize text;
@synthesize full_html;
@synthesize global_fontsize;

- (void) reloadWebView
{
    
    NSString* css = [NSString stringWithFormat:@"body{font-size:%dpx;}.title{background:#CAE8EA;font-size:%dpx;color:#000066;}.pagenum{color:#000066;}.author{background: #9999ff;font-weight:bold;}.message{} hr {border: 0;border-bottom: 1px dashed #ccc;background: #999;}", self.global_fontsize, self.global_fontsize+2];
    
    // NSString* javascript = [NSString stringWithString:@"<script src=\"http://www.mitbbs.com/im/js/im.js\" type=\"text/javascript\"></script><script src=\"http://www.mitbbs.com/js/prototype.js\" type=\"text/javascript\"></script><script language=\"JavaScript\" src=\"http://www.mitbbs.com/newindex/index.js\"></script><script type=\"text/javascript\" src=\"http://www.mitbbs.com/mitbbs_flash.js\"></script><script type=\"text/javascript\" language=\"javascript\" src=\"http://www.mitbbs.com/virtual_shape/xnxx.js\"></script><script src=\"http://www.mitbbs.com/js/service.js\" type=\"text/javascript\"></script>"];
    NSString* javascript =@"var gjswidth=304;function adjustimg(objimg){if(objimg.width>gjswidth) {objimg.width=gjswidth;}} function pagescroll(offset) {window.scrollBy(0,offset);}";
    
    NSLog(@"reloadWebView");
    NSString* pre_html =[[NSString alloc] initWithFormat: @"<html><head><style type=\"text/css\">%@</style><script language=\"javascript\">%@</script></head><body><p id=\"messages\"></p>",css, javascript];
    NSString* post_html=@"</body></html>";
    self.full_html = [[NSString alloc] initWithFormat:@"%@%@%@", pre_html, self.text, post_html];
    //NSLog(@"webview html:%@", full_html);
    [self.webview loadHTMLString:self.full_html baseURL:nil];
    [pre_html release];
    //[full_html release];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.global_fontsize=16;
    self.text=@"";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
