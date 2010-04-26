//
//  CS480_HW3AppDelegate.h
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/22/10.
//  Copyright Greg Lieberman 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//@class EAGLView;
@class MainGameView;
//@class MainGameViewController;

@interface CS480_HW3AppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate, AVAudioPlayerDelegate> {
    UIWindow *window;	
	UIView *startupView;
	IBOutlet UIButton *startButton;
	IBOutlet UILabel *lblMessage;
	
	AVAudioPlayer *player;
	
	
    //EAGLView *glView;
	MainGameView *glView;
	//MainGameViewController *viewController;
	UIAccelerationValue accel[3];
	
}
@property (nonatomic, retain) AVAudioPlayer *player;

-(IBAction) startGame;

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet EAGLView *glView;
@property (nonatomic, retain) IBOutlet MainGameView *glView;;
@property(nonatomic, retain) IBOutlet UIView *startupView;
@property(nonatomic, retain) IBOutlet UIButton *startButton;
@property(nonatomic, retain) IBOutlet UILabel *lblMessage;
- (IBAction) play;

@end

