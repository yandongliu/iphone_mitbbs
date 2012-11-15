//
//  MitbbsFrontpageEntry.m
//  multiview1
//
//  Created by Yandong Liu on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MitbbsFrontpageEntry.h"

@implementation MitbbsFrontpageEntry

@synthesize title  = _title;
@synthesize url = _url;
@synthesize category = _category;


- (id)initWithTitle:(NSString *)t URL:(NSString *)u Category:(NSString*) c
{
    if ((self = [super init])) {
        self.title = t;
        self.url = u;
        self.category = c;
    }
    return self;
}

- (void)dealloc {
    [_title release];
    _title = nil;
    [_url release];
    _url = nil;
    [super dealloc];
}

@end
