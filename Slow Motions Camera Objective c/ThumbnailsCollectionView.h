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

@interface ThumbnailsCollectionView : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *thumbnailArray;
@property (nonatomic, strong)   NSMutableArray *URLArray;
@end
