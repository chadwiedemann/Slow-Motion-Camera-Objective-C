//
//  ViewController.h
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/12/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) NSMutableArray *URLArray;

- (IBAction)record:(id)sender;

@end

