//
//  BWStarredGithubRepoViewController.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWStarredGithubRepoViewController.h"
#import "BWGithubRepoListDataSource.h"

@interface BWStarredGithubRepoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BWGithubRepoListDataSource *dataSource;
@end

@implementation BWStarredGithubRepoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [BWGithubRepoListDataSource dataSource];
    self.dataSource.tableView = self.tableView;
    [self.dataSource fetchReposForSearchTerm:@""];
}

@end
