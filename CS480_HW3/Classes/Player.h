//
//  Player.h
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/25/10.
//  Copyright 2010 Greg Lieberman. All rights reserved.
//
// Represents a player in the game
//

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Player : NSObject {
	
	float x;
	float y;
	float z;
	float scale;
	float rotationZ; // in degrees
	float _material[3];

}

@property float x;
@property float y;
@property float z;
@property float scale;

- (void) setMaterial:(float) x :(float) y :(float) z;
- (void) drawPlayer;


@end
