//
//  DataSource.h
//  JustSpot
//
//  Created by Anton Grachev on 05.05.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DataSource : NSObject {
	NSManagedObjectContext *managedObjectContext_;
	NSManagedObjectModel *managedObjectModel_;
	NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)initDatabase;
- (void)saveContext;

- (void)removeGroup:(NSString *)group;

+ (DataSource *)shared;

@end
