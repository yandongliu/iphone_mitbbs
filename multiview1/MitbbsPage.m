//
//  MitbbsPage.m
//  multiview1
//
//  Created by Yandong Liu on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MitbbsPage.h"
#import "MitbbsEntry.h"

@implementation MitbbsPage

@synthesize entries = _entries;
@synthesize pagenum = _pagenum;
@synthesize title = _title;

-(NSComparisonResult) compare:(MitbbsPage*)p1 {
    NSLog(@"MitbbsPage compare");
    if (self.pagenum > p1.pagenum) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if (self.pagenum < p1.pagenum) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
}

-(id) initWithPagenum:(int)p Title:(NSString *)t{
    self = [super init];
    if(self) {
        self.title = t;
        self.entries = [[NSMutableArray alloc] init];
        self.pagenum = p;
    }
    return self;
}

-(void) addEntry:(MitbbsEntry*) e{
    [self.entries addObject:e];
}

-(NSString*) get_page_text {
    //@"<b>%@:</b><br/>%@"
    //NSString rc = [NSString string];
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for(MitbbsEntry* e in self.entries)  {
        [array addObject:[NSString stringWithFormat:@"<div class=\"author\">%@:</div><div class=\"message\">%@</div>", e.author, e.body]];
    }
    NSString* str = nil;
    
    if (self.pagenum == 1) {
        str = [NSString stringWithFormat:@"<div class=\"title\">%@</div> <hr /> <div class=\"pagenum\">Page:%d </div><hr />%@", self.title,self.pagenum, [array componentsJoinedByString:@"<hr/>"]];
    } else {
        str = [NSString stringWithFormat:@"<hr /><div class=\"pagenum\">Page:%d </div><hr />%@", self.pagenum, [array componentsJoinedByString:@"<hr/>"]];
    }
    [array release];
    return str;
}
-(void) dealloc {
    [self.entries release];
    self.entries = nil;
    [super dealloc];
}

@end
