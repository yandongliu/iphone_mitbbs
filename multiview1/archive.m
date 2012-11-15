//
//  archive.c
//  multiview1
//
//  Created by Yandong Liu on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 Scroll to bottom
 Scroll to top
 Image switch
 all pages download switch
 full screen switch
 feedback channel
 1 downloading indicator
 1 pull up to update
 table cell detail text (category)
 1 remove blank lines
 1 fold quoted content
 ? hyperlink recog
 ? reformat post
 super compact reading mode
 change font size resets to top
 - repeated downloading
 - encoding 261
 - downloading requests finished in diff order. need to reorder msgs
 load first page. then update with all pages. incremental post downloading
 */


#import "archive.h"

@implementation archive

/*
-(void) scrollViewWillBeginDragging2:(UIScrollView *)scrollView {
    NSLog(@"willbegindragging.");
}

-(void) scrollViewDidScroll2:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:nil];
    if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
        // User is scrolling above the header
        //self.label.text = @"release";
        NSLog(@"releasing?");
        //[refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        [self refresh];
    } else { // User is scrolling somewhere within the header
        //self.label.text = @"pull";
        //[refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
    [UIView commitAnimations];
}
*/

//NSStringEncoding enc= CFStringConvertNSStringEncodingToEncoding(kCFStringEncodingGB_2312_80);

//NSString* new_str = [str_title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//NSString* new_str2 = [str_title stringByReplacingPercentEscapesUsingEncoding:enc];

//const char *cstr = [str_title UTF8String];
//NSLog(@"%@", str_title);
//printf("%s\n", cstr);
//NSLog(@"%@", [NSString stringWithUTF8String:cstr]);


//[str_chinese gete

//char temp[200];
//strcpy(temp, [str_title cStringUsingEncoding:NSUTF16LittleEndianStringEncoding]);


//NSLog(@"title:%@, url:%@, new_str:%S, new_str3:%S", str_title, str_url, new_str, new_str2);

@end
