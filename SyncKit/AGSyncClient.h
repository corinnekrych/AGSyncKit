//
//  AGSyncClient.h
//  SyncKit
//
//  Created by Matthias Wessendorf on 10/01/14.
//  Copyright (c) 2014 Red Hat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AGDocument.h"

@interface AGSyncClient : AFHTTPSessionManager

+ (AGSyncClient *) clientFor:(NSURL *)url;

- (void) create:(AGDocument *) document
        success:(void (^)(AGDocument *responseObject))success
        failure:(void (^)(NSError *error))failure;

- (void) fetch:(NSString *) documentID
       success:(void (^)(AGDocument *responseObject))success
       failure:(void (^)(NSError *error))failure;

//- (void) update:(AGDocument *) document
//        success:(void (^)(AGDocument *responseObject))success
//        failure:(void (^)(NSError *error))failure;
//

- (void) remove:(AGDocument *) document
        success:(void (^)(NSString *deletedRevision))success
        failure:(void (^)(NSError *error))failure;

@end
