//
//  Cube.m
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/25/10.
//  Copyright 2010 Greg Lieberman. All rights reserved.
//

#import "Cube.h"


@implementation Cube
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize scale;

//static variable of the cube model
static const float cubeVertices[] = {
	// FRONT
	-0.5f, -0.5f,  0.5f,
	0.5f, -0.5f,  0.5f,
	-0.5f,  0.5f,  0.5f,
	0.5f,  0.5f,  0.5f,
	// BACK
	-0.5f, -0.5f, -0.5f,
	-0.5f,  0.5f, -0.5f,
	0.5f, -0.5f, -0.5f,
	0.5f,  0.5f, -0.5f,
	// LEFT
	-0.5f, -0.5f,  0.5f,
	-0.5f,  0.5f,  0.5f,
	-0.5f, -0.5f, -0.5f,
	-0.5f,  0.5f, -0.5f,
	// RIGHT
	0.5f, -0.5f, -0.5f,
	0.5f,  0.5f, -0.5f,
	0.5f, -0.5f,  0.5f,
	0.5f,  0.5f,  0.5f,
	// TOP
	-0.5f,  0.5f,  0.5f,
	0.5f,  0.5f,  0.5f,
	-0.5f,  0.5f, -0.5f,
	0.5f,  0.5f, -0.5f,
	// BOTTOM
	-0.5f, -0.5f,  0.5f,
	-0.5f, -0.5f, -0.5f,
	0.5f, -0.5f,  0.5f,
	0.5f, -0.5f, -0.5f,
};

static const float cubeNormals[] = {
	// FRONT
	0.0f, 0.0f, 1.0f,
	// BACK
	0.0f, 0.0f, -1.0f,
	// LEFT
	-1.0f, 0.0f, 0.0f,
	// RIGHT
	1.0f, 0.0f, 0.0f,
	// TOP
	0.0f, 1.0f, 0.0f,
	// BOTTOM
	0.0f, -1.0f, 0.0f,
};


//override the constructor
-(id)init
{
    if (self = [super init])
    {
		// Initialization code here
		x = 0.0f;
		y = 0.0f;
		z = 0.0f;
		scale = 1.0f;
		//default material color
		_material[0] = 0.8f;
		_material[1] = 0.0f;
		_material[2] = 0.8f;
    }
    return self;
}

- (void) setMaterial:(float) r :(float) g :(float) b {
	_material[0] = r;
	_material[1] = g;
	_material[2] = b;
}


//called when openGL is ready to draw the cube
- (void) drawCube {
	
	//glPushMatrix adds a matrix to the matrix stack
	//it duplicates the matrix on top
	glPushMatrix();
	
	//this should always be commented out
	//glLoadIdentity();
	
	// scale rotate translate
	glScalef(scale, scale, scale);
	glTranslatef(x, y, z);
	
	//Configure OpenGL arrays	
	glEnableClientState(GL_VERTEX_ARRAY);	
	glEnableClientState(GL_NORMAL_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, cubeVertices);	
	glNormalPointer(GL_FLOAT, 0, cubeNormals);
	
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
