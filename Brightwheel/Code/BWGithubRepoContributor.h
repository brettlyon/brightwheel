//
//  BWGithubRepoContributor.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 This class is the local model representing a contributor to a Github repo.
 
 */

@interface BWGithubRepoContributor : NSObject

// Name of the contributor on Github (technically 'login')
@property (strong, nonatomic) NSString *name;

// Number of contributions made to the repo. All contributors are fetched for a particular repository. The repo is not stored currently in this object though, since it's not needed.
@property (assign, nonatomic) NSUInteger contributions;

// Factory method that takes a dictionary representing JSON results (single contributor) from a request to the Github contributors api
+ (instancetype)contributorWithDictionary:(NSDictionary *)contributorDictionary;
@end
