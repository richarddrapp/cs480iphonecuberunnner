//
//  ParticleTrail.h
//  CS480_HW3
//
//  Created by Richard Rapp on 4/26/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParticleTrail : NSObject {
	float x;
	float y;
	float z;
	
	bool live;
	
	int particles;
	
	NSMutableArray *parts;
	NSMutableArray *unallocParts;
	
}

@property float x;
@property float y;
@property float z;
@property bool live;

-(ParticleTrail*) initAt: (float) _x : (float) _y : (float) _z : (int) _particles;
-(void) updateAndDraw;

@end
