//
//  ParticleBase.h
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <stdlib.h>
#import <math.h>
#import "ParticleCube.h"


@interface ParticleBase : NSObject {
	float x;
	float y;
	float z;
	
	bool live;
	
	int particles;
	
	NSMutableArray *parts;
}

@property float x;
@property float y;
@property float z;
@property bool live;


- (ParticleBase*) initAt: (float) _x : (float) _y : (float) _z : (int) _particles;
- (void) updateAndDraw;

@end
