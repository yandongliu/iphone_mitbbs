//
//  VCSourceCode.h
//  multiview1
//
//  Created by Yandong Liu on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCSourceCode : UIViewController


@property (retain, nonatomic) IBOutlet UITextView* text_view;


-(void) update_text:(NSString*) str;

-(IBAction) btn_update_text:(id)sender;
@end
