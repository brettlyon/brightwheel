//
//  BWGithubAPIClient+Mock.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/28/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubAPIClient+Mock.h"
#import "BWGithubRepo.h"
#import "BWGithubAPIResponseMocker.h"
#import <objc/runtime.h>

@implementation BWGithubAPIClient (Mock)

+ (void)swizzleAPIMethodForSelector:(SEL)aSelector withMockMethodForSelector:(SEL)anotherSelector {
    Class class = object_getClass((id)self);
    
    Method aMethod = class_getClassMethod(class, aSelector);
    Method anotherMethod = class_getClassMethod(class, anotherSelector);
    
    // Swizzle me timbers!
    BOOL didAddMethod = class_addMethod(class, aSelector, method_getImplementation(anotherMethod), method_getTypeEncoding(anotherMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, anotherSelector, method_getImplementation(aMethod), method_getTypeEncoding(aMethod));
    } else {
        method_exchangeImplementations(aMethod, anotherMethod);
    }
}

+ (void)mockRepoFetchWithSuccessfulResponse {
    SEL apiSelector = @selector(fetchFirstPageOfRepositoriesForSearchTerm:pageSize:completion:);
    SEL mockSelector = @selector(mockSuccessfulFetchFirstPageOfReposForSearchTerm:pageSize:completion:);
    
    [self swizzleAPIMethodForSelector:apiSelector withMockMethodForSelector:mockSelector];
}

+ (void)mockRepoFetchWithSuccessfulResponseButNoNextPageLink {
    SEL apiSelector = @selector(fetchFirstPageOfRepositoriesForSearchTerm:pageSize:completion:);
    SEL mockSelector = @selector(mockSuccessfulFetchFirstPageOfReposWithNoNextPageLinkForSearchTerm:pageSize:completion:);
    
    [self swizzleAPIMethodForSelector:apiSelector withMockMethodForSelector:mockSelector];
}

+ (void)mockContributorFetchWithSuccessfulResponse {
    SEL apiSelector = @selector(topContributorForRepo:completion:);
    SEL mockSelector = @selector(mockSuccessfulTopContributorForRepo:completion:);
    
    [self swizzleAPIMethodForSelector:apiSelector withMockMethodForSelector:mockSelector];
}

+ (void)mockRepoFetchWithErrorResponse {
    SEL apiSelector = @selector(fetchFirstPageOfRepositoriesForSearchTerm:pageSize:completion:);
    SEL mockSelector = @selector(mockFailedFetchFirstPageOfReposForSearchTerm:pageSize:completion:);
    
    [self swizzleAPIMethodForSelector:apiSelector withMockMethodForSelector:mockSelector];
}

// Mocked API methods returning dummy data synchronously

+ (void)mockSuccessfulFetchFirstPageOfReposForSearchTerm:(NSString *)searchTerm pageSize:(NSUInteger)pageSize completion:(void (^)(NSError *error, NSArray *repos, NSString *nextPageLink))completion {
    NSArray *repos = [BWGithubRepo reposFromArray:[BWGithubAPIResponseMocker validRepoArray]];
    NSString *nextPageLink = @"Next page";
    if (completion != nil) completion(nil, repos, nextPageLink);
}

+ (void)mockSuccessfulFetchFirstPageOfReposWithNoNextPageLinkForSearchTerm:(NSString *)searchTerm pageSize:(NSUInteger)pageSize completion:(void (^)(NSError *error, NSArray *repos, NSString *nextPageLink))completion {
    NSArray *repos = [BWGithubRepo reposFromArray:[BWGithubAPIResponseMocker validRepoArray]];
    if (completion != nil) completion(nil, repos, nil);
}

+ (void)mockFailedFetchFirstPageOfReposForSearchTerm:(NSString *)searchTerm pageSize:(NSUInteger)pageSize completion:(void (^)(NSError *error, NSArray *repos, NSString *nextPageLink))completion {
    NSError *error = [NSError errorWithDomain:@"Testing" code:0 userInfo:@{
                                                                           @"message": @"dummy test error"
                                                                           }];
    if (completion != nil) completion(error, nil, nil);
}

+ (void)mockSuccessfulTopContributorForRepo:(BWGithubRepo *)repo completion:(void (^)(NSError *error, BWGithubRepoContributor *topContributor))completion {
    BWGithubRepoContributor *contributor = [BWGithubRepoContributor contributorWithDictionary:[BWGithubAPIResponseMocker validContributorDictionary]];
    if (completion != nil) completion(nil, contributor);
}

+ (void)mockFailedTopContributorForRepo:(BWGithubRepo *)repo completion:(void (^)(NSError *error, BWGithubRepoContributor *topContributor))completion {
    
    NSError *error = [NSError errorWithDomain:@"Testing" code:0 userInfo:@{
                                                                           @"message": @"dummy test error"
                                                                           }];
    if (completion != nil) completion(error, nil);
}

@end
