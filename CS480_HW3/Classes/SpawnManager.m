//
//  SpawnManager.m
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/25/10.
//  Copyright 2010 Greg Lieberman. All rights reserved.
//

#import "SpawnManager.h"

// A class extension to declare private methods
@interface SpawnManager (private)

- (void) trySpawnCube:(NSTimer*)theTimer;


@end


@implementation SpawnManager

//@public

//override the constructor
-(id)init
{
    if (self = [super init])
    {
		// Initialization code here
		spawnTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(trySpawnCube:) userInfo:nil repeats:YES];
		cubes = [[NSMutableArray alloc] init];
		totalCubesSpawned = 0;
    }
    return self;
}



//updates the state of the spawn manager
- (void) update {
	
	Cube *currentCube;
	int arrayCount = [cubes count];
	for (int i=0; i<arrayCount; i++) {
		currentCube = [cubes objectAtIndex:i];
		//move all of the cubes
		currentCube.z += 0.02f;
		//determine if any need to be deleted
		if (currentCube.z > 0.0f) {
			NSLog(@"Removing cube");
			[cubes removeObjectAtIndex:i];
			[currentCube release];
			i--;
		}
	}
}



- (void) drawCubes {
	Cube *currentCube;
	int arrayCount = [cubes count];
	for (int i=0; i<arrayCount; i++) {
		currentCube = [cubes objectAtIndex:i];
		[currentCube drawCube];
	}
}



//@private

// determine if I need to spawn a new cube
// called every once in a while
- (void) trySpawnCube:(NSTimer*)theTimer {
	
	if ([cubes count] < kMaxCubes) {
		totalCubesSpawned++;
		NSLog(@"Spawning cube: %i", totalCubesSpawned);
		Cube *newCube = [[Cube alloc] init];
		newCube.z = -10;
		//needs to be done on 2 seperate lines for some arbitrary reason
		newCube.x = (arc4random() % 8);
		newCube.x -= 4;
		[cubes addObject:newCube];
		
	}
}



@end
