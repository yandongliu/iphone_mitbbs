//
//  MitbbsEntry.m
//  multiview1
//
//  Created by Yandong Liu on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MitbbsEntry.h"

@implementation MitbbsEntry

@synthesize author = _author;
@synthesize body = _body;


- (id)initWithBody:(NSString *)b withAuthor:(NSString *)a
{
    if ((self = [super init])) {
        self.author = a;
        self.body = b;
    }
    return self;
}

- (void)dealloc {
    [_body release];
    _body = nil;
    [_author release];
    _author = nil;
    [super dealloc];
}

@end
