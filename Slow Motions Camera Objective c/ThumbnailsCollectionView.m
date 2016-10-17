//
//  ThumbnailsCollectionView.m
//  Slow Motions Camera Objective c
//
//  Created by Chad Wiedemann on 10/12/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//  file:///private/var/mobile/Containers/Data/Application/8C2E297D-3061-496E-BF9D-4A82C3E29B48/tmp/49800116185__4ADB7A84-5DBC-46E5-8542-DE917946C468.MOV

#import "ThumbnailsCollectionView.h"

@interface ThumbnailsCollectionView ()

@end

@implementation ThumbnailsCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thumbnailArray = [[NSMutableArray alloc]init];
    self.URLArray = [[NSMutableArray alloc]init];
    self.URLArray1 = [[NSMutableArray alloc]init];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self createArrayOfImages];
    [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.thumbnailArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self.thumbnailArray objectAtIndex:indexPath.row]];
    cell.backgroundView = imageView;

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.playerVC = (PlayerViewController*)[sb instantiateViewControllerWithIdentifier:@"playerVC"];
    self.playerVC.videoURLString = [self.URLArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.playerVC animated:YES];
    
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(void)createArrayOfImages
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.URLArray = [[defaults objectForKey:@"URLs"] mutableCopy];
    [self.thumbnailArray removeAllObjects];
  for(NSString *s in self.URLArray)
  {
      UIImage *tempImage = [self createThumbnail:s];
      [self.thumbnailArray addObject:tempImage];
  }
}

- (UIImage*)createThumbnail: (NSString*) URLString{
    
    NSURL *testURL = [NSURL URLWithString:URLString];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:testURL options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    
    UIImage *image = [[UIImage alloc]initWithCGImage:imgRef];
    return image;
}

//methods added from other View Controller


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
    generate.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    
//    UIImage *image = [[UIImage alloc]initWithCGImage:imgRef];
//    self.thumbnailImageView.image = image;
    
    
    
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
    [self.collectionView reloadData];
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
