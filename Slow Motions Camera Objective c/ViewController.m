//
//  ViewController.m
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/12/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.URLArray1 = [[NSMutableArray alloc]init];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //saves video in documents directory
    self.videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSData *videoData = [NSData dataWithContentsOfURL:self.videoURL];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //create time stamp to add to directory name
    NSDate *date = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%lli", [@(floor([date timeIntervalSince1970])) longLongValue]];
    NSString *path = [NSString stringWithFormat:@"/vid%@.mp4",timeStamp];
    
    NSString *tempPath = [documentsDirectory stringByAppendingFormat:path];
    [videoData writeToFile:tempPath atomically:NO];
    
    NSString *str = [NSString stringWithFormat:@"file:///private%@",tempPath];
    NSURL *testURL = [NSURL URLWithString:str];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:testURL options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);

    UIImage *image = [[UIImage alloc]initWithCGImage:imgRef];
    self.thumbnailImageView.image = image;

    
    
    //saves the URLs for the images that were saved in the documents directory
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"URLs"]){
        self.URLArray1 = [[defaults objectForKey:@"URLs"] mutableCopy];
        [self.URLArray1 addObject:str];
        [defaults setObject: [self.URLArray1 copy]  forKey:@"URLs"];
    }else{
        [self.URLArray1 addObject:str];
        [defaults setObject:[self.URLArray1 copy] forKey:@"URLs"];
    }
    [defaults synchronize];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void) video: (NSString *) videoPath didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSLog(@"%@",error.localizedDescription);
    
}


- (IBAction)record:(id)sender {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    //need to handle delegates methods
    //
    ipc.allowsEditing = YES;
    ipc.videoQuality = UIImagePickerControllerQualityTypeMedium;
    ipc.videoMaximumDuration = 30.0f; // 30 seconds
    //temporary duation of 30 seconds for testing
    
    ipc.mediaTypes = [NSArray arrayWithObject:@"public.movie"];
    // ipc.mediaTypes = [NSArray arrayWithObjects:@"public.movie", @"public.image", nil];
    [self presentViewController:ipc animated:YES completion:nil];
    //this controller allows to record the videos
}




@end
