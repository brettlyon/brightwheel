//
//  BWGithubRepo.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWGithubRepoContributor.h"

/*
 
 This class is the local model representing a Github repository. It exposes factory methods to create Repo objects from JSON results.
 
 */

@interface BWGithubRepo : NSObject
// Name of the repo (does not include the owner's name)
@property (strong, nonatomic) NSString *name;

// Name of the repo's owner
@property (strong, nonatomic) NSString *owner;

// Full name of the repo (includes the owner's name in the format: <owner>/<name>)
@property (strong, nonatomic) NSString *fullName;

// Description of the repo
@property (strong, nonatomic) NSString *repoDescription;

// BWGithubRepoContributor object representing the top contributor to the repo. Must be set manually, and can be nil.
@property (strong, nonatomic) BWGithubRepoContributor *topContributor;

// The number of people who have starred the repo on Github
@property (assign, nonatomic) NSUInteger numStars;

// An array representing the number of commits per week for the past year for the repo
@property (assign, nonatomic) NSArray *commitHistory;

// Factory method that takes an array representing JSON results (multiple repos) from a request to the Github search api
+ (NSArray *)reposFromArray:(NSArray *)repoArray;

// Factory method that takes a dictionary representing JSON results (single repo) from a request to the Github search api
+ (instancetype)repoFromDictionary:(NSDictionary *)repoDictionary;
@end
