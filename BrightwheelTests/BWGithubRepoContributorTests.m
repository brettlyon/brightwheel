//
//  BWGithubRepoContributorTests.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BWGithubRepoContributorTests : XCTestCase

@end

@implementation BWGithubRepoContributorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

// Test passed valid dictionary

// Test passed nil

// Test passed array

// Test passed dictionary missing login
// Expected result: name should be set to 'anonymous'

// Test passed dictionary missing contributions
// Expected result: contributions should be 0

@end
