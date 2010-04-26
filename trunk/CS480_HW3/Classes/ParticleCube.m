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
	
	glPushMatrix();
	
	glScalef(1, 1, 1);
	glTranslatef(x, y, z);
	
	glVertexPointer(3, GL_FLOAT, 0, cubeVertices);	
	glEnableClientState(GL_VERTEX_ARRAY);
	
	//set a color before drawing
	//glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glDrawArrays(GL_TRIANGLE_STRIP, 4, 4);
	
	//glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
	glDrawArrays(GL_TRIANGLE_STRIP, 8, 4);
	glDrawArrays(GL_TRIANGLE_STRIP, 12, 4);
	
	//glColor4f(0.0f, 0.0f, 1.0f, 1.0f);
	glDrawArrays(GL_TRIANGLE_STRIP, 16, 4);
	glDrawArrays(GL_TRIANGLE_STRIP, 20, 4);
	
	//prevent unwanted side effects
	glDisableClientState(GL_VERTEX_ARRAY);
	
	//pop matrix to prevent unwanted side effects 
	glPopMatrix();
}




@end
