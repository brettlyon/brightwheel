//
//  BWGithubRepo.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

/*
 
 This class is the local model representing a Github repository. It has a factory method that takes a dictionary as a parameter, and populates a BWGithubRepo object using the data contained within.
 
 */

#import <Foundation/Foundation.h>
#import "BWGithubRepoContributor.h"

@interface BWGithubRepo : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *repoDescription;
@property (strong, nonatomic) BWGithubRepoContributor *topContributor;
+ (NSArray *)reposFromArray:(NSArray *)repoArray;
+ (instancetype)repoFromDictionary:(NSDictionary *)repoDictionary;
@end
