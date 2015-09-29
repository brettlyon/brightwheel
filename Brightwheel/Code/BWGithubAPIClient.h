//
//  BWGithubAPIClient.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

/*
 
 This class is responsible for making calls to the Github API, and returning results as objects.
 
 */

#import <Foundation/Foundation.h>

@class BWGithubRepoContributor;
@class BWGithubRepo;

@interface BWGithubAPIClient : NSObject

/*
 Takes a search term (can be an empty string or nil), page size, and a completion block and asynchronously fetches the first page of size pageSize of repos corresponding to the passed search term. It provides a possible error, array of repos, and the url of the next page of repos to the completion block. No guarantees are made about which thread the completion block will be executed on.
*/
+ (void)fetchFirstPageOfRepositoriesForSearchTerm:(NSString *)searchTerm pageSize:(NSUInteger)pageSize completion:(void (^)(NSError *error, NSArray *repos, NSString *nextPageLink))completion;

/*
 Takes a url to a page of repos and fetches that page.
 */
+ (void)fetchNextPageOfRespositoriesWithLink:(NSString *)nextPageLink completion:(void (^)(NSError *error, NSArray *repos, NSString *nextPageLink))completion;

/*
 Takes a repo, and synchronously fetches the top contributor for that repo.
 */
+ (void)topContributorForRepo:(BWGithubRepo *)repo completion:(void (^)(NSError *error, BWGithubRepoContributor *topContributor))completion;
@end
