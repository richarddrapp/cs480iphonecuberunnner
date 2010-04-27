//
//  ParticleCannon.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/26/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleCannon.h"
#import "ParticleTrail.h"
#import "ParticleCube.h"

@implementation ParticleCannon


@synthesize sx;
@synthesize sy;
@synthesize sz;
@synthesize live;


- (ParticleCannon*) initAt:(float)_x :(float)_y :(float)_z {
	self = [super init];
	sx = _x;
	sy = _y;
	sz = _z;
	
	live = YES;
	
	particles = 5;
	
	shots = [[NSMutableArray alloc] init];
	unallocShots = [[NSMutableArray alloc] init];
	
	count = 0;
	
	for (int i = 0; i < particles; i++) {
		[unallocShots addObject: [[ParticleCube alloc] initParticle]];
	}
	
	return self;
}

-(void) updateAndDraw {
	for (int i = 0; i < [shots count]; i++) {
		[[shots objectAtIndex:i] updateParticle];
		[[shots objectAtIndex:i] drawParticle];
	}
	if (particles < 1) {
		live = NO;
	}
	for (int i = 0; i < [shots count]; i++) {
		if ([[shots objectAtIndex:i] visible] == NO) {
			[unallocShots addObject:[shots objectAtIndex:i]];
			[shots removeObjectAtIndex:i];
			i--;
		}
	}
}


-(void) setSpawnCoord: (float) x: (float) y: (float) z {
	sx = x;
	sy = y;
	sz = z;
}

-(void) shoot {
	if ([unallocShots count] > 0) {
		[[unallocShots objectAtIndex:0] allocateShot:sx :sy :sz :-.5 :50];
		[shots addObject: [unallocShots objectAtIndex:0]];
		[unallocShots removeObjectAtIndex:0];
		NSLog(@"Shots fired!");
	} else {
		NSLog(@"out of bullets!");
	}
}

@end
