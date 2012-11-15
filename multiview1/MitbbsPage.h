//
//  MitbbsPage.h
//  multiview1
//
//  Created by Yandong Liu on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MitbbsEntry.h"

@interface MitbbsPage : NSObject

@property (assign, nonatomic) int pagenum;
@property (copy) NSString *title;
@property (nonatomic, retain) NSMutableArray* entries;

-(id) initWithPagenum:(int)p Title:(NSString*)t;
-(void) addEntry:(MitbbsEntry*) e;
-(NSString*) get_page_text;
-(NSComparisonResult) compare:(MitbbsPage*)p1;

@end
