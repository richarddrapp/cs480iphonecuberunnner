//
//  MainGameViewController.h
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/25/10.
//  Copyright 2010 Greg Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainGameView;

@interface MainGameViewController : UIViewController {
	MainGameView *glView;
}

@property (nonatomic, retain) IBOutlet MainGameView *glView;

@end
