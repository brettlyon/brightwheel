//
//  BWGithubAPIClient.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

/*
 
 This class is responsible for taking the json responses from the Github API Service and building model objects out of the returned data
 
 */

#import <Foundation/Foundation.h>

@class BWGithubRepoContributor;
@class BWGithubRepo;

@interface BWGithubAPIClient : NSObject
+ (void)fetchRepositoriesForSearchTerm:(NSString *)searchTerm pageSize:(NSUInteger)pageSize offset:(NSUInteger)offset completion:(void (^)(NSError *error, NSArray *repos))completion;
+ (void)topContributorForRepo:(BWGithubRepo *)repo completion:(void (^)(NSError *error, BWGithubRepoContributor *topContributor))completion;
@end
