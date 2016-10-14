//
//  SlowMotionViewController.h
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/13/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlowMotionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *thumbNailImageView;
- (IBAction)recordSlowMoVideoButton:(id)sender;

@end
