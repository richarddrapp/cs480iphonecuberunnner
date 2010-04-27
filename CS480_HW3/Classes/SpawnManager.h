//
//  SpawnManager.h
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/25/10.
//  Copyright 2010 Greg Lieberman. All rights reserved.
//
// Manages spawning of cubes in the game
// Call update() to update state
// Call drawCubes() to do an OpenGL draw
//

#import "Cube.h";
#import <Foundation/Foundation.h>
#import "ParticleCube.h"

#define kMaxCubes	10

@class Player;

@interface SpawnManager : NSObject {
	NSMutableArray *cubes;
	NSTimer *spawnTimer;
	int totalCubesSpawned;
}

- (void) update;
- (void) drawCubes;
- (BOOL) testPlayerCollision:(Player *) player;
- (BOOL) testBulletCollision:(ParticleCube *) bullet;

@end
