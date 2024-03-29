//
//  Ship.h
//  CS480_HW3
//
//  Created by Anthony Ghavami on 4/25/10.
//  Copyright 2010 USC. All rights reserved.
//

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Ship : NSObject {
	//x, y, z properties don't do anything right now
	//to make them work
	//the cube needs to store it's own worldTransform matrix
	// does openGL handle that? I think it does. Investigate.
	
	//a possible hack is for each instance to store its own modified vertex coordinates
	//and re-build the modified vertex coordinates every time x, y, or z is set
	
	float x;
	float y;
	float z;
	float scale;
	
}

@property float x;
@property float y;
@property float z;
@property float scale;

- (void) drawShip;


@end

