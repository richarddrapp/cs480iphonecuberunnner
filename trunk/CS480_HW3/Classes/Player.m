//
//  Player.m
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/25/10.
//  Copyright 2010 Greg Lieberman. All rights reserved.
//

#import "Player.h"

@implementation Player
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


//static variable of the cube model
//override the constructor
-(id)init
{
    if (self = [super init])
    {
		// Initialization code here
		x = 0.0f;
		y = 0.0f;
		z = 0.0f;
		scale = 1.5f;
		rotationZ = 45.0f;
    }
    return self;
}

//called when openGL is ready to draw the cube
- (void) drawPlayer {
	
	//glPushMatrix adds a matrix to the matrix stack
	//it duplicates the matrix on top
	glPushMatrix();
	
	//this should always be commented out
	//glLoadIdentity();
	
	glScalef(scale, scale, scale);
	glRotatef(rotationZ, x, y, z);
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