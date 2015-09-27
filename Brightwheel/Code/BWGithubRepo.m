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
#define REPO_STARS_LABEL        @"watchers"

@implementation BWGithubRepo

+ (NSArray *)reposFromArray:(NSArray *)repoArray {
    NSMutableArray *repos = [NSMutableArray array];
    for (NSDictionary *repoDictionary in repoArray) {
        BWGithubRepo *repo = [self repoFromDictionary:repoDictionary];
        [repos addObject:repo];
    }
    return repos;
}

+ (instancetype)repoFromDictionary:(NSDictionary *)repoDictionary {
    BWGithubRepo *repo = [[BWGithubRepo alloc] init];
    repo.name = repoDictionary[REPO_NAME_KEY];
    repo.fullName = repoDictionary[REPO_FULL_NAME_KEY];
    repo.repoDescription = repoDictionary[REPO_DESCRIPTION_KEY];
    repo.numStars = [repoDictionary[REPO_STARS_LABEL] integerValue];
    return repo;
}

@end
