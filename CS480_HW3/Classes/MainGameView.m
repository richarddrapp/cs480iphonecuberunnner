/*

File: MainGameView.m
Abstract: This class wraps the CAEAGLLayer from CoreAnimation into a convenient
UIView subclass. The view content is basically an EAGL surface you render your
OpenGL scene into.  Note that setting the view non-opaque will only work if the
EAGL surface has an alpha channel.

*/

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "MainGameView.h"
#import "teapot.h"

// CONSTANTS
#define kTeapotScale				3.0
//player bounds
#define kBoundsX					3.0
static float simVelocity = 0.1;

// MACROS
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

// A class extension to declare private methods
@interface MainGameView (private)

- (void) updatePlayer;
- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;
- (void)setupView;
- (void) allowPlayerRespawn:(NSTimer *) timer;

@end

@implementation MainGameView

@synthesize animating;
@dynamic animationFrameInterval;
@synthesize accel;

// Implement this to override the default layer class (which is [CALayer class]).
// We do this so that our view will be backed by a layer that is capable of OpenGL ES rendering.
// this is a static method
+ (Class) layerClass
{
	return [CAEAGLLayer class];
}

// The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
    
    if ((self = [super initWithCoder:coder])) {
		CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
	
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
	
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	
		if (!context || ![EAGLContext setCurrentContext:context]) {
			[self release];
			return nil;
		}
	
		animating = FALSE;
		displayLinkSupported = FALSE;
		animationFrameInterval = 1;
		displayLink = nil;
		animationTimer = nil;
	
		// A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
		// class is used as fallback when it isn't available.
		NSString *reqSysVer = @"3.1";
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
			displayLinkSupported = TRUE;
		
		accel = calloc(3, sizeof(UIAccelerationValue));
		
		//Greg stuff
		spawnManager = [[SpawnManager alloc] init];
		player = [[Player alloc] init];
		player.y = 0;
		player.z = -2;
		
		// initialize the particle controller
		pController = [[ParticleController alloc] init];
		[pController trailAt:0 :0 :-5];
			
		[self setupView];
	}
	
	return self;
}
	
-(void)setupView
{
	//camera and light position
	const GLfloat	lightPosition[] = {-10.0, 3.0, 1.0, 0.0}; 
	const GLfloat	cameraPosition[] = {0.0f, -2.0f, -3.0f};
	
	const GLfloat	lightAmbient[] = {0.25, 0.25, 0.25, 1.0};
	const GLfloat	lightDiffuse[] = {1.0, 0.6, 0.0, 1.0};
	const GLfloat	lightShininess = 100.0;
	
	const GLfloat	matDiffuse[] = {1.0, 1.0, 1.0, 1.0};	
	const GLfloat	matSpecular[] = {1.0, 1.0, 1.0, 1.0};
	
	// clipping stuff
	const GLfloat zNear = 0.1;
	const GLfloat zFar = 1000.0;
	const GLfloat fieldOfView = 60.0;
	GLfloat	size;
	
		
	//Configure OpenGL lighting
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, matDiffuse);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, matSpecular);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, lightShininess);
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT0, GL_POSITION, lightPosition); 			
	
	//important settings
	glShadeModel(GL_SMOOTH);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_NORMALIZE);
	
	// FOG
	// BLACK FOG
	GLfloat fogColor[] = { 0.0, 0.0, 0.0, 1.0 };
	glEnable(GL_FOG);
	
	glFogfv(GL_FOG_COLOR, fogColor);
	glFogf(GL_FOG_DENSITY, 0.025);
	glHint(GL_FOG_HINT, GL_NICEST);
	
	//Set the OpenGL projection matrix
	glMatrixMode(GL_PROJECTION);
	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
	CGRect rect = self.bounds;
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
	glViewport(0, 0, rect.size.width, rect.size.height);
	glTranslatef(cameraPosition[0], cameraPosition[1], cameraPosition[2]);
	glRotatef(30, 1.0, 0.0, 0.0);
	
	
	//Make the OpenGL modelview matrix the default
	glMatrixMode(GL_MODELVIEW);
}

// Updates the OpenGL view
- (void)drawView
{
	// Make sure that I am drawing to the current context
	[EAGLContext setCurrentContext:context];
		
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		
	
	//Magnitude of the acceleration vector
	//GLfloat length = sqrtf(accel[0] * accel[0] + accel[1] * accel[1] + accel[2] * accel[2]);
		
	//Setup model view matrix
	glLoadIdentity();
	
	//update the spawn manager
	if([pController exploding] == NO) {
		[spawnManager update];
	}
	
	//if ship not exploding
	if(playerIsDead == NO) {
		[self updatePlayer];
	}
	
	[spawnManager drawCubes];
	
	
	// update and draw all particles
	
	[pController setShipCoord:player.x : player.y : player.z];
	pController.playerDead = playerIsDead;
	[pController updateAndDrawAll];

	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewColorBuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

//
//helper method to update the player
- (void) updatePlayer {
	
	//update the player with accelerometer information
	player.x += (float) accel[0] / 4;
#if TARGET_IPHONE_SIMULATOR
	player.x += simVelocity;
#endif	
	if(player.x > kBoundsX) {
		player.x = kBoundsX - 0.01;
		simVelocity *= -1;
	}
	if(player.x < -kBoundsX) {
		player.x = -kBoundsX + 0.01;
		simVelocity *= -1;
	}
	
	//test for collision
	if ([spawnManager testPlayerCollision:player]) {
		[pController explodeAt:player.x :player.y :player.z];
		player.x = 0;
		playerIsDead = YES;
		[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(allowPlayerRespawn:) userInfo:nil repeats:NO];
	} else {
		[player drawPlayer];
	}
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[pController shoot];
	NSLog(@"Touch!");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void) shoot {
	NSLog(@"Shoot called from app!");
	[pController shoot];
}

- (void) allowPlayerRespawn:(NSTimer *) timer {
	playerIsDead = NO;
}



// If our view is resized, we'll be asked to layout subviews.
// This is the perfect opportunity to also update the framebuffer so that it is
// the same size as our display area.
-(void)layoutSubviews
{
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}

- (BOOL)createFramebuffer
{
	// get IDs for the framebuffer and color renderbuffer
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewColorBuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewColorBuffer);
	
	// from the EAGL documentation:
	// This call associates the storage for the current render buffer with the EAGLDrawable (our CAEAGLLayer)
	// allowing us to draw into a buffer that will later be rendered to screen wherever the layer is (which corresponds with our view).
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewColorBuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	//build the depth buffer
	glGenRenderbuffersOES(1, &depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);

	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	return YES;
}

// Clean up any buffers we have allocated.
- (void)destroyFramebuffer
{
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	glDeleteRenderbuffersOES(1, &viewColorBuffer);
	viewFramebuffer = 0;
	viewColorBuffer = 0;
	
	if(depthRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}

- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
	if (!animating)
	{
		if (displayLinkSupported)
		{
			// CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
			// if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
			// not be called in system versions earlier than 3.1.
			
			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView)];
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}
		else
			animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView) userInfo:nil repeats:TRUE];
		
		animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (animating)
	{
		if (displayLinkSupported)
		{
			[displayLink invalidate];
			displayLink = nil;
		}
		else
		{
			[animationTimer invalidate];
			animationTimer = nil;
		}
		
		animating = FALSE;
	}
}

- (void)dealloc
{
	free(accel);
	
	if([EAGLContext currentContext] == context)
	{
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];
	[super dealloc];
}

@end
