//
//  ArticleContentViewControllerWebView.m
//  multiview1
//
//  Created by Yandong Liu on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleContentViewControllerWebView.h"

@implementation ArticleContentViewControllerWebView

@synthesize webview = _webview;
@synthesize text = _text;
@synthesize global_fontsize = _fontsize;
@synthesize slider = _slider;
@synthesize global_nc = _global_nc;
@synthesize full_html = _full_html;
@synthesize allVC;
@synthesize posturl;
@synthesize posttitle;
@synthesize postcaption;
@synthesize postname;
@synthesize postdesc;
@synthesize topbarHidden = _topbarHidden;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers *)a {
    NSLog(@"webview initWithNibName");
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.allVC = a;
        self.topbarHidden=FALSE;
    }
    return self;
}


- (void) dismissPopOver {
    NSLog(@"dismissPopOver");
    [navPopover dismissPopoverAnimated:YES];
    [navPopover setDelegate:nil];
    [navPopover release];
    navPopover = nil;
}

-(IBAction) show_popover{
    NSLog(@"func show_popover");
    if(!navPopover) {
        NSLog(@"new popover");
        //VCTableRightTopBtn* table = [[[VCTableRightTopBtn alloc] initWithStyle:UITableViewStylePlain withWebView:self] autorelease];
        VCTableRightTopBtn* table = [[[VCTableRightTopBtn alloc] initWithStyle:UITableViewStylePlain withAllVC:self.allVC] autorelease];
        if(self.posttitle==nil) {
            self.posttitle=@"mitbbs.com";
        }
        table.name=self.posttitle;
        if(self.posturl==nil)
            self.posturl=@"http://www.mitbbs.com";
        table.link=self.posturl;
        table.caption=@"caption";
        if(self.postdesc==nil)
            self.postdesc=@"description";
        table.desc=self.postdesc;
        table.content=self.text;
        navPopover = [[WEPopoverController alloc] initWithContentViewController:table];
        //[table release];
        [navPopover setDelegate:self];
    } 
    
    if([navPopover isPopoverVisible]) {
        [self dismissPopOver];
    } else {
        NSLog(@"pop popover");
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        //[navPopover presentPopoverFromRect:CGRectMake(70, 80, 50, 57)
        [navPopover presentPopoverFromRect:CGRectMake(screenBounds.size.width, 0, 30, 0)
        //[navPopover presentPopoverFromRect:right_btn.
                                    inView:self.view
                  permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown
                                  animated:YES];
    }
    
}


- (void)popoverControllerDidDismissPopover:(WEPopoverController *)popoverController {
    
    NSLog(@"Did dismiss");
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)popoverController {
    NSLog(@"Should dismiss");
    return YES;
}

//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s {
//    [resultString appendString:s];
//    NSLog(@"converted:%@", resultString);
//}

//- (NSString*)convertEntiesInString:(NSString*)s {
//    if(s == nil) {
//        NSLog(@"ERROR : Parameter string is nil");
//    }
//    NSString* xmlStr = [NSString stringWithFormat:@"<d>%@</d>", s];
//    NSData *data = [xmlStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    NSXMLParser* xmlParse = [[NSXMLParser alloc] initWithData:data];
//    [xmlParse setDelegate:self];
//    [xmlParse parse];
//    return [NSString stringWithFormat:@"%@",resultString];
//}

-(IBAction) btn_eval_js:(id)sender {
    
    NSLog(@"btn_eval_js");
    
    NSString* js_get_current_content = [[NSString alloc] initWithFormat:@"document.getElementById('text_test').innerHTML;"];

    NSString* current_content = [self.webview stringByEvaluatingJavaScriptFromString:js_get_current_content];

    [self print_init_content];
    
//    NSString* js_update_content = [[NSString alloc] initWithFormat:@"document.getElementById('text_test').innerHTML = '%@,Fred Flinstone <b>strong</b> %@<br />';", [current_content gtm_stringByUnescapingFromHTML], [self.text gtm_stringByUnescapingFromHTML]];
    NSString* js_update_content = [[NSString alloc] initWithFormat:@"document.getElementById('text_test').innerHTML = '%@,Fred Flinstone <b>strong</b> %@<br />';", [current_content gtm_stringByUnescapingFromHTML], @"<b>原来也没有反对这些东西的念头 </b> <hr />"];

    //NSLog(@"text:%@", self.text);
    //NSLog(@"Google convert:%@", [self.text gtm_stringByUnescapingFromHTML]);
    NSString* rc= [self.webview stringByEvaluatingJavaScriptFromString:js_update_content];
    NSLog(@"btn_eval_js java eval result:%@", rc);

    [js_get_current_content release];
    [js_update_content release];
    
}

- (void) webview_addtext:(NSString*) text {
   
    
    NSString* js_get_current_content = [[NSString alloc] initWithFormat:@"document.getElementById('messages').innerHTML;"];
    NSString* current_content= [[self.webview stringByEvaluatingJavaScriptFromString:js_get_current_content] gtm_stringByUnescapingFromHTML];
    
    NSLog(@"get current content:%@", current_content);
    
    NSString* js_update_content = [[NSString alloc] initWithFormat:@"document.getElementById('messages').innerHTML='%@,%@';", current_content, text];
    NSString* rc= [self.webview stringByEvaluatingJavaScriptFromString:js_update_content];
    NSLog(@"java adding content:%@",[text gtm_stringByUnescapingFromHTML]);
    //[self convertEntiesInString:text];
    
    NSLog(@"addtext java eval result:%@", rc);
    
    [js_get_current_content release];
    [js_update_content release];
    
     //[self btn_eval_js:nil];
//    
//    for(int i=0;i<10;i++) {
//        //[NSThread sleepForTimeInterval:1];
//        for(int j=0;j<100000;j++) {
//            
//        }
//        [self btn_eval_js:nil];
//    }
    
}


- (void) webview_clear_content {
    
    NSString* js_update_content = [[NSString alloc] initWithFormat:@"document.getElementById('messages').innerHTML = 'cleared';"];
    NSString* rc= [self.webview stringByEvaluatingJavaScriptFromString:js_update_content];
    
    NSLog(@"clear java eval result:%@", rc);

    [js_update_content release];
    
}

- (void) loadContent:(NSString*) html
{
    NSString* pre_html =[[NSString alloc] initWithFormat: @"<html><body style=\"font-size:%dpx;color:#008888;\"><p id=\"messages\">__inited</p>",self.global_fontsize];
    NSString* post_html=@"</body></html>";
    NSString* full_html = [[NSString alloc] initWithFormat:@"%@%@%@", pre_html, self.text, post_html];
    //NSLog(@"webview html:%@", full_html);
    [self.webview loadHTMLString:full_html baseURL:nil];
    [pre_html release];
    [full_html release];
}

- (void) __clearWebView
{
    self.text=@"";
    [self.webview loadHTMLString:@"" baseURL:nil];
}

-(void) show_source_code {
    NSLog(@"Show source code");
    NSLog(@"source:%@", [self.text substringToIndex:100]);
    VCSourceCode * vc = [[VCSourceCode alloc]initWithNibName:@"VCSourceCode" bundle:nil];

    
    
    [self.navigationController pushViewController:vc animated:TRUE];
    NSLog(@"vc text addresss:%@", vc.text_view);
    //vc.text_view.text = @"AAAA";
    [vc update_text:self.full_html];
    [vc release];
}

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
    
    right_btn = [[UIBarButtonItem alloc]  initWithTitle:@"Tools" style:UIBarButtonItemStylePlain target:self action:@selector(show_popover)];
    self.navigationItem.rightBarButtonItem = right_btn;

    [right_btn release];
    NSLog(@"right btn added");
}

-(void) _init_webview {
    NSLog(@"init_webview");
    NSString* str = [ NSString stringWithFormat:@"messages:nothing here"];
    NSString* pre_html =[[NSString alloc] initWithFormat: @"<html><body style=\"font-size:%dpx;background-color:#b0c4de;\"><p id=\"messages\">%@</p><p id=\"text_test\">text_test init</p></body></html>",self.global_fontsize, str];
    [self.webview loadHTMLString:pre_html baseURL:nil];
    [pre_html release];
}

-(void)btn_bottom_touched
{
    NSLog(@"btn_bottom_touched");
    [self.webview stringByEvaluatingJavaScriptFromString:@"window.scrollTo(0, document.body.scrollHeight);"];
}

-(void)btn_top_touched
{
    NSLog(@"btn_top_touched");
    [self.webview stringByEvaluatingJavaScriptFromString:@"window.scrollTo(0,0);"];
}


-(IBAction)fontsize_slider_changed:(id)sender 
{
    UISlider* slider = (UISlider*)sender;
    self.global_fontsize = [slider value];
    
    NSString* pre_html =[[NSString alloc] initWithFormat: @"<html><body style=\"font-size:%dpx;\">",self.global_fontsize];
    NSString* post_html=@"</body></html>";
    NSString* full_html = [[NSString alloc] initWithFormat:@"%@%@%@", pre_html, self.text, post_html];
    [self.webview loadHTMLString:full_html baseURL:nil];
    [pre_html release];
    [full_html release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //NSLog(@"webview initWithNibName begins");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }

    NSLog(@"webview initWithNibName ends");
    return self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidFinishLoad");
    //[self init_webview];
    [self print_init_content];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) print_init_content {
    NSLog(@"print_init_content");
    NSString* js_cur_content = [[NSString alloc] initWithFormat:@"document.getElementById('text_test').innerHTML;"];
    NSString* rc= [self.webview stringByEvaluatingJavaScriptFromString:js_cur_content];
    NSLog(@"init content:%@", rc);
    [js_cur_content release];
}

- (void) _scrollDownOnePage
{
    NSLog(@"scrollDownOnePage");
    [self.webview stringByEvaluatingJavaScriptFromString:@"window.scrollBy(0, 345);"];
}

- (void )_scrollUpOnePage
{
    NSLog(@"scrollUpOnePage");
    [self.webview stringByEvaluatingJavaScriptFromString:@"window.scrollBy(0,-345);"];
}

- (void) hideTabBar:(UITabBarController *) tabbarcontroller {
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
        } 
        else 
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
        }
        
    }
    
    [UIView commitAnimations];
}
- (void) showTabBar:(UITabBarController *) tabbarcontroller {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        NSLog(@"%@", view);
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
            
        } 
        else 
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
        }
        
        
    }
    
    [UIView commitAnimations]; 
}

- (void) userDidTapWebView:(id)tapPoint {
    self.topbarHidden=!self.topbarHidden;
    if(self.topbarHidden) {
        [self.allVC.nc_main setNavigationBarHidden:TRUE];
        [self hideTabBar:self.allVC.tabBarController];
    } else {
        [self.allVC.nc_main setNavigationBarHidden:FALSE];
        [self showTabBar:self.allVC.tabBarController];
    }
}

- (void) _userDidTapWebView:(id)tapPoint {
    
    //[tapPoint x]
    //NSLog(@"tapped:%@", tapPoint);
    //NSLog(@"tap at x = %@, y = %@", [tapPoint objectAtIndex:0], [tapPoint objectAtIndex:1]);
    float f = [[tapPoint objectAtIndex:1] floatValue];
    NSLog(@"%f", f);
    self.topbarHidden=!self.topbarHidden;
    
    if(self.topbarHidden) {

        [self.allVC.nc_main setNavigationBarHidden:TRUE];
        CGRect bounds = [[UIScreen mainScreen] bounds];
        NSLog(@"h:%f", bounds.size.height);
        CGRect tabBarFrame = self.allVC.tabBarController.tabBar.frame;
        CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
        self.allVC.tabBarController.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height+tabBarFrame.size.height);
    //self.allVC.tabBarController.toolBar.hidden = NO;
    //CGRect frame = self.allVC.tabBarController.tabBar.frame;
    //frame.origin.y = bounds.size.height - frame.size.height +40;
    //self.allVC.tabBarController.tabBar.frame=frame;
    
    //self.allVC.tabBarController.tabBar.hidden=self.topbarHidden;
    } else {
        [self.allVC.nc_main setNavigationBarHidden:FALSE];
        CGRect bounds = [[UIScreen mainScreen] bounds];
        NSLog(@"h:%f", bounds.size.height);
        CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
        //self.allVC.tabBarController.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height-navigationBarFrame.size.height);
    }



    /*
    if ( f >= 0.0 && f<=100.0) {
        [self _scrollUpOnePage];
    }
    if ( f >= 250.0 && f<=350.0) {
        [self _scrollDownOnePage];
    }
     */
    //0 - 100 top
    //250 - 350 bottom
    //CGPoint p;
    //NSLog(@"Y:%f", p.y);
    //NSLog("%f", [p fl );
    /*
    switch ([self.global_nc isNavigationBarHidden]) {
        case TRUE:
            [self.global_nc setNavigationBarHidden:FALSE];
            break;
        case FALSE:
            [self.global_nc setNavigationBarHidden:TRUE];
            break;
    }
     */
}

- (void)viewDidLoad
{
    NSLog(@"webview viewDidLoad");
    [super viewDidLoad];
    //resultString = [[NSMutableString alloc] init];
    self.global_fontsize=16;
    self.text=@"";
    
    //[self init_webview];
    //[self print_init_content];

    //NSLog(@"webview viewDidLoad ends");
    
    

    
    mWindow = (TapDetectingWindow *)[[UIApplication sharedApplication].windows objectAtIndex:0];
    mWindow.viewToObserve = self.view;
    mWindow.controllerThatObserves = self;
    
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    NSLog(@"webview viewdidunload");
    [super viewDidUnload];
    //[resultString release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {
    [self.full_html release];
    [super dealloc];
}

@end
