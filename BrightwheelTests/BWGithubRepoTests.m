//
//  BWGithubRepoTests.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BWGithubAPIResponseMocker.h"
#import "BWGithubRepo.h"

@interface BWGithubRepoTests : XCTestCase

@end

@implementation BWGithubRepoTests

#pragma mark - Helper methods

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 Multiple object construction tests
 */

// Test when passed a valid array
// Expected result: should return an array (with same number of members) of repos
- (void)testReposFromArrayWithValidArray {
    NSArray *repoDictionaryArray = [BWGithubAPIResponseMocker validRepoArray];
    NSArray *repos = [BWGithubRepo reposFromArray:repoDictionaryArray];
    
    XCTAssertNotNil(repos, @"Should not pass back nil");
    XCTAssertEqual(repoDictionaryArray.count, repos.count, @"Number of repos in the array of repo dictionaries should match the number of repos in the array of repo objects returned.");
    
    XCTAssertTrue([[repos firstObject] isKindOfClass:[BWGithubRepo class]], @"The objects in the returned repo array should be of class BWGithubRepo.");

}

// Test when passed a repo array that contains an invalid repo
// Expected result: invalid repo shouldn't be included in the the resulting array (one fewer repo in the returned array)

// Test construction when passed nil
// Expected result: should return empty array
- (void)testReposFromArrayWithNil {
    NSArray *repos = [BWGithubRepo reposFromArray:nil];
    
    XCTAssertNotNil(repos, @"Should not pass back nil");
}

// Test construction when passed a dictionary
// Expected result: should return empty array
- (void)testReposFromArrayWithDictionary {
    NSDictionary *dictionary = @{};
    NSArray *repos = [BWGithubRepo reposFromArray:(NSArray *)dictionary];
    
    XCTAssertNotNil(repos, @"Should not pass back nil");
    XCTAssertEqual(repos.count, 0, @"If the array parameter is actually a dictionary, an empty array should be returned");
}

// Test construction when passed an empty array
// Expected result: should return empty array
- (void)testReposFromArrayWithEmptyArray {
    NSArray *array = @[];
    NSArray *repos = [BWGithubRepo reposFromArray:array];
    
    XCTAssertNotNil(repos, @"Should not pass back nil");
    XCTAssertEqual(repos.count, 0, @"If an empty array of repo dictionaries is passed, an empty array should be returned");
}


/*
 Single object construction tests
 */

// Test construction of object with valid dictionary
// Expected result: should successfully populate object
- (void)testRepoFromDictionaryWithValidRepoDictionary {
    NSDictionary *repoDictionary = [BWGithubAPIResponseMocker validRepoDictionary];
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:repoDictionary];
    
    NSString *fullName = repoDictionary[@"full_name"];
    NSString *description = repoDictionary[@"description"];
    NSString *name = repoDictionary[@"name"];
    NSNumber *stars = repoDictionary[@"watchers_count"];
    
    NSDictionary *ownerDictionary = repoDictionary[@"owner"];
    NSString *owner = ownerDictionary[@"login"];
    
    XCTAssertNotNil(repo, @"Should not return nil if passed a valid repo dictionary");
    XCTAssertTrue([repo isKindOfClass:[BWGithubRepo class]], @"Resulting repo should belong to class BWGithubRepo");
    XCTAssertTrue([repo.fullName isEqualToString:fullName], @"fullName on resulting repo object should be equal to the full_name field in the passed repo dictionary");
    XCTAssertTrue([repo.repoDescription isEqualToString:description], @"repoDescription on resulting repo object should be equal to the description field in the passed repo dictionary");
    XCTAssertTrue([repo.name isEqualToString:name], @"name on resulting repo object should be equal to the name field in the passed repo dictionary");
    XCTAssertTrue([repo.owner isEqualToString:owner], @"owner on resulting repo object should be equal to the owner login field in the passed repo dictionary");
    XCTAssertEqual(repo.numStars, [stars integerValue], @"numStars on resulting repo object should be equal to the watchers_count field in the passed repo dictionary");
}

// Test construction being passed nil
// Expected result: should return nil
- (void)testRepoFromDictionaryPassingNil {
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:nil];
    
    XCTAssertNil(repo, @"If passed nil, should return nil");
}

// Test construction with empty dictionary
// Expected result: should return nil
- (void)testRepoFromDictionaryPassingEmptyDictionary {
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:@{}];
    
    XCTAssertNil(repo, @"If passed an empty dictionary, should return nil");
}

// Test construction with array
// Expected result: should return nil
- (void)testRepoFromDictionaryPassingArray {
    NSDictionary *arrayHidingAsDictionary = (NSDictionary *)@[];
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:arrayHidingAsDictionary];
    
    XCTAssertNil(repo, @"If passed an array, should return nil");
}

// Test full name not present
// Expected result: should return an object with the full name constructed from the owner login and the name field
- (void)testRepoFromDictionaryMissingFullName {
    NSDictionary *repoDictionaryMissingFullName = [BWGithubAPIResponseMocker repoDictionaryMissingFullName];
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:repoDictionaryMissingFullName];
    
    NSString *repoName = repoDictionaryMissingFullName[@"name"];
    NSDictionary *ownerDictionary = repoDictionaryMissingFullName[@"owner"];
    NSString *owner = ownerDictionary[@"login"];
    NSString *expectedFullName = [NSString stringWithFormat:@"%@/%@", owner, repoName];
    
    XCTAssertTrue([repo.fullName isEqualToString:expectedFullName], @"If passed a repo dictionary missing the full_name field, fullName should be constructed from name and owner login fields in the form '<owner login>/<name>'");
}

// Test description not present
// Expected result: should return and object with a description (it will be a placeholder)
- (void)testRepoFromDictionaryMissingDescription {
    NSDictionary *repoDictionaryMissingDescription = [BWGithubAPIResponseMocker repoDictionaryMissingDescription];
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:repoDictionaryMissingDescription];
    
    XCTAssertNotNil(repo.repoDescription, @"If passed a repo dictionary missing a description field, repoDescription should be a placeholder and therefore not be nil");
    XCTAssertGreaterThan(repo.repoDescription.length, 0, @"If passed a repo dictionary missing a description field, repoDescription should be placeholder and therefore have a length greater than 0");
}

// Test owner login not present
// Expected result: should return an object with owner = 'anonymous'

- (void)testRepoFromDictionaryMissingOwnerLogin {
    NSDictionary *repoDictionaryMissingOwnerLogin = [BWGithubAPIResponseMocker repoDictionaryMissingOwnerLogin];
    BWGithubRepo *repo = [BWGithubRepo repoFromDictionary:repoDictionaryMissingOwnerLogin];
    
    XCTAssertTrue([repo.owner isEqualToString:@"anonymous"], @"If the repo dictionary has no owner or owner login, owner on the repo object should be 'anonymous'");
}

@end
