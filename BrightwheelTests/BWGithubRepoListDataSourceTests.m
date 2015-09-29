//
//  BWGithubRepoListDataSourceTests.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "BWGithubRepoListDataSource.h"
#import "BWGithubAPIClient+Mock.h"

@interface BWGithubRepoListDataSourceTests : XCTestCase
@property (strong, nonatomic) BWGithubRepoListDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation BWGithubRepoListDataSourceTests

- (void)setUp {
    [super setUp];
    self.dataSource = [BWGithubRepoListDataSource dataSource];
    
    self.tableView = [[UITableView alloc] init];
    self.dataSource.tableView = self.tableView;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Test that setting the data source's tableView property sets the dataSource property of the table view
- (void)testSettingTableViewPropertySetsTableViewDataSource {
    XCTAssertEqualObjects(self.tableView.dataSource, self.dataSource, @"Setting the table view property on the data source should set the dataSource property of the table view");
}

// Data source methods before fetch
- (void)testTableViewDataSourceMethodsBeforeFetch {
    NSUInteger numberOfSections = [self.dataSource numberOfSectionsInTableView:self.tableView];
    NSUInteger numberOfRows = [self.dataSource tableView:self.tableView numberOfRowsInSection:0];
    
    XCTAssertTrue(numberOfSections == 1, @"Should be 1 section");
    XCTAssertTrue(numberOfRows == 1, @"Should be 1 row (corresponding to a loading cell)");
}

// Data source methods after successful fetch
- (void)testTableViewDataSourceMethodsAfterSuccessfulFetch {
    [BWGithubAPIClient mockRepoFetchWithSuccessfulResponse]; // Mock successful repo fetch
    [BWGithubAPIClient mockContributorFetchWithSuccessfulResponse]; // Mock successful contributor fetch
    
    [self.dataSource fetchNextPageOfReposForSearchTerm:@""];
    
    // Need to let the main run loop run a little in order for the completion block that updates the data source's internal storage to be dispatched and executed on the main queue
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    
    NSUInteger numberOfSections = [self.dataSource numberOfSectionsInTableView:self.tableView];
    NSUInteger numberOfRows = [self.dataSource tableView:self.tableView numberOfRowsInSection:0];
    
    XCTAssertTrue(numberOfSections == 1, @"Should be 1 section");
    XCTAssertTrue(numberOfRows == 4, @"Should be 4 rows (corresponding to 3 results and a loading cell)");
    
    [BWGithubAPIClient mockRepoFetchWithSuccessfulResponse]; // Unmock successful fetch
    [BWGithubAPIClient mockContributorFetchWithSuccessfulResponse]; // Unmock successful contributor fetch
}

// Data source methods after error on fetch
- (void)testTableViewDataSourceMethodsAfterErrorOnFetch {
    [BWGithubAPIClient mockRepoFetchWithErrorResponse]; // Mock failed repo fetch
    [BWGithubAPIClient mockContributorFetchWithSuccessfulResponse]; // Mock successful contributor fetch
    
    [self.dataSource fetchNextPageOfReposForSearchTerm:@""];
    
    NSUInteger numberOfSections = [self.dataSource numberOfSectionsInTableView:self.tableView];
    NSUInteger numberOfRows = [self.dataSource tableView:self.tableView numberOfRowsInSection:0];
    
    XCTAssertTrue(numberOfSections == 1, @"Should be 1 section");
    XCTAssertTrue(numberOfRows == 1, @"Should be 1 row (corresponding to an error cell)");
    
    [BWGithubAPIClient mockRepoFetchWithErrorResponse]; // Unmock failed repo fetch
    [BWGithubAPIClient mockContributorFetchWithSuccessfulResponse]; // Unmock successful contributor fetch
}

// Data source methods after a fetch of the last page
- (void)testTableViewDataSourceMethodsAfterFetchOfLastPage {
    [BWGithubAPIClient mockRepoFetchWithSuccessfulResponseButNoNextPageLink]; // Mock successful repo last page fetch
    [BWGithubAPIClient mockContributorFetchWithSuccessfulResponse]; // Mock successful contributor fetch
    
    [self.dataSource fetchNextPageOfReposForSearchTerm:@""];
    
    // Need to let the main run loop run a little in order for the completion block that updates the data source's internal storage to be dispatched and executed on the main queue
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    
    NSUInteger numberOfSections = [self.dataSource numberOfSectionsInTableView:self.tableView];
    NSUInteger numberOfRows = [self.dataSource tableView:self.tableView numberOfRowsInSection:0];
    
    XCTAssertTrue(numberOfSections == 1, @"Should be 1 section");
    XCTAssertTrue(numberOfRows == 3, @"Should be 3 rows (corresponding to 3 results)");
    
    [BWGithubAPIClient mockRepoFetchWithSuccessfulResponseButNoNextPageLink]; // Unmock successful repo last page fetch
    [BWGithubAPIClient mockContributorFetchWithSuccessfulResponse]; // Unmock successful contributor fetch
}


@end
