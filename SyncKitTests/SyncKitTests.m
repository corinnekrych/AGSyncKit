//
//  SyncKitTests.m
//  SyncKitTests
//
//  Created by Matthias Wessendorf on 10/01/14.
//  Copyright (c) 2014 Red Hat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SyncKit.h"

@interface SyncKitTests : XCTestCase

@end

@implementation SyncKitTests {
    AGSyncClient* _client;
    BOOL _finishRunLoop;
}

//hack:
AGDocument* _testDoc;

- (void)setUp {
    [super setUp];
    
    _client = [AGSyncClient clientFor:[NSURL URLWithString:@"http://localhost:8080/"]];
    
    
}

- (void)tearDown {
    [super tearDown];
}


-(void) test_PUT {
    
    AGDocument *doc = [AGDocument new];
    doc.content = @{@"model": @"Volvo V50", @"color": @"black"};

    
    [_client create:doc success:^(AGDocument *responseObject) {

        XCTAssertNotNil(responseObject.documentID, @"No ID");
        XCTAssertNotNil(responseObject.revision, @"No REV");
        XCTAssertNotNil(responseObject.content, @"No Content");
        
        _testDoc = responseObject;

        _finishRunLoop = YES;

    } failure:^(NSError *error) {
        _finishRunLoop = YES;
        XCTFail(@"Error processing response");
    }];
    
    while(!_finishRunLoop) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void) testGET {
    
    [_client fetch:_testDoc.documentID success:^(AGDocument *responseObject) {
        
        _finishRunLoop = YES;
        XCTAssertTrue([responseObject.revision isEqualToString:_testDoc.revision]);
        
    } failure:^(NSError *error) {
        _finishRunLoop = YES;
        XCTFail(@"Error processing response");
    }];
    
    while(!_finishRunLoop) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}


- (void) testRemove {
    
    [_client remove:_testDoc success:^(NSString *deletedRevision) {
        
        _finishRunLoop = YES;
        XCTAssertNotNil(deletedRevision, @"No revision on delete");

    } failure:^(NSError *error) {
        _finishRunLoop = YES;
        XCTFail(@"Error processing response");
    }];
    
    while(!_finishRunLoop) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

@end
