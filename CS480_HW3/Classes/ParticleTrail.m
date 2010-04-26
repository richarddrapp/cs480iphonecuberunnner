//
//  ParticleTrail.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/26/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleTrail.h"
#import "ParticleCube.h"


@implementation ParticleTrail
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize live;


- (ParticleTrail*) initAt:(float)_x :(float)_y :(float)_z :(int)_particles {
	self = [super init];
	x = _x;
	y = _y;
	z = _z;
	
	live = YES;
	
	particles = _particles;
	
	parts = [[NSMutableArray alloc] init];
	unallocParts = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < particles; i++) {
		[unallocParts addObject: [[ParticleCube alloc] init]];
	}
	return self;
}

-(void) updateAndDraw: (float) _x: (float) _y: (float) _z {
	x = _x;
	y = _y;
	x = _z;

	if ([unallocParts count] > 0) {
		[[parts objectAtIndex:0] allocate:x :y :z :.5f :10];
		[parts addObject: [unallocParts objectAtIndex:0]];
		[unallocParts removeObjectAtIndex:0];
	}
	for (int i = 0; i < particles; i++) {
		[[parts objectAtIndex:i] updateParticle];
		[[parts objectAtIndex:i] drawParticle];
		if ([[parts objectAtIndex:i] visible] == NO) {
			[unallocParts addObject: [parts objectAtIndex:i]];
			[parts removeObjectAtIndex:i];
		}
	}
	if (particles < 1) {
		live = NO;
	}
}


@end
