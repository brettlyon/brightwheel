//
//  BWGithubAPIClient+Mock.h
//  Brightwheel
//
//  Created by Brett Lyon on 9/28/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubAPIClient.h"

@interface BWGithubAPIClient (Mock)

+ (void)mockRepoFetchWithSuccessfulResponse;
+ (void)mockContributorFetchWithSuccessfulResponse;
+ (void)mockRepoFetchWithSuccessfulResponseButNoNextPageLink;
+ (void)mockRepoFetchWithErrorResponse;

@end
