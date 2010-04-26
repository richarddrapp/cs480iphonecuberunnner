//
//  ParticleCube.m
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "ParticleCube.h"


@implementation ParticleCube
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize visible;

//static variable of the cube model
static const float cubeVertices[] = {
	// FRONT
	-0.1f, -0.1f,  0.1f,
	0.1f, -0.1f,  0.1f,
	-0.1f,  0.1f,  0.1f,
	0.1f,  0.1f,  0.1f,
	// BACK
	-0.1f, -0.1f, -0.1f,
	-0.1f,  0.1f, -0.1f,
	0.1f, -0.1f, -0.1f,
	0.1f,  0.1f, -0.1f,
	// LEFT
	-0.1f, -0.1f,  0.1f,
	-0.1f,  0.1f,  0.1f,
	-0.1f, -0.1f, -0.1f,
	-0.1f,  0.1f, -0.1f,
	// RIGHT
	0.1f, -0.1f, -0.1f,
	0.1f,  0.1f, -0.1f,
	0.1f, -0.1f,  0.1f,
	0.1f,  0.1f,  0.1f,
	// TOP
	-0.1f,  0.1f,  0.1f,
	0.1f,  0.1f,  0.1f,
	-0.1f,  0.1f, -0.1f,
	0.1f,  0.1f, -0.1f,
	// BOTTOM
	-0.1f, -0.1f,  0.1f,
	-0.1f, -0.1f, -0.1f,
	0.1f, -0.1f,  0.1f,
	0.1f, -0.1f, -0.1f,
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
	
	_material[0] = 0.8f;
	_material[1] = 0.0f;
	_material[2] = 0.8f;
	
	return self;
}

- (void) allocate:(float)_x :(float)_y :(float)_z :(float)_speed :(int)_life {
	x = _x;
	y = _y;
	z = _z;
	
	life = _life;
	maxLife = _life;
	
	int angleVert = arc4random() % 180;
	int angleRot = arc4random() % 360;
	
	xSpeed = _speed * sin( angleVert ) * cos( angleRot );
	ySpeed = _speed * cos( angleVert );
	zSpeed = _speed * sin( angleVert ) * sin( angleRot );
	
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
	glVertexPointer(3, GL_FLOAT, 0, cubeVertices);	
	
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




@end
