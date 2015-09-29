//
//  BWStarredGithubRepoViewController.m
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWStarredGithubRepoViewController.h"
#import "BWGithubRepoListDataSource.h"

@interface BWStarredGithubRepoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BWGithubRepoListDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *tapToDismissKeyboardContainer;
@end

@implementation BWStarredGithubRepoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [BWGithubRepoListDataSource dataSource];
    self.dataSource.tableView = self.tableView;
    [self.dataSource fetchNextPageOfReposForSearchTerm:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Kick off a search
    [self.dataSource fetchNextPageOfReposForSearchTerm:textField.text];
    
    // Dismiss the keyboard
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UI actions

- (IBAction)tapToDismissKeyboard:(id)sender {
    // Dismiss the keyboard
    [self.searchTextField resignFirstResponder];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    self.tapToDismissKeyboardContainer.hidden = NO;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.tapToDismissKeyboardContainer.hidden = YES;
}

@end
