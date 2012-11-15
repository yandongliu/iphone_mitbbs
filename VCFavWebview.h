//
//  VCFavWebview.h
//  multiview1
//
//  Created by Mac User on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCFavWebview : UIViewController

@property (retain, nonatomic) IBOutlet UIWebView* webview;
@property (copy) NSString* text;
@property (copy, nonatomic) NSString* full_html;
@property int global_fontsize;

- (void) reloadWebView;
@end
