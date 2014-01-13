//
//  AGSyncClient.m
//  SyncKit
//
//  Created by Matthias Wessendorf on 10/01/14.
//  Copyright (c) 2014 Red Hat. All rights reserved.
//

#import "AGSyncClient.h"

@implementation AGSyncClient {
    
}

+ (AGSyncClient *) clientFor:(NSURL *)url {
    return [[self alloc] initWithBaseURL:url];
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // by default the DELETE request is putting param into the query string...
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];

    return self;
}

- (void) create:(AGDocument *) document
        success:(void (^)(AGDocument *responseObject))success
        failure:(void (^)(NSError *error))failure {

    id payload = @{@"content": document.content};
    NSString *uuid = [[NSUUID UUID] UUIDString];

    [self PUT:uuid parameters:payload success:^(NSURLSessionDataTask *task, id responseObject) {

        if (success) {

            AGDocument* responseDoc = [[AGDocument alloc] initWithID:responseObject[@"id"] revision:responseObject[@"rev"]];
            responseDoc.content = responseObject[@"content"];

            success(responseDoc);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)fetch:(NSString *)documentID
     success:(void (^)(AGDocument *))success
     failure:(void (^)(NSError *))failure {

    [self GET:documentID parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {

            AGDocument* responseDoc = [[AGDocument alloc] initWithID:responseObject[@"id"] revision:responseObject[@"rev"]];
            responseDoc.content = responseObject[@"content"];

            success(responseDoc);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void) remove:(AGDocument *) document
        success:(void (^)(NSString *deletedRevision))success
        failure:(void (^)(NSError *error))failure {

    id payload = @{@"rev": document.revision};

    [self DELETE:document.documentID parameters:payload success:^(NSURLSessionDataTask *task, id responseObject) {

        if (success) {
            success(responseObject[@"rev"]);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
