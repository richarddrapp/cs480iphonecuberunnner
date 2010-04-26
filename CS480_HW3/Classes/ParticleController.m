//
//  ParticleController.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleController.h"
#import "ParticleBase.h"
#import "ParticleTrail.h"


@implementation ParticleController
@synthesize exploding;

-(id) init {
	self = [super init];
	
	explosions = [[NSMutableArray alloc] init];
	trails = [[NSMutableArray alloc] init];
	sx = 0;
	sy = 0;
	sz = -5;
	
	return self;
}

-(void) explodeAt:(float)x : (float) y : (float) z {
	[explosions addObject:[[ParticleBase alloc] initAt:x :y :z :50]];
}
-(void) trailAt:(float)x : (float) y : (float) z; {
	[trails addObject:[[ParticleTrail alloc] initAt:x :y :z :500]];
}

-(void) updateAndDrawAll {
	for (int i = 0; i < [explosions count]; i++) {
		[[explosions objectAtIndex:i] updateAndDraw];
		if ([[explosions objectAtIndex:i] live] == NO) {
			[[explosions objectAtIndex:i] release];
			[explosions removeObjectAtIndex:i];
			i--;
		}
	}
	if (!exploding) {
		for (int j = 0; j < [trails count]; j++) {		
			[[trails objectAtIndex:j] setSpawnCoord:sx :sy :sz];
			[[trails objectAtIndex:j] updateAndDraw];		
		}
	}
	if ([explosions count] > 0) {
		exploding = YES;
	} else {
		exploding = NO;
	}
}

-(void) setShipCoord:(float)x :(float)y :(float)z {
	sx = x;
	sy = y;
	sz = z;
}

@end
