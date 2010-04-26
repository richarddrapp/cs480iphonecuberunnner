//
//  ParticleTrail.h
//  CS480_HW3
//
//  Created by Richard Rapp on 4/26/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParticleTrail : NSObject {
	float sx;
	float sy;
	float sz;
	
	bool live;
	
	int particles;
	
	NSMutableArray *parts;
	NSMutableArray *unallocParts;
	
}

@property float sx;
@property float sy;
@property float sz;
@property bool live;

-(ParticleTrail*) initAt: (float) _x : (float) _y : (float) _z : (int) _particles;
-(void) updateAndDraw;
-(void) setSpawnCoord:(float)x :(float)y :(float)z;

@end
