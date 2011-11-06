//
//  DataSource.m
//  JustSpot
//
//  Created by Anton Grachev on 05.05.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import "DataSource.h"
#import "PathBuilder.h"


@implementation DataSource

- (void)initDatabase {
	if ( ![[NSFileManager defaultManager] fileExistsAtPath:[[PathBuilder documentsDirectory] stringByAppendingPathComponent:@"justspot.sqlite"]] ) {
		NSArray *defaultGroups = [[NSArray alloc] initWithObjects:@"Bars and restaurants", @"Entertainment", @"Shops", 
								  @"Work", @"Miscellaneous", @"Sport", nil];
		
		NSEntityDescription *groupEntityDescription = [NSEntityDescription entityForName:@"Group" 
																  inManagedObjectContext:[[DataSource shared] managedObjectContext]];
		
		for (NSString *group in defaultGroups) {
			NSManagedObject *groupToSave = [[NSManagedObject alloc] initWithEntity:groupEntityDescription 
													insertIntoManagedObjectContext:[[DataSource shared] managedObjectContext]];
			[groupToSave setValue:group forKey:@"name"];
		}
		
		[[DataSource shared] saveContext];
	}
}

- (void)saveContext {
		NSError *error = nil;
		NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
		if (managedObjectContext != nil) {
			if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
				NSLog(@"iLocker: can't save managed object context, error %@, %@", error, [error userInfo]);
				abort();	
			} 
		}	
}

- (void)removeGroup:(NSString *)group {
	NSEntityDescription *groupEntityDescription = [NSEntityDescription entityForName:@"Group"
															  inManagedObjectContext:[[DataSource shared] managedObjectContext]];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K = %@)",	@"name", group]; 
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:groupEntityDescription];
	[request setPredicate:predicate];
	
	NSError *error;
	NSArray *groupObjects = [[[DataSource shared] managedObjectContext] executeFetchRequest:request error:&error];
	[request release];
	
	for (id obj in groupObjects) {
		[[[DataSource shared] managedObjectContext] deleteObject:obj];
	}
	
	[[DataSource shared] saveContext];
}

+ (DataSource *)shared 
{ 
    static dispatch_once_t once; 
    static DataSource *instance; 
    dispatch_once(&once, ^{
        instance = [DataSource new]; 
    }); 
    return instance; 
}

- (void)dealloc
{
	[managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Core Data

- (NSManagedObjectContext *)managedObjectContext 
{
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) 
	{
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
		[managedObjectContext_ setUndoManager:nil]; // undo disabled
    }
    return managedObjectContext_;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"JustSpot" withExtension:@"mom"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *databaseUrl = [PathBuilder databaseURL];
	NSLog(@"db url: %@", databaseUrl);
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:databaseUrl options:options error:&error]) 
	{
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}

@end
