//
//  BWGithubAPIResponseMocker.h
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWGithubAPIResponseMocker : NSObject

+ (NSDictionary *)validRepoDictionary;
+ (NSDictionary *)repoDictionaryMissingFullName;
+ (NSDictionary *)repoDictionaryMissingDescription;
+ (NSDictionary *)repoDictionaryMissingOwnerLogin;
+ (NSArray *)validRepoArray;
+ (NSArray *)repoArrayWithInvalidRepo;
+ (NSDictionary *)validContributorDictionary;
+ (NSDictionary *)contributorDictionaryMissingLogin;
+ (NSDictionary *)contributorDictionaryMissingContributions;

@end
