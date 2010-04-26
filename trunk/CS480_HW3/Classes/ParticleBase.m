//
//  ParticleBase.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleBase.h"


@implementation ParticleBase

@synthesize x;
@synthesize y;
@synthesize z;
@synthesize live;

- (ParticleBase*) initAt:(float)_x :(float)_y :(float)_z :(int)_particles {
	self = [super init];
	x = _x;
	y + _y;
	z = _z;
	
	live = YES;
	
	particles = _particles;
	
	parts = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < particles; i++) {
		[parts addObject: [[ParticleCube alloc] init]];
		[[parts objectAtIndex:i] allocate:x :y :z :.5f :10];
	}
	return self;
}

- (void) updateAndDraw {
	for (int i = 0; i < particles; i++) {
		[[parts objectAtIndex:i] updateParticle];
		[[parts objectAtIndex:i] drawParticle];
		if ([[parts objectAtIndex:i] visible] == NO) {
			[[parts objectAtIndex:i] release];
			[parts removeObjectAtIndex:i];
			i--;
			particles--;
		}
	}
	if (particles < 1) {
		live = NO;
		NSLog(@"Live Set to NO");
	}
}

@end
