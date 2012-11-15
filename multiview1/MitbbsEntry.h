//
//  MitbbsEntry.h
//  multiview1
//
//  Created by Yandong Liu on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MitbbsEntry : NSObject

@property (copy) NSString *author;
@property (copy) NSString *body;


- (id)initWithBody:(NSString*)body withAuthor:(NSString*)author;

@end
