//
//  PlayerViewController.m
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/14/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.videoURL = [NSURL URLWithString:self.videoURLString];
    self.player = [AVPlayer playerWithURL:self.videoURL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:playerLayer];
    self.navigationController.title = @"Regular Speed";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playButton:(id)sender {
    
    if([self.onOffPositionSwitch isOn]){
        self.player.rate = .1;
        
    }else{
        self.player.rate = 1.0;
    }

    
}

- (IBAction)stopButton:(id)sender {
    [self.player pause];
}

- (IBAction)slowMotionSwitch:(id)sender {
    if([self.onOffPositionSwitch isOn]){
        self.regularSloLabel.text = @"Slow Motion";
    }else{
        self.regularSloLabel.text = @"Regular Speed";
    }
    
}
@end
