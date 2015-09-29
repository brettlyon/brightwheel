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
#define ANONYMOUS               @"anonymous"

@implementation BWGithubRepoContributor

+ (instancetype)contributorWithDictionary:(NSDictionary *)contributorDictionary {
    if (![contributorDictionary isKindOfClass:[NSDictionary class]]) return nil;
    BWGithubRepoContributor *contributor = [[BWGithubRepoContributor alloc] init];
    contributor.name = contributorDictionary[CONTRIBUTOR_NAME_KEY] ? contributorDictionary[CONTRIBUTOR_NAME_KEY] : ANONYMOUS;
    NSNumber *contributions = contributorDictionary[CONTRIBUTIONS_KEY];
    contributor.contributions = contributions ? [contributions integerValue] : 0;
    return contributor;
}

@end
