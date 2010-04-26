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
	float width;
	float height;
	float depth;
}

@property float x;
@property float y;
@property float z;
@property float scale;
@property (readonly) float width;
@property (readonly) float height;
@property (readonly) float depth;

- (void) setMaterial:(float) x :(float) y :(float) z;
- (void) drawPlayer;


@end
