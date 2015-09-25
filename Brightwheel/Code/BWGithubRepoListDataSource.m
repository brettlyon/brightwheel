//
//  BWGithubRepoListDataSource.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubRepoListDataSource.h"
#import "BWGithubAPIClient.h"
#import "BWGithubRepo.h"

@interface BWGithubRepoListDataSource ()
@property (assign, nonatomic) BOOL isInErrorState;
@property (assign, atomic) BOOL fetchPending;
@property (assign, atomic) BOOL areMoreResults;
@property (assign, nonatomic) NSUInteger nextPageNumber;
@property (strong, nonatomic) NSOperationQueue *backgroundQueue;
@property (strong, nonatomic) NSMutableArray *repos;
@property (strong, nonatomic) NSString *previousSearchTerm;
@end

static const NSInteger kDefaultPageSize = 10;
static const NSInteger kDefaultFetchThreshold = 5;
static const NSInteger kDefaultMaxNumberResults = -1;

@implementation BWGithubRepoListDataSource

#pragma mark - Public interface

+ (instancetype)dataSource {
    return [[self alloc] init];
}

- (void)fetchReposForSearchTerm:(NSString *)searchTerm {
    if (![searchTerm isEqualToString:self.previousSearchTerm]) {
        self.previousSearchTerm = searchTerm;
        [self reset];
    }
    
    if (!self.fetchPending) {
        self.fetchPending = YES;
        
        __weak typeof(self) weakSelf = self;
        [self.backgroundQueue addOperationWithBlock:^{
            [BWGithubAPIClient fetchRepositoriesForSearchTerm:searchTerm pageNumber:weakSelf.nextPageNumber pageSize:weakSelf.pageSize completion:^(NSError *error, NSArray *repos) {
                if (error || repos == nil) {
                    if (weakSelf.nextPageNumber == 1) {
                        weakSelf.isInErrorState = YES;
                        [weakSelf.tableView reloadData];
                    }
                } else {
                    weakSelf.areMoreResults = repos.count == weakSelf.pageSize;
                    weakSelf.nextPageNumber++;
                    
                    // For each repo in the array of results, fetch the top contributor, and then add it to the repo object, and add the repo object to the repos array. If something goes wrong just don't add it to the array. Wait until the top contributors for the entire page of results have been fetched before displaying them in the UI.
                    NSMutableArray *reposToAdd = [NSMutableArray array];
                    dispatch_group_t contributorFetchGroup = dispatch_group_create();
                    for (BWGithubRepo *repo in repos) {
                        dispatch_group_enter(contributorFetchGroup);
                        [BWGithubAPIClient topContributorForRepo:repo completion:^(NSError *error, BWGithubRepoContributor *topContributor) {
                            if (!error) {
                                repo.topContributor = topContributor;
                                [reposToAdd addObject:repo];
                            }
                            dispatch_group_leave(contributorFetchGroup);
                        }];
                    }
                    
                    dispatch_group_notify(contributorFetchGroup, dispatch_get_main_queue(),^{
                        // Won't get here until everything has finished
                        [weakSelf.repos addObjectsFromArray:reposToAdd];
                        [weakSelf.tableView reloadData];
                    });
                    
                    //dispatch_group_wait(contributorFetchGroup, DISPATCH_TIME_FOREVER);
                    
                    
                }
                
                weakSelf.fetchPending = NO;
            }];
        }];
    }
}

#pragma mark - Private helper methods

- (id)init {
    if (self = [super init]) {
        self.isInErrorState = NO;
        self.fetchPending = NO;
        self.areMoreResults = YES;
        self.nextPageNumber = 1;
        self.pageSize = kDefaultPageSize;
        self.fetchThreshold = kDefaultFetchThreshold;
        self.maxNumberResults = kDefaultMaxNumberResults;
        self.backgroundQueue = [[NSOperationQueue alloc] init];
        self.backgroundQueue.maxConcurrentOperationCount = 1;
        self.previousSearchTerm = @"";
    }
    
    return self;
}

- (NSMutableArray *)repos {
    if (_repos == nil) _repos = [NSMutableArray array];
    return _repos;
}

- (void)reset {
    [self.backgroundQueue cancelAllOperations];
    
    self.repos = nil;
    self.nextPageNumber = 1;
    self.areMoreResults = YES;
    self.isInErrorState = NO;
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Should trigger a new fetch if close to the bottom of the table
}

@end
