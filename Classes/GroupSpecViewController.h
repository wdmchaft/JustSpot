//
//  GroupSpecViewController.h
//  JustSpot
//
//  Created by Anton Grachev on 01.10.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpotViewController;

@interface GroupSpecViewController : UITableViewController {
	SpotViewController *spotController;
}

@property (nonatomic, retain) NSArray *spotsList;
@property (nonatomic, retain) UIImage *rowImage;

@end
