//
//  BWGithubRepoTableViewCell.h
//  BrightwheelTakeHome
//
//  Created by Brett Lyon on 9/24/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWGithubRepoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *topContributorLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *contributorSpinner;
@end
