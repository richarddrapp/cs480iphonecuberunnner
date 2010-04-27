/*

 This class is based on the EAGL template provided in XCode
 
File: MainGameView.h
Abstract: This class wraps the CAEAGLLayer from CoreAnimation into a convenient
UIView subclass. The view content is basically an EAGL surface you render your
OpenGL scene into.  Note that setting the view non-opaque will only work if the
EAGL surface has an alpha channel.

*/

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Cube.h"
#import "SpawnManager.h"
#import "Player.h"
#import "ParticleController.h"

@interface MainGameView : UIView
{
@private
	// The pixel dimensions of the backbuffer
	GLint backingWidth;
	GLint backingHeight;
	
	EAGLContext *context;
	
	// The renderbuffer and framebuffers
	GLuint viewColorBuffer, viewFramebuffer;
	
	// OpenGL name for the depth buffer that is attached to viewFramebuffer
	GLuint depthRenderbuffer;
	
	BOOL animating;
	BOOL displayLinkSupported;
	NSInteger animationFrameInterval;
	// Use of the CADisplayLink class is the preferred method for controlling your animation timing.
	// CADisplayLink will link to the main display and fire every vsync when added to a given run-loop.
	// The NSTimer class is used only as fallback when running on a pre 3.1 device where CADisplayLink
	// isn't available.
	id displayLink;
    NSTimer *animationTimer;
	
	//this value gets set automatically by the application delegate
	UIAccelerationValue	*accel;
	
	//Greg's Stuff
	SpawnManager *spawnManager;
	Player *player;
	NSTimer *playerSpawnTimer;
	BOOL playerIsDead;
	
	//Particle stuff
	ParticleController *pController;
	
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

@property (nonatomic) UIAccelerationValue *accel;

-(void)startAnimation;
-(void)stopAnimation;
-(void)drawView;
-(void)shoot;

@end
