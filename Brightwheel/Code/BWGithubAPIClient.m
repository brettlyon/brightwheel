//
//  BWGithubAPIClient.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubAPIClient.h"
#import "BWGithubRepo.h"
#import "BWGithubRepoContributor.h"

#define ACCEPT_HEADER                   @"Accept"
#define V3_ACCEPT_HEADER_VALUE          @"application/vnd.github.v3+json"
#define GITHUB_API_BASE_URL             @"https://api.github.com/"
#define ACCESS_TOKEN                    @"3691e0703dc736b8a2c6edcf8e6ac365a948de7a"

@implementation BWGithubAPIClient

+ (void)fetchRepositoriesForSearchTerm:(NSString *)searchTerm pageNumber:(NSUInteger)pageNumber pageSize:(NSUInteger)pageSize completion:(void (^)(NSError *error, NSArray *repos))completion {
    
    // If the searchTerm is nothing, or is just whitespace, then just search by number of stars
    searchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@""]; // Remove whitespace
    if (searchTerm.length == 0 || searchTerm == nil) searchTerm = @"+stars:0..1000000";
    
    // Construct the url
    NSString *urlString = [NSString stringWithFormat:@"%@search/repositories?q=%@&sort=stars&order=desc&page=%@&per_page=%@&access_token=%@", GITHUB_API_BASE_URL, searchTerm, @(pageNumber), @(pageSize), ACCESS_TOKEN];
    NSURL *requestUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    request.HTTPMethod = @"GET";
    [request addValue:V3_ACCEPT_HEADER_VALUE forHTTPHeaderField:ACCEPT_HEADER];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *fetchReposTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // If there's an error, execute the completion block with a nil result and error
        if (error) {
            if (completion != nil) completion(error, nil);
        } else {
            // Otherwise deserialize the response into JSON
            NSError *serializationError;
            NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
            // If there was an error deserializing the JSON, then execute the completion block with the error and a nil value for the result
            if (serializationError) {
                if (completion != nil) completion(error, nil);
            } else {
                // No error, objectify the repos and hand them back in the completion block
                NSArray *rawReposArray = rawResults[@"items"];
                NSArray *repos = [BWGithubRepo reposFromArray:rawReposArray];
                if (completion != nil) completion(nil, repos);
            }
        }
        
    }];
    
    [fetchReposTask resume];
}

+ (void)topContributorForRepo:(BWGithubRepo *)repo completion:(void (^)(NSError *error, BWGithubRepoContributor *topContributor))completion {
    if (repo) {
        if (repo.fullName == nil)  {
            NSError *error = [NSError errorWithDomain:@"Brightwheel" code:0 userInfo:@{
                                                                                       @"message": @"No repo id or repo owner if provided to find top contributor with"
                                                                                       }];
            if (completion != nil) completion(error, nil);
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@repos/%@/contributors?page=1&per_page=1&access_token=%@", GITHUB_API_BASE_URL, repo.fullName, ACCESS_TOKEN];
        NSURL *requestUrl = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
        request.HTTPMethod = @"GET";
        [request addValue:V3_ACCEPT_HEADER_VALUE forHTTPHeaderField:ACCEPT_HEADER];
        
        NSURLSession *urlSession = [NSURLSession sharedSession];

        NSURLSessionDataTask *fetchTopContributorTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                if (completion != nil) completion(error, nil);
            } else  {
                NSError *serializationError;
                NSArray *rawResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                if (serializationError) {
                    if (completion != nil) completion(serializationError, nil);
                } else {
                    NSDictionary *rawResult = [rawResults firstObject];
                    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:rawResult];
                    if (contributor) {
                        if (completion != nil) completion(nil, contributor);
                    } else {
                        NSError *translationError = [NSError errorWithDomain:@"Brightwheel" code:2 userInfo:@{
                                                                                                   @"message": @"Error translating raw contributor response from Github API into a contributor object"
                                                                                                   }];
                        if (completion != nil) completion(translationError, nil);
                    }
                }
            }
        }];
        
        [fetchTopContributorTask resume];
    } else {
        NSError *error = [NSError errorWithDomain:@"Brightwheel" code:1 userInfo:@{
                                                                                   @"message": @"No repo provided to find top contributor for"
                                                                                   }];
        if (completion != nil) completion(error, nil);
    }
}

@end
