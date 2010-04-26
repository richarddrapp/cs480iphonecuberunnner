//
//  ParticleCube.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleCube.h"

#define eSize		0.1f
#define tSize		0.04f

@implementation ParticleCube
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize visible;

//static variable of the cube model
static const float exCubeVertices[] = {
	// FRONT
	-eSize, -eSize,  eSize,
	eSize, -eSize,  eSize,
	-eSize,  eSize,  eSize,
	eSize,  eSize,  eSize,
	// BACK
	-eSize, -eSize, -eSize,
	-eSize,  eSize, -eSize,
	eSize, -eSize, -eSize,
	eSize,  eSize, -eSize,
	// LEFT
	-eSize, -eSize,  eSize,
	-eSize,  eSize,  eSize,
	-eSize, -eSize, -eSize,
	-eSize,  eSize, -eSize,
	// RIGHT
	eSize, -eSize, -eSize,
	eSize,  eSize, -eSize,
	eSize, -eSize,  eSize,
	eSize,  eSize,  eSize,
	// TOP
	-eSize,  eSize,  eSize,
	eSize,  eSize,  eSize,
	-eSize,  eSize, -eSize,
	eSize,  eSize, -eSize,
	// BOTTOM
	-eSize, -eSize,  eSize,
	-eSize, -eSize, -eSize,
	eSize, -eSize,  eSize,
	eSize, -eSize, -eSize,
	
};

static const float tCubeVertices[] = {
	// FRONT
	-tSize, -tSize,  tSize,
	tSize, -tSize,  tSize,
	-tSize,  tSize,  tSize,
	tSize,  tSize,  tSize,
	// BACK
	-tSize, -tSize, -tSize,
	-tSize,  tSize, -tSize,
	tSize, -tSize, -tSize,
	tSize,  tSize, -tSize,
	// LEFT
	-tSize, -tSize,  tSize,
	-tSize,  tSize,  tSize,
	-tSize, -tSize, -tSize,
	-tSize,  tSize, -tSize,
	// RIGHT
	tSize, -tSize, -tSize,
	tSize,  tSize, -tSize,
	tSize, -tSize,  tSize,
	tSize,  tSize,  tSize,
	// TOP
	-tSize,  tSize,  tSize,
	tSize,  tSize,  tSize,
	-tSize,  tSize, -tSize,
	tSize,  tSize, -tSize,
	// BOTTOM
	-tSize, -tSize,  tSize,
	-tSize, -tSize, -tSize,
	tSize, -tSize,  tSize,
	tSize, -tSize, -tSize,
	
};


- (ParticleCube*) initParticle {
	self = [super init];
	
	x = 0.0f;
	y = 0.0f;
	z = 0.0f;
	
	xSpeed = 0.0f;
	ySpeed = 0.0f;
	zSpeed = 0.0f;
	
	visible = NO;
	
	life = 0.0f;
	maxLife = 0.0f;
	
	type = 0;
	
	_material[0] = 0.8f;
	_material[1] = 0.0f;
	_material[2] = 0.8f;
	
	float rmod = (arc4random() % 2);
	rmod /= 5;
	_material[0] += rmod;
	
	
	return self;
}

- (void) allocate:(float)_x :(float)_y :(float)_z :(float)_speed :(int)_life {
	x = _x;
	y = _y;
	z = _z;
	
	life = _life;
	maxLife = _life;
	
	type = 1;
	
	int angleVert = arc4random() % 180;
	int angleRot = arc4random() % 360;
	
	xSpeed = _speed * sin( [self dtr: angleVert] ) * cos( [self dtr: angleRot] );
	ySpeed = _speed * cos( [self dtr: angleVert] );
	zSpeed = _speed * sin( [self dtr: angleVert] ) * sin( [self dtr: angleRot] );
	
	visible = YES;
	
	_material[0] = 0.8f;
	_material[1] = 0.8f;
	_material[2] = 0.0f;
}

- (void) allocateTrail:(float)_x :(float)_y :(float)_z :(float)_speed :(int)_life {
	x = _x;
	y = _y;
	z = _z;
	
	life = _life;
	maxLife = _life;
	
	type = 2;
	
	int angleVert = arc4random() % 20;
	int angleRot = arc4random() % 360;
	//angleVert = 0;
	//angleRot = 0;
	
	ySpeed = _speed * sin( [self dtr: angleVert] ) * cos( [self dtr: angleRot] );
	zSpeed = _speed * cos( [self dtr: angleVert] );
	xSpeed = _speed * sin( [self dtr: angleVert] ) * sin( [self dtr: angleRot] );
	
	visible = YES;
	
	_material[0] = 0.8f;
	_material[1] = 0.8f;
	_material[2] = 0.0f;
}

- (void) updateParticle {
	x += xSpeed;
	y += ySpeed;
	z += zSpeed;
	
	life--;
	
	if (life < 0) {
		visible = NO;
	}
}

- (void) drawParticle {
	
	if (visible) {
		
		//glPushMatrix adds a matrix to the matrix stack
		//it duplicates the matrix on top
		glPushMatrix();
		
		//this should always be commented out
		//glLoadIdentity();
		
		// scale rotate translate
		glScalef(1, 1, 1);
		glTranslatef(x, y, z);
		
		//Configure OpenGL arrays	
		glEnableClientState(GL_VERTEX_ARRAY);	
		glEnableClientState(GL_NORMAL_ARRAY);
		if (type == 2) {
			glVertexPointer(3, GL_FLOAT, 0, tCubeVertices);	
		} else {
			glVertexPointer(3, GL_FLOAT, 0, exCubeVertices);	
		}
		
		//material color
		glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, _material);
		
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
		glDrawArrays(GL_TRIANGLE_STRIP, 4, 4);
		
		glDrawArrays(GL_TRIANGLE_STRIP, 8, 4);
		glDrawArrays(GL_TRIANGLE_STRIP, 12, 4);
		
		glDrawArrays(GL_TRIANGLE_STRIP, 16, 4);
		glDrawArrays(GL_TRIANGLE_STRIP, 20, 4);
		
		//prevent unwanted side effects
		glDisableClientState(GL_VERTEX_ARRAY);
		glDisableClientState(GL_NORMAL_ARRAY);
		
		//pop matrix to prevent unwanted side effects 
		glPopMatrix();
		
	}
}

- (float)dtr:(int)d {
	return d / 57.2958;
}


@end
