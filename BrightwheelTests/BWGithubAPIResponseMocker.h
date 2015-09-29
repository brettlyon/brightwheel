//
//  BWGithubAPIResponseMocker.h
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 This class provides mock responses from the Github API, facilitating synchronous unit testing of objects that interact with the API.
 
 */

@interface BWGithubAPIResponseMocker : NSObject

// Provides a valid example of a repo dictionary parsed Github API results
+ (NSDictionary *)validRepoDictionary;

// Provides a repo dictionary with the full name missing (NSNull value for key)
+ (NSDictionary *)repoDictionaryMissingFullName;

// Provides a repo dictionary with the description missing (NSNull value for key)
+ (NSDictionary *)repoDictionaryMissingDescription;

// Provides a repo dictionary with the owner dictionary missing (NSNull value for key)
+ (NSDictionary *)repoDictionaryMissingOwnerLogin;

// Provides a valid example of an array of repos parsed Github API results
+ (NSArray *)validRepoArray;

// Provides an array of repos with one invalid repo
+ (NSArray *)repoArrayWithInvalidRepo;

// Provides a valid example of a contributor dictionary parsed Github API results
+ (NSDictionary *)validContributorDictionary;

// Provides a contributor dictionary with the login missing (NSNull value for key)
+ (NSDictionary *)contributorDictionaryMissingLogin;

// Provides a contributor dictionary with the contributions missing (NSNull value for key)
+ (NSDictionary *)contributorDictionaryMissingContributions;

@end
