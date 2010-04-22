//
//  CS480_HW3AppDelegate.h
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/22/10.
//  Copyright Greg Lieberman 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface CS480_HW3AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

