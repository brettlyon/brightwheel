//
//  BWGithubRepoContributor.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubRepoContributor.h"

#define CONTRIBUTOR_NAME_KEY    @"login"
#define CONTRIBUTIONS_KEY       @"contributions"

@implementation BWGithubRepoContributor

+ (instancetype)contributorWithDictionary:(NSDictionary *)contributorDictionary {
    BWGithubRepoContributor *contributor = [[BWGithubRepoContributor alloc] init];
    contributor.name = contributorDictionary[CONTRIBUTOR_NAME_KEY];
    contributor.contributions = [contributorDictionary[CONTRIBUTIONS_KEY] integerValue];
    return contributor;
}

@end
