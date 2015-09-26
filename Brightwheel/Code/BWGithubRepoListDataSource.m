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
#import "BWGithubErrorTableViewCell.h"
#import "BWGithubRepoTableViewCell.h"
#import "BWGithubLoadingTableViewCell.h"

#define REPO_CELL_REUSE_ID      @"repo_cell"
#define LOADING_CELL_REUSE_ID   @"loading_cell"
#define ERROR_CELL_REUSE_ID     @"error_cell"

@interface BWGithubRepoListDataSource () <UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) BOOL isInErrorState;
@property (assign, atomic) BOOL fetchPending;
@property (assign, atomic) BOOL areMoreResults;
@property (assign, nonatomic) NSUInteger nextPageNumber;
@property (strong, nonatomic) NSOperationQueue *backgroundQueue;
@property (strong, nonatomic) NSMutableArray *repos;
@property (strong, nonatomic) NSString *previousSearchTerm;
@property (strong, nonatomic) dispatch_queue_t pageSortingQueue;
@end

static const NSInteger kDefaultPageSize = 10;
static const NSInteger kDefaultFetchThreshold = 5;
static const NSInteger kDefaultMaxNumberResults = -1;

@implementation BWGithubRepoListDataSource

#pragma mark - Public interface

+ (instancetype)dataSource {
    return [[self alloc] init];
}

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
        self.pageSortingQueue = dispatch_queue_create("com.brightwheel.page_sorting_queue", DISPATCH_QUEUE_SERIAL);
        self.previousSearchTerm = @"";
    }
    
    return self;
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    // Register cells xibs with the table view
    NSString *repoCellName = NSStringFromClass([BWGithubRepoTableViewCell class]);
    UINib *repoCellNib = [UINib nibWithNibName:repoCellName bundle:nil];
    [_tableView registerNib:repoCellNib forCellReuseIdentifier:REPO_CELL_REUSE_ID];
    
    NSString *loadingCellName = NSStringFromClass([BWGithubLoadingTableViewCell class]);
    UINib *loadingCellNib = [UINib nibWithNibName:loadingCellName bundle:nil];
    [_tableView registerNib:loadingCellNib forCellReuseIdentifier:LOADING_CELL_REUSE_ID];
    
    NSString *errorCellName = NSStringFromClass([BWGithubErrorTableViewCell class]);
    UINib *errorCellNib = [UINib nibWithNibName:errorCellName bundle:nil];
    [_tableView registerNib:errorCellNib forCellReuseIdentifier:ERROR_CELL_REUSE_ID];
}

- (void)fetchNextPageOfReposForSearchTerm:(NSString *)searchTerm {
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
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakSelf.nextPageNumber == 1) {
                            weakSelf.isInErrorState = YES;
                            [weakSelf.tableView reloadData];
                        }
                    });
                } else {
                    weakSelf.areMoreResults = repos.count == weakSelf.pageSize;
                    weakSelf.nextPageNumber++;
                    
                    [weakSelf getTopContributorsForRepos:repos completion:^(NSError *error, NSArray *sortedRepos) {
                        if (!error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.repos addObjectsFromArray:sortedRepos];
                                [weakSelf.tableView reloadData];
                            });
                        } else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (weakSelf.nextPageNumber == 1) {
                                    weakSelf.isInErrorState = YES;
                                    [weakSelf.tableView reloadData];
                                }
                            });
                        }
                    }];
                }
                
                weakSelf.fetchPending = NO;
            }];
        }];
    }
}

#pragma mark - Private methods

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

/*
 
 This method takes an array of repository objects, and fetches each of their top contributors. Once all top contributors have been fetched and added to the repository objects, the repos are sorted in descending order by number of stars, and the array is passed to the completion block.
 
 */
- (void)getTopContributorsForRepos:(NSArray *)repos completion:(void (^)(NSError *error, NSArray *sortedRepos))completion {
    // Use a dispatch group in order to wait until all of the contributor fetches have been completed.
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
    
    dispatch_group_notify(contributorFetchGroup, self.pageSortingQueue, ^{
        if (reposToAdd.count > 0) {
            // Sort the repos by stars before passing to the completion block
            NSArray *sortedRepos = [reposToAdd sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                BWGithubRepo *repo1 = (BWGithubRepo *)obj1;
                BWGithubRepo *repo2 = (BWGithubRepo *)obj2;
                
                if (repo1.numStars < repo2.numStars) return NSOrderedDescending;
                if (repo1.numStars > repo2.numStars) return NSOrderedAscending;
                return NSOrderedSame;
            }];
            
            if (completion != nil) completion(nil, sortedRepos);
        } else {
            NSError *error = [NSError errorWithDomain:@"Brightwheel" code:3 userInfo:@{
                                                                                       @"message": @"Failed to fetch top contributor for any repo in page"
                                                                                       }];
            if (completion != nil) completion(error, reposToAdd);
        }
    });
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isInErrorState) return 1;
    if (self.areMoreResults) return self.repos.count + 1;
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isInErrorState) {
        // Return an error cell
        return [tableView dequeueReusableCellWithIdentifier:ERROR_CELL_REUSE_ID forIndexPath:indexPath];
    }
    
    if (indexPath.row == self.repos.count) {
        // Return loading cell
        BWGithubLoadingTableViewCell *loadingCell = [tableView dequeueReusableCellWithIdentifier:LOADING_CELL_REUSE_ID forIndexPath:indexPath];
        [loadingCell.spinner startAnimating];
        return loadingCell;
    }
    
    // Populate and return a repo cell
    BWGithubRepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REPO_CELL_REUSE_ID forIndexPath:indexPath];
    BWGithubRepo *repo = self.repos[indexPath.row];
    cell.repoNameLabel.text = repo.fullName;
    cell.descriptionLabel.text = repo.repoDescription;
    cell.starsLabel.text = [NSString stringWithFormat:@"%@", @(repo.numStars)];
    BWGithubRepoContributor *topContributor = repo.topContributor;
    cell.topContributorLabel.text = [NSString stringWithFormat:@"top contributor: %@ (%@)", topContributor.name, @(topContributor.contributions)];
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If there are more results, trigger a fetch for next page of repos if you get too close to the bottom of the table view
    if (self.areMoreResults) {
        NSInteger cellsFromBottom = self.repos.count - indexPath.row;
        if (cellsFromBottom <= kDefaultFetchThreshold) {
            [self fetchNextPageOfReposForSearchTerm:self.previousSearchTerm];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isInErrorState) return 200.0;
    if (indexPath.row == self.repos.count) return 200.0;
    return 200.0;
}

@end
