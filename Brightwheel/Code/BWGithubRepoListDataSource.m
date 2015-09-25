//
//  BWGithubRepoListDataSource.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubRepoListDataSource.h"
#import "BWGithubAPIClient.h"

@interface BWGithubRepoListDataSource ()
@property (assign, nonatomic) BOOL isInErrorState;
@property (assign, atomic) BOOL fetchPending;
@property (assign, atomic) BOOL areMoreResults;
@property (assign, nonatomic) NSUInteger paginationOffset;
@property (assign, nonatomic) BOOL hasPageSizeBeenSet;
@property (strong, nonatomic) dispatch_queue_t backgroundQueue;
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
    [BWGithubAPIClient fetchRepositoriesForSearchTerm:searchTerm pageSize:self.pageSize offset:0 completion:^(NSError *error, NSArray *repos) {
        
    }];
}

#pragma mark - Private helper methods

- (id)init {
    if (self = [super init]) {
        self.isInErrorState = NO;
        self.fetchPending = NO;
        self.areMoreResults = YES;
        self.paginationOffset = 0;
        self.hasPageSizeBeenSet = NO;
        self.pageSize = kDefaultPageSize;
        self.fetchThreshold = kDefaultFetchThreshold;
        self.maxNumberResults = kDefaultMaxNumberResults;
        self.backgroundQueue = dispatch_queue_create("com.brightwheeltakehome.repo_fetch_queue", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
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
