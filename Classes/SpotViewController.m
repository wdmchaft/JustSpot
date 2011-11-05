//
//  SpotViewController.m
//  JustSpot
//
//  Created by Anton on 02.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpotViewController.h"

@implementation SpotViewController

@synthesize label = _label;
@synthesize message = _message;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	self.label.text = self.message;
	[super viewWillAppear:animated];
}

- (void)viewDidUnload {
	self.label = nil;
	self.message = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[_label release];
	[_message release];
	[super dealloc];
}

@end
