//
//  BWGithubRepoListDataSource.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

/*
 
 This class conforms to UITableViewDataSource protocol and is responsible for providing a table view with cells displaying github repositories (along with their top contributor), and error or loading states when necessary. This class also makes sure network calls and long running operations are executed off the main thread.
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BWGithubRepoListDataSource : NSObject <UITableViewDataSource>

// Size of the pages for pagination of the repos
@property (assign, nonatomic) NSUInteger pageSize;

// This parameter determines when the next page of repos will be fetched, in terms of cells from the end
@property (assign, nonatomic) NSUInteger fetchThreshold;

// The table view the data source will manage and provide data to. Setting this property will automatically set the BWGithubRepoListDataSource as the table view's data source.
@property (weak, nonatomic) UITableView *tableView;

// Factory method for new data source
+ (instancetype)dataSource;

// Method asynchronously fetches next page of repos and updates the table view when those results are ready to display
- (void)fetchNextPageOfReposForSearchTerm:(NSString *)searchTerm;
@end
