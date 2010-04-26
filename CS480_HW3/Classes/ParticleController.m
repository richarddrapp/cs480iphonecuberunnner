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

-(id) init {
	self = [super init];
	
	explosions = [[NSMutableArray alloc] init];
	sx = 0;
	sy = 0;
	sz = 0;
	
	return self;
}

-(void) explodeAt:(float)x : (float) y : (float) z {
	[explosions addObject:[[ParticleBase alloc] initAt:x :y :z :50]];
}
-(void) trailAt:(float)x : (float) y : (float) z; {
	[trails addObject:[[ParticleTrail alloc] initAt:x :y :z :50]];
}

-(void) updateAndDraw {
	for (int i = 0; i < [explosions count]; i++) {
		[[explosions objectAtIndex:i] updateAndDraw];
		if ([[explosions objectAtIndex:i] live] == NO) {
			[[explosions objectAtIndex:i] release];
			[explosions removeObjectAtIndex:i];
			i--;
		}
	}
	for (int i = 0; i < [trails count]; i++) {
		[[trails objectAtIndex:i] updateAndDraw: sx: sy: sz];
	}
}

-(void) setShipCoord:(float)x :(float)y :(float)z {
	sx = x;
	sy = y;
	sz = z;
}

@end
