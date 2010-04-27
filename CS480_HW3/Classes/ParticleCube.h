//
//  ParticleCube.h
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <stdlib.h>
#import <math.h>


@interface ParticleCube : NSObject {
	float x;
	float y;
	float z;
	
	float xSpeed;
	float ySpeed;
	float zSpeed;

	float DRAG;
	
	int life;
	int maxLife;
	
	int type;
	
	float _material[3];
	
	bool visible;
}

@property float x;
@property float y;
@property float z;

@property bool visible;

// constructor
- (ParticleCube*) initParticle;

// allocator function
- (void) allocate: (float) _x : (float) _y : (float) _z : (float) _speed : (int) _life;
- (void) allocateTrail: (float) _x : (float) _y : (float) _z : (float) _speed : (int) _life;
- (void) allocateShot: (float) _x : (float) _y : (float) _z : (float) _speed : (int) _life;


- (void) updateParticle;
- (void) drawParticle;

- (float)dtr:(int)d;

@end
