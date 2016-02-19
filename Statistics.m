//
//  Statistics.m
//  Word War III
//
//  Created by Outliers on 8/18/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import "Statistics.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"
@interface Statistics ()

@end

@implementation Statistics
-(IBAction)Show2ChoiceSharing:(id) sender{
    [tapButtonSound play];
    if (FacebookShare.hidden == YES){
        FacebookShare.hidden=NO;
        OtherShare.hidden=NO;
    }
    else{
        FacebookShare.hidden=YES;
        OtherShare.hidden=YES;
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    FacebookShare.hidden=YES;
    OtherShare.hidden=YES;
}
-(IBAction)otherSharingChoices: (id) sender{
    [tapButtonSound play];

    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(screenshotImage, nil, nil, nil);
    NSString *shareText = @"[https://www.facebook.com/TheOutliersInc]";
    NSArray *shareItems = @[shareText,screenshotImage];
    UIActivityViewController *sharingOther = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:sharingOther animated:YES completion:nil];
}
-(IBAction) facebookSharing: (id) sender{
    // UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [tapButtonSound play];

    FBPhotoParams *params = [[FBPhotoParams alloc] init];
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(screenshotImage, nil, nil, nil);
    // Note that params.photos can be an array of images.  In this example
    // we only use a single image, wrapped in an array.
    
    params.photos = @[screenshotImage];
    if ([FBDialogs canPresentShareDialogWithPhotos]) {
        [FBDialogs presentShareDialogWithPhotoParams:params
                                         clientState:nil
                                             handler:^(FBAppCall *call,
                                                       NSDictionary *results,
                                                       NSError *error) {
                                                 if (error) {
                                                     NSLog(@"Error: %@",
                                                           error.description);
                                                 } else {
                                                     NSLog(@"Success!");
                                                 }
                                             }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook app is not found."
                                                        message:@"No Facebook app installed, choose the Other type of sharing next to this Facebook icon. (Message, email, built-in Facebook of iOS, Twitter,...)"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
       // [alert release];
    }
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [moveViewControllerSound play];
    NSInteger temp_highScore= [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    highScore.text = [NSString stringWithFormat:@"%li",(long)temp_highScore];
    
    NSInteger temp_numTurn= [[NSUserDefaults standardUserDefaults] integerForKey:@"HighNumberOfTurn"];
    highNumTurn.text = [NSString stringWithFormat:@"%li",(long)temp_numTurn];
    
    NSInteger temp_numKeyword= [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfKeywordAnswered"];
    numKeyword.text = [NSString stringWithFormat:@"%li",(long)temp_numKeyword];
    
    NSInteger temp_numGame= [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfGamePlayed"];
    numGamePlayed.text = [NSString stringWithFormat:@"%li",(long)temp_numGame];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FacebookShare.hidden=YES;
    OtherShare.hidden=YES;
    [self setFont];
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"])
    {
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.center= CGPointMake(160, 25 );

    // Specify the ad unit ID.
    bannerView_.adUnitID = @"ca-app-pub-7471986215840359/7996607820";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    }

}

- (void) setFont{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"])
    {
    [highScore setFont:[UIFont fontWithName:@"LAIKA" size:50]];
    [highNumTurn setFont:[UIFont fontWithName:@"LAIKA" size:35]];
    [numKeyword  setFont:[UIFont fontWithName:@"LAIKA" size:50]];
    [numGamePlayed setFont:[UIFont fontWithName:@"LAIKA" size:35]];
    }
    else{
        [highScore setFont:[UIFont fontWithName:@"LAIKA" size:80]];
        [highNumTurn setFont:[UIFont fontWithName:@"LAIKA" size:40]];
        [numKeyword  setFont:[UIFont fontWithName:@"LAIKA" size:80]];
        [numGamePlayed setFont:[UIFont fontWithName:@"LAIKA" size:40]];
  
    };
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
