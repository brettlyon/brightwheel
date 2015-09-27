//
//  BWGithubRepoContributor.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWGithubRepoContributor : NSObject
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSUInteger contributions;
+ (instancetype)contributorWithDictionary:(NSDictionary *)contributorDictionary;
@end
