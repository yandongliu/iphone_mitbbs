//
//  ArticleContentViewControllerWebView.h
//  multiview1
//
//  Created by Yandong Liu on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMLTool.h"
#import "TapDetectingWindow.h"
#import "VCSourceCode.h"
#import "WEPopoverController.h"
#import "VCTableRightTopBtn.h"
#import "AllViewControllers.h"


@class AllViewControllers;

@interface ArticleContentViewControllerWebView : UIViewController  <UIWebViewDelegate, PopoverControllerDelegate,TapDetectingWindowDelegate>
{
    //NSMutableString* resultString;
    TapDetectingWindow *mWindow;
    WEPopoverController *navPopover;
    UIBarButtonItem* right_btn;
   
}

@property (retain, nonatomic) AllViewControllers* allVC;
@property (strong, nonatomic) IBOutlet UIWebView* webview;
@property (strong, nonatomic) IBOutlet UISlider* slider;
@property (copy, nonatomic) NSString* text;
@property (copy, nonatomic) NSString* full_html;
@property (copy, nonatomic) NSString* posturl;
@property (copy, nonatomic) NSString* posttitle;
@property (copy, nonatomic) NSString* postname;
@property (copy, nonatomic) NSString* postcaption;
@property (copy, nonatomic) NSString* postdesc;
@property(strong,nonatomic) UINavigationController *global_nc;
@property(assign, nonatomic) BOOL topbarHidden;
@property int global_fontsize;
//@property int value;
-(IBAction) fontsize_slider_changed:(id)sender;
-(void) btn_bottom_touched;
-(void) btn_top_touched;
-(IBAction) btn_eval_js:(id)sender;

//-(IBAction) webview_touched:(id)sender;

- (void) __clearWebView;
//- (void) __reloadWebView;
- (void) webview_addtext:(NSString*) text;
- (void) webview_clear_content;
//- (void) init_webview;
- (void) print_init_content;
- (void) reloadWebView;
- (void) dismissPopOver;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers *)a;
@end
