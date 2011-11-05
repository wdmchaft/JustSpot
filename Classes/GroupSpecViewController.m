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
	/*NSArray *array = [[NSArray alloc] initWithObjects:
					  NSLocalizedStringFromTable(@"BarsAndRestaurantsGroup", @"JustSpotLocalizable", nil),
					  NSLocalizedStringFromTable(@"SportGroup", @"JustSpotLocalizable", nil),
					  NSLocalizedStringFromTable(@"WorkGroup", @"JustSpotLocalizable", nil),
					  NSLocalizedStringFromTable(@"EntertainmentGroup", @"JustSpotLocalizable", nil),
					  NSLocalizedStringFromTable(@"ShopGroup", @"JustSpotLocalizable", nil),
					  NSLocalizedStringFromTable(@"MiscellaneousGroup", @"JustSpotLocalizable", nil),					  
					  nil];
	self.spotsList = array;
	[array release]; */
	[super viewDidLoad];
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
