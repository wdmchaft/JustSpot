//
//  PathBuilder.m
//  JustSpot
//
//  Created by Anton Grachev on 05.05.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import "PathBuilder.h"


@implementation PathBuilder

// Path to applications's Documents directory

+(NSString *)documentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// URL to application's database

+(NSURL *)databaseURL {
	NSURL *documentsURL = [NSURL fileURLWithPath:[PathBuilder documentsDirectory]];
	return [documentsURL URLByAppendingPathComponent:@"justspot.sqlite"];
}

@end
