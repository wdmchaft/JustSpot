//
//  GroupsViewController.m
//  JustSpot
//
//  Created by Anton Grachev on 01.10.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import "GroupsViewController.h"
#import "GroupSpecViewController.h"
#import "DataSource.h"

@implementation GroupsViewController

@synthesize controllers = _controllers;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)viewDidLoad {
	self.title = @"Groups";
	
	NSEntityDescription *groupEntityDescription = [NSEntityDescription entityForName:@"Group"
															   inManagedObjectContext:[[DataSource shared] managedObjectContext]];
	NSFetchRequest *groupRequest = [[NSFetchRequest alloc] init];
	[groupRequest setEntity:groupEntityDescription];
	
	NSError *error;
	NSArray *groupObjects = [[[DataSource shared] managedObjectContext] executeFetchRequest:groupRequest error:&error];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (id obj in groupObjects ) {
		GroupSpecViewController *groupSpecViewController = [[GroupSpecViewController alloc] initWithStyle:UITableViewStylePlain];
		groupSpecViewController.title = [obj valueForKey:@"name"];
		[array addObject:groupSpecViewController];
		[groupSpecViewController release];
	}
	
	self.controllers = array;
	[array release];
	
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
	self.controllers = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[_controllers release];
	[super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *groupsCell = @"GroupsCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 groupsCell];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier: groupsCell] autorelease];
	}
	// Configure the cell
	NSUInteger row = [indexPath row]; 
	GroupSpecViewController *controller = [self.controllers objectAtIndex:row]; 
	cell.textLabel.text = controller.title; 
	cell.imageView.image = controller.rowImage;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
	NSUInteger row = [indexPath row];
	GroupSpecViewController *nextController = [self.controllers
												 objectAtIndex:row]; 
	[self.navigationController pushViewController:nextController animated:YES];
}


@end
