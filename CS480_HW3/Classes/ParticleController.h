//
//  ParticleController.h
//  CS480_HW3
//
//  Created by Richard Rapp on 4/25/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticleBase.h"


@interface ParticleController : NSObject {
	NSMutableArray *explosions;
	NSMutableArray *trails;
	
	int sx;
	int sy;
	int sz;
}

- (id) init;
- (void) explodeAt: (float)x : (float) y : (float) z;
- (void) trailAt: (float)x : (float) y : (float) z;
- (void) updateAndDraw;
- (void) setShipCoord: (float)x : (float) y : (float) z;

@end
