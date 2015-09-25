//
//  BWGithubAPIClient.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubAPIClient.h"

#define ACCEPT_HEADER                   @"Accept"
#define V3_ACCEPT_HEADER_VALUE          @"application/vnd.github.v3+json"
#define GITHUB_API_BASE_URL             @"https://api.github.com/"
#define ACCESS_TOKEN                    @"3691e0703dc736b8a2c6edcf8e6ac365a948de7a"

@implementation BWGithubAPIClient

+ (void)fetchRepositoriesForSearchTerm:(NSString *)searchTerm pageSize:(NSUInteger)pageSize offset:(NSUInteger)offset completion:(void (^)(NSError *error, NSArray *repos))completion {
    
    // If the searchTerm is nothing, or is just whitespace, then just search by number of stars
    searchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@""]; // Remove whitespace
    if (searchTerm.length == 0) searchTerm = @"+stars:0..1000000000";
    
    // Construct the url
    NSString *urlString = [NSString stringWithFormat:@"%@search/repositories?q=%@&sort=stars&order=desc&access_token=%@&per_page=10", GITHUB_API_BASE_URL, searchTerm, ACCESS_TOKEN];
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
            if (serializationError) {
                // If there was an error deserializing the JSON, then execute the completion block with the error and a nil value for the result
                if (completion != nil) {
                    completion(error, nil);
                } else {
                    
                }
                
            }
        }
        
    }];
    
    [fetchReposTask resume];
}

+ (void)topContributorForRepo:(BWGithubRepo *)repo completion:(void (^)(NSError *error, BWGithubRepoContributor *topContributor))completion {
    
}

@end
