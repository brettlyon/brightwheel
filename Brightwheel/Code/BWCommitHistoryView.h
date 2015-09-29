//
//  BWCommitHistoryView.h
//  Brightwheel
//
//  Created by Brett Lyon on 9/29/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 This view class takes an array representing a commit frequency, and draws a chart of the frequency data.
 */

@interface BWCommitHistoryView : UIView

// Array corresponding to the commit frequency history. Setting this property will cause the view to draw the graph
@property (strong, nonatomic) NSArray *commitHistory;
@end
