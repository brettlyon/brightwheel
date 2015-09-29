//
//  BWGithubRepoContributorTests.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BWGithubRepoContributor.h"
#import "BWGithubAPIResponseMocker.h"

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

// Test constructing contributor with valid dictionary
// Expected result: should return conrtibutor object with properties set correctly
- (void)testContributorWithDictionaryPassingValidDictionary {
    NSDictionary *contributorDictionary = [BWGithubAPIResponseMocker validContributorDictionary];
    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:contributorDictionary];
    
    NSString *contributorName = contributorDictionary[@"login"];
    NSNumber *contributions = contributorDictionary[@"contributions"];
    
    XCTAssertNotNil(contributor, @"Returned contributor object should not be nil");
    XCTAssertTrue([contributor.name isEqualToString:contributorName], @"name property on returned contributor object should be equal to the value of the 'login' field in the contributor dictionary");
    XCTAssertEqual(contributor.contributions, [contributions integerValue], @"contributions property on returned contributor object should be equal to the value of the 'contribution' field in the contributor dictionary");
}

// Test constructing contributor passing nil
// Expected result: should return nil
- (void)testContributorWithDictionaryPassingNil {
    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:nil];
    
    XCTAssertNil(contributor, @"If passed nil, should return nil");
}

// Test constructing contributor passing array
// Expected result: should return nil
- (void)testContributorWithDictionaryPassingArray {
    NSDictionary *arrayHidingAsDictionary = (NSDictionary *)@[];
    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:arrayHidingAsDictionary];
    
    XCTAssertNil(contributor, @"If passed an array, should return nil");
}

// Test constructing contributor passing dictionary missing login
// Expected result: name should be set to 'anonymous'
- (void)testContributorWithDictionaryPassingDictionaryMissingLogin {
    NSDictionary *contributorDictionaryMissingLogin = [BWGithubAPIResponseMocker contributorDictionaryMissingLogin];
    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:contributorDictionaryMissingLogin];
    
    XCTAssertTrue([contributor.name isEqualToString:@"anonymous"], @"If the passed contributor dictionary is missing the login field, the name should be set to 'anonymous'");
}

// Test constructing contributor passing dictionary missing contributions
// Expected result: contributions should be 0
- (void)testContributorWithDictionaryPassingDictionaryMissingContributions {
    NSDictionary *contributorDictionaryMissingContributions = [BWGithubAPIResponseMocker contributorDictionaryMissingContributions];
    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:contributorDictionaryMissingContributions];
    
    XCTAssertEqual(contributor.contributions, 0, @"If the passed contributor dictionary is missing the 'contributions' field, the contributions property should be set to 0");
}

@end
