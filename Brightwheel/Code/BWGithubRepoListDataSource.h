//
//  BWGithubRepoListDataSource.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

/*
 
 This class conforms to UITableViewDataSource protocol and is responsible for providing a table view with cells displaying github repositories (along with their top contributor), and error or loading states when necessary. This class also makes sure network calls and long running operations are executed off the main thread.
 
 It implements a method which triggers a fetch for a search term.
 
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BWGithubRepoListDataSource : NSObject
@property (assign, nonatomic) NSUInteger pageSize;
@property (assign, nonatomic) NSUInteger fetchThreshold;
@property (assign, nonatomic) NSInteger maxNumberResults;
@property (weak, nonatomic) UITableView *tableView;
+ (instancetype)dataSource;
- (void)fetchReposForSearchTerm:(NSString *)searchTerm;
@end
