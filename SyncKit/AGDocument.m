//
//  AGDocument.m
//  SyncKit
//
//  Created by Matthias Wessendorf on 10/01/14.
//  Copyright (c) 2014 Red Hat. All rights reserved.
//

#import "AGDocument.h"

@implementation AGDocument

@synthesize documentID = _documentID;
@synthesize revision = _revision;
@synthesize content = _content;

-(id) initWithID:(NSString*) documentID revision:(NSString*) revision {
    self = [super init];
    if (self) {
        _documentID = documentID;
        _revision = revision;
    }

    return self;
}


@end

