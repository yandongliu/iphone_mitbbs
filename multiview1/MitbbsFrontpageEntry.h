//
//  MitbbsFrontpageEntry.h
//  multiview1
//
//  Created by Yandong Liu on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MitbbsFrontpageEntry : NSObject

@property (copy) NSString *title;
@property (copy) NSString *url;
@property (copy) NSString *category;


- (id)initWithTitle:(NSString*)t URL:(NSString*)u Category:(NSString*) c;

@end
