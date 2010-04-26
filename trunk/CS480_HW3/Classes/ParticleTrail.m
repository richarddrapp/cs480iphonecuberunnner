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
@synthesize sx;
@synthesize sy;
@synthesize sz;
@synthesize live;


- (ParticleTrail*) initAt:(float)_x :(float)_y :(float)_z :(int)_particles {
	self = [super init];
	sx = _x;
	sy = _y;
	sz = _z;
	
	live = YES;
	
	particles = _particles;
	
	parts = [[NSMutableArray alloc] init];
	
	count = 0;
	
	for (int i = 0; i < particles; i++) {
		[parts addObject: [[ParticleCube alloc] init]];
	}
	
	return self;
}

-(void) updateAndDraw {
	[[parts objectAtIndex:(count%particles)] allocate:sx :sy :sz :.5f :10];
	for (int i = 0; i < particles; i++) {
		[[parts objectAtIndex:i] updateParticle];
		[[parts objectAtIndex:i] drawParticle];
	}
	if (particles < 1) {
		live = NO;
	}
	count++;
}

-(void) setSpawnCoord: (float) x: (float) y: (float) z {
	sx = x;
	sy = y;
	sz = z;
}


@end
