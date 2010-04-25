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

//called when openGL is ready to draw the cube
- (void) drawCube {
	
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
	 
	 //disable to prevent messing up other code elsewhere
	 glDisableClientState(GL_VERTEX_ARRAY);
	 
}



@end
