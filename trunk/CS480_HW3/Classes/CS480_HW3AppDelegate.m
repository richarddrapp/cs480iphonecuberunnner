//
//  CS480_HW3AppDelegate.m
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/22/10.
//  Copyright Greg Lieberman 2010. All rights reserved.
//

#import "CS480_HW3AppDelegate.h"
//#import "EAGLView.h"
#import "MainGameView.h"
#import "MainGameViewController.h"

// CONSTANTS
#define kAccelerometerFrequency		100.0 // Hz
#define kFilteringFactor			0.1

@implementation CS480_HW3AppDelegate

@synthesize window;
@synthesize glView;
@synthesize startupView;
@synthesize startButton;
@synthesize lblMessage;
@synthesize player;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
	[window addSubview:startupView];
    [window makeKeyAndVisible];
	
    //[glView startAnimation];
//	
//	//lets configure the accelerometer
//	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
//	[[UIAccelerometer sharedAccelerometer] setDelegate:self];	
	
    return YES;
}

// delegate method
- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                        successfully: (BOOL) completed {
    if (completed == YES) {
        self.startButton.enabled = YES;
    }
}

// 
- (IBAction) play {
	
	self.startButton.enabled = NO;
	[self.player play];
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [glView stopAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [glView stopAnimation];
}

// here is where I listen for the accelerometer
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	//Use a basic low-pass filter to only keep the gravity in the accelerometer values
	accel[0] = acceleration.x * kFilteringFactor + accel[0] * (1.0 - kFilteringFactor);
	accel[1] = acceleration.y * kFilteringFactor + accel[1] * (1.0 - kFilteringFactor);
	accel[2] = acceleration.z * kFilteringFactor + accel[2] * (1.0 - kFilteringFactor);
	
	//Update the accelerometer values for the view
	[glView setAccel:accel];
}

- (IBAction)startGame{
	
	//Sound stuff
	NSString *soundFilePath =
	[[NSBundle mainBundle] pathForResource: @"music"
									ofType: @"wav" inDirectory: @"/"];
	
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *newPlayer =
	[[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
										   error: nil];
	[fileURL release];	
	self.player = newPlayer;
	[newPlayer release];	
	[player prepareToPlay];
	[player setDelegate: self];
	
	[startupView removeFromSuperview];
	[window addSubview: glView];
	
	NSString *msg = [[NSString alloc] initWithString:@" "];
	[lblMessage setText:msg];
	[msg release];
	
	
	[glView startAnimation];
	
	//lets configure the accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	
	self.startButton.enabled = NO;
	[self.player play];
	
	[startButton setHidden:YES];
	[startButton setAlpha:0.00f];
	[startButton removeFromSuperview];
	[startButton release];
	
	[startupView removeFromSuperview];
	
	[self play];
	//[startupView setHidden:YES];
	//[startupView setAlpha:0.00f];
}


- (void)dealloc
{
    [window release];
    [glView release];

    [super dealloc];
}

@end
