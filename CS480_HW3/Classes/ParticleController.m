//
//  ParticleController.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleController.h"
#import "ParticleBase.h"


@implementation ParticleController

-(id) init {
	self = [super init];
	
	explosions = [[NSMutableArray alloc] init];
	
	return self;
}

-(void) explodeAt:(int)x :(int)y :(int)z {
	[explosions addObject:[[ParticleBase alloc] initAt:x :y :z :50]];
}

-(void) updateAndDraw {
	for (int i = 0; i < [explosions count]; i++) {
		[[explosions objectAtIndex:i] updateAndDraw];
		if ([[explosions objectAtIndex:i] live] == NO) {
			NSLog(@"Removing explosion begin");
			[[explosions objectAtIndex:i] release];
			[explosions removeObjectAtIndex:i];
			i--;
			NSLog(@"Removing explosion done");
		}
	}
}

@end
