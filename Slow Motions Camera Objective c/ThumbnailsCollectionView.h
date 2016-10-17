//
//  ThumbnailsCollectionView.h
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/12/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayerViewController.h"

@interface ThumbnailsCollectionView : UICollectionViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *thumbnailArray;
@property (nonatomic, strong) NSMutableArray *URLArray;
@property (nonatomic, strong) PlayerViewController *playerVC;

//properties from other view controller
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSMutableArray *URLArray1;
- (IBAction)record:(id)sender;

@end
