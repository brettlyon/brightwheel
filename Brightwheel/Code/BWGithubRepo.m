//
//  BWGithubRepo.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubRepo.h"

#define REPO_FULL_NAME_KEY      @"full_name"
#define REPO_NAME_KEY           @"name"
#define REPO_DESCRIPTION_KEY    @"description"
#define REPO_STARS_LABEL        @"watchers_count"
#define NO_DESCRIPTION_MESSAGE  @"No description."
#define ANONYMOUS_LOGIN         @"anonymous"

@implementation BWGithubRepo

+ (NSArray *)reposFromArray:(NSArray *)repoArray {
    NSMutableArray *repos = [NSMutableArray array];
    for (NSDictionary *repoDictionary in repoArray) {
        BWGithubRepo *repo = [self repoFromDictionary:repoDictionary];
        if (repo != nil) [repos addObject:repo];
    }
    return repos;
}

+ (instancetype)repoFromDictionary:(NSDictionary *)repoDictionary {
    if (![repoDictionary isKindOfClass:[NSDictionary class]]) return nil;
    BWGithubRepo *repo = [[BWGithubRepo alloc] init];
    repo.name = repoDictionary[REPO_NAME_KEY];
    repo.repoDescription = repoDictionary[REPO_DESCRIPTION_KEY] ? repoDictionary[REPO_DESCRIPTION_KEY] : NO_DESCRIPTION_MESSAGE;
    repo.numStars = [repoDictionary[REPO_STARS_LABEL] integerValue];
    
    NSDictionary *ownerDictionary = repoDictionary[@"owner"];
    repo.owner = ownerDictionary && ownerDictionary[@"login"] ? ownerDictionary[@"login"] : ANONYMOUS_LOGIN;
    
    repo.fullName = repoDictionary[REPO_FULL_NAME_KEY] ? repoDictionary[REPO_FULL_NAME_KEY] : [NSString stringWithFormat:@"%@/%@", repo.owner, repo.name];
    
    return repo;
}

@end
