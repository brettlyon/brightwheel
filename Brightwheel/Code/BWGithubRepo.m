//
//  BWGithubRepo.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubRepo.h"

#define REPO_FULL_NAME_KEY          @"full_name"
#define REPO_NAME_KEY               @"name"
#define REPO_NO_NAME_PLACEHOLDER    @"Unnamed"
#define REPO_DESCRIPTION_KEY        @"description"
#define REPO_STARS_LABEL            @"watchers_count"
#define NO_DESCRIPTION_MESSAGE      @"No description."
#define ANONYMOUS_LOGIN             @"anonymous"
#define OWNER_KEY                   @"owner"
#define OWNER_LOGIN_KEY             @"login"

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
    if (![repoDictionary isKindOfClass:[NSDictionary class]] || repoDictionary.count == 0) return nil;
    BWGithubRepo *repo = [[BWGithubRepo alloc] init];
    repo.name = repoDictionary[REPO_NAME_KEY] != [NSNull null] ? repoDictionary[REPO_NAME_KEY] : REPO_NO_NAME_PLACEHOLDER;
    
    repo.repoDescription = repoDictionary[REPO_DESCRIPTION_KEY] != [NSNull null] ? repoDictionary[REPO_DESCRIPTION_KEY] : NO_DESCRIPTION_MESSAGE;
    // If the description is an empty string replace it with the placeholder
    if (repoDictionary[REPO_DESCRIPTION_KEY] != [NSNull null]) {
        NSString *description = repoDictionary[REPO_DESCRIPTION_KEY];
        NSString *cleanedString = [description stringByReplacingOccurrencesOfString:@" " withString:@""];
        repo.repoDescription = cleanedString.length > 0 ? description : NO_DESCRIPTION_MESSAGE;
    } else {
        repo.repoDescription = NO_DESCRIPTION_MESSAGE;
    }
    
    repo.numStars = repoDictionary[REPO_STARS_LABEL] != [NSNull null] ? [repoDictionary[REPO_STARS_LABEL] integerValue] : 0;
    
    if (repoDictionary[OWNER_KEY] == [NSNull null]) {
        repo.owner = ANONYMOUS_LOGIN;
    } else {
        NSDictionary *ownerDictionary = repoDictionary[OWNER_KEY];
        repo.owner = ownerDictionary[OWNER_LOGIN_KEY] != [NSNull null] ? ownerDictionary[OWNER_LOGIN_KEY] : ANONYMOUS_LOGIN;
    }
    
    repo.fullName = repoDictionary[REPO_FULL_NAME_KEY] != [NSNull null] ? repoDictionary[REPO_FULL_NAME_KEY] : [NSString stringWithFormat:@"%@/%@", repo.owner, repo.name];
    
    return repo;
}

@end
