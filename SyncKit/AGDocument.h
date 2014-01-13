//
//  AGDocument.h
//  SyncKit
//
//  Created by Matthias Wessendorf on 10/01/14.
//  Copyright (c) 2014 Red Hat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGDocument : NSObject

@property (nonatomic, readonly) NSString* documentID;
@property (nonatomic, readonly) NSString* revision;
@property id content;

// not sure I like that ctor....
-(id) initWithID:(NSString*) documentID revision:(NSString*) revision;

@end
