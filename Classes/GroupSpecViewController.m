//
//  GroupSpecViewController.m
//  JustSpot
//
//  Created by Anton Grachev on 01.10.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import "GroupSpecViewController.h"
#import "JustSpotAppDelegate.h"
#import "SpotViewController.h"

@implementation GroupSpecViewController

@synthesize spotsList = _spotsList;
@synthesize rowImage = _rowImage;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)viewDidLoad {
	
	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] 
													  initWithTarget:self action:@selector(handleLongPress:)];
	longPressGesture.minimumPressDuration = 2.0; //seconds
	longPressGesture.delegate = self;
	[self.tableView addGestureRecognizer:longPressGesture];
	[longPressGesture release];
	
	[super viewDidLoad];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{	
	[self.tableView setEditing: YES animated: YES];
	
	UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																style:UIBarButtonItemStyleDone
															   target:self 
															   action:@selector(editDone)];
	self.navigationItem.rightBarButtonItem = doneBtn;
	[doneBtn release];
	
	UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"Add"
															   style:UIBarButtonItemStylePlain
															  target:self 
															  action:nil];
	self.navigationItem.leftBarButtonItem = addBtn;
	[addBtn release];
	
}

- (void)editDone {
	[self.tableView setEditing:NO animated:YES];
	self.navigationItem.rightBarButtonItem = nil;
	self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidUnload {
	self.spotsList = nil;
	[spotController release], spotController = nil;
}

- (void)dealloc {
	[_spotsList release];
	[spotController release];
	[super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
	return [self.spotsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString * spotButtonCellIdentifier = @"SpotButtonCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: spotButtonCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:spotButtonCellIdentifier] autorelease];
	}
	NSUInteger row = [indexPath row];
	NSString *rowString = [self.spotsList objectAtIndex:row];
	cell.textLabel.text = rowString;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton; 
	[rowString release];
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath { 
}

@end
