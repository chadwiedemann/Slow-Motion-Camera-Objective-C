//
//  PlayerViewController.h
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/14/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface PlayerViewController : UIViewController

@property (nonatomic, strong) NSString *videoURLString;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSURL *videoURL;


@property (weak, nonatomic) IBOutlet UIView *playerView;
- (IBAction)playButton:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)slowMotionSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *onOffPositionSwitch;
@property (weak, nonatomic) IBOutlet UILabel *regularSloLabel;
@end
