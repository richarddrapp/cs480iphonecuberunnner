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
}

- (id) init;
- (void) explodeAt: (int)x : (int)y : (int)z;
- (void) updateAndDraw;

@end
