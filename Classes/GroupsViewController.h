//
//  GroupsViewController.h
//  JustSpot
//
//  Created by Anton Grachev on 01.10.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsViewController : UITableViewController <UIGestureRecognizerDelegate> 

@property (nonatomic, retain) NSMutableArray *controllers;

- (void)editDone;

@end
