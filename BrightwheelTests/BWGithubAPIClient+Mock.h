//
//  BWGithubAPIClient+Mock.h
//  Brightwheel
//
//  Created by Brett Lyon on 9/28/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubAPIClient.h"

/*
 
 This class allows synchronous mocking of asynchronous fetches on the BWGitubAPIClient class, using method swizzling. Should call once to mock before the BWGitubAPIClient method is called, and once after to ensure the method is unmocked.
 
 */

@interface BWGithubAPIClient (Mock)

// Replace asynchronous implementation of repo fetch (first page) with a synchronous return of a page of 3 repos
+ (void)mockRepoFetchWithSuccessfulResponse;

// Replace asynchronous implementation of contributor fetch with a synchronous return a contributor object
+ (void)mockContributorFetchWithSuccessfulResponse;

// Replace asynchronous implementation of repo fetch (first page) with a synchronous return of a page of 3 repos, but without a nextPageLink, signifying the last page
+ (void)mockRepoFetchWithSuccessfulResponseButNoNextPageLink;

// Replace asynchronous implementation of repo fetch (first page) with a synchronous error response
+ (void)mockRepoFetchWithErrorResponse;

@end
