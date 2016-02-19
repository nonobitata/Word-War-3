//  RandomGame.m
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 Outliers. All rights reserved.

#import "RandomGame.h"
#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface RandomGame ()

@end

@implementation RandomGame

- (void) setUpBasicPoints{
    totalScore=0;
    Score.text = [NSString stringWithFormat:@"%d", totalScore];
    
    numberOfLifePoint=3;
    LifePoint.text= [NSString stringWithFormat:@"%d", numberOfLifePoint];
    
    numberOfTurn=0;
    Num_Turn.text= [NSString stringWithFormat:@"Turn: %d", numberOfTurn];
    getLifeImage.hidden=YES;
    getExtraLifePoint.hidden=YES;
    
    level=1;
    levelLabel.text = [NSString stringWithFormat:@"Level %d",level];

}
- (void) startGame{
    LosingView.hidden=YES;
    getExtraLifePoint.hidden=YES;
    imageButtons.hidden=NO;
    Menu.hidden=NO;

    //set up some important variables
    [self setUpBasicPoints];
    

    //start Game by set Value
    [self setDiePosition];
    
}
- (void) decreaseLifePoint{
    
    numberOfLifePoint = numberOfLifePoint-1;
    LifePoint.text= [NSString stringWithFormat:@"%d", numberOfLifePoint];
    if (numberOfLifePoint <= 0 ){
        [self gameOver];
    }
}
- (void) gameOver{
    
    
    closeButton.hidden=YES;
    Menu.hidden=YES;
    getExtraLifePoint.hidden=YES;
    getLifeImage.hidden=YES;
    getLifePointButton.hidden=YES;
    [getLifeImage stopAnimating];
    getLifeImage.hidden=YES;
    [self setUpMenu];

    [self turnOnOfMenu];
    
    
}
- (void) hideButtonsin1sec{
    for (UIButton *a in buttons){
        a.hidden=YES;
    }
    hideButtonTimer= [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(reOpenButtonsAfter1sec) userInfo:nil repeats:NO];
}
- (void)reOpenButtonsAfter1sec{
    for (UIButton *a in buttons){
        a.hidden=NO;
    }
}
- (IBAction)closeMenu:(id)sender {
    [moveViewControllerSound play];

    LosingView.hidden=YES;
    FacebookShare.hidden=YES;
    OtherShare.hidden=YES;
    imageButtons.hidden=NO;
    Score.hidden=NO;
    imageButtons.hidden=NO;

}


- (void) turnOnOfMenu{
    
    if (LosingView.hidden == YES){
        imageButtons.hidden=YES;
        Score.hidden=YES;
        FacebookShare.hidden=YES;
        OtherShare.hidden=YES;
        LosingView.hidden =NO;
        
        
    }
    else{
        Score.hidden=NO;
        LosingView.hidden = YES;
        imageButtons.hidden=NO;
    };
}
- (IBAction)tapMenu:(id)sender{
    [moveViewControllerSound play];
    closeButton.hidden=NO;
    [self setUpMenu];
    [self turnOnOfMenu];
}

-(IBAction)tapShare:(id)sender{
    [moveViewControllerSound play];

    if (FacebookShare.hidden==YES){
        FacebookShare.hidden=NO;
        OtherShare.hidden=NO;
    }
    else {
        FacebookShare.hidden=YES;
        OtherShare.hidden=YES;
    }
    
}
-(IBAction)tapBack:(id)sender{
    NumberOfGamePlayed = NumberOfGamePlayed+1;
    
    [[NSUserDefaults standardUserDefaults] setInteger:NumberOfGamePlayed forKey:@"NumberOfGamePlayed"];
    
}
- (IBAction)tapRetry:(id)sender {
    NumberOfGamePlayed = NumberOfGamePlayed+1;
    
    [[NSUserDefaults standardUserDefaults] setInteger:NumberOfGamePlayed forKey:@"NumberOfGamePlayed"];
    LosingPointsNoAnswer = 10;
    [self turnOnOfMenu];
    [self startGame];
}

- (void) addScore{
    //animation for moving buttons
    [self hideButtonsin1sec];
    
    
    int add = arc4random()%6+1;
    totalScore+=add;
    Score.text = [NSString stringWithFormat:@"%d",totalScore];
    AddedScore.text=[NSString stringWithFormat:@"%+d",add];
    [self showingAddedScore];
    NSLog(@"Total %d  add %d", totalScore, add);
    
    if(totalScore > HighScoreNumber){
        [[NSUserDefaults standardUserDefaults] setInteger:totalScore forKey:@"HighScore"];
    }
    if(numberOfTurn > HighNumberOfTurns){
        [[NSUserDefaults standardUserDefaults] setInteger:numberOfTurn forKey:@"HighNumberOfTurn"];
    }
    int preLevelUp= level;
    level = (totalScore / 100) +1;
    levelLabel.text= [NSString stringWithFormat:@"Level: %d",level];
    if (preLevelUp<level){
        [self showLevelUpImageIn2Secs ];
        [correctAnswerSound play];
    }
}
- (void) showLevelUpImageIn2Secs{
    LevelUpImage.hidden=NO;
    showLevelUp = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reHideLevelUp) userInfo:nil repeats:NO];
}
- (void) reHideLevelUp{
    LevelUpImage.hidden=YES;
}
- (void) showingAddedScore{
    AddedScore.hidden=NO;
    showAddedScore = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reHideAddedScore) userInfo:nil repeats:NO];
    
    
}
- (void) reHideAddedScore{
    AddedScore.hidden=YES;
}
- (void) ButtonAnimationStart{
    imageButtons.animationRepeatCount = 1;
    
    NSArray * imageButtonAnimationArray  = [[NSArray alloc] initWithObjects:
                                            [UIImage imageNamed:@"buttons1.png"],
                                            [UIImage imageNamed:@"buttons2.png"],
                                            [UIImage imageNamed:@"buttons3.png"],
                                            [UIImage imageNamed:@"buttons4.png"],
                                            [UIImage imageNamed:@"buttons5.png"],
                                            [UIImage imageNamed:@"buttons6.png"],
                                            [UIImage imageNamed:@"buttons7.png"],
                                            [UIImage imageNamed:@"buttons8.png"],
                                            [UIImage imageNamed:@"buttons7.png"],
                                            [UIImage imageNamed:@"buttons6.png"],
                                            [UIImage imageNamed:@"buttons5.png"],
                                            [UIImage imageNamed:@"buttons3.png"],
                                            nil];
    imageButtons.animationImages= imageButtonAnimationArray;
    imageButtons.animationDuration=0.4;
    [imageButtons startAnimating];
    
    
}
- (void) setGetLifeImage{
    NSArray * imageGetLifeAnimationArray  = [[NSArray alloc] initWithObjects:
                                            [UIImage imageNamed:@"GetLife1.png"],
                                            [UIImage imageNamed:@"GetLife2.png"],
                                            nil];
    getLifeImage.animationImages= imageGetLifeAnimationArray;
    getLifeImage.animationDuration=1;

}
- (void) checkValid:(int)tapIndex{

    //add number of turn
    numberOfTurn = numberOfTurn + 1;
    Num_Turn.text= [NSString stringWithFormat:@"Turn: %d", numberOfTurn];
    if (numberOfTurn %5 ==0){
        getExtraLifePoint.hidden=NO;
        [getLifeImage startAnimating];
        getLifeImage.hidden=NO;
    }
    //***********************************
    //make a decision when user tap a button
    if (randomDieIndex1 != tapIndex && tapIndex != randomDieIndex2 && randomDieIndex3 != tapIndex){
        [tapButtonSound play];
        [self addScore];
        
    }
    else {
        [loseSound play];
        [self decreaseLifePoint];
    }
    
    [self setDiePosition];
    [self ButtonAnimationStart];
    
    
}
- (void) setDiePosition{
    randomDieIndex1 = arc4random() %10;
    if (randomDieIndex1== 9)
        randomDieIndex2=0;
    else{
        randomDieIndex2=randomDieIndex1+1;
    };
    if (numberOfLifePoint <=4){
        NSLog(@"Die slowly here!");
        int random3DieOrNot = arc4random() %2;
        if (random3DieOrNot ==0){
        randomDieIndex3 = arc4random() %10;
        }
        else {
            randomDieIndex3 = 20;
        };
    }
    else{
        NSLog(@"Die faster here!");
        if (randomDieIndex2 ==9){
            randomDieIndex3=0;
        }
        else{
            randomDieIndex3=randomDieIndex2+1;
        }
    }
    NSLog(@" Die #1: %d, Die #2: %d , Die #3 %d", randomDieIndex1, randomDieIndex2, randomDieIndex3);
}
- (IBAction)getExtraLifePoint:(id)sender{
    getExtraLifePoint.hidden=YES;

}
- (IBAction)Choose1:(id)sender {
    [self checkValid:0];
}
- (IBAction)Choose2:(id)sender {
    [self checkValid:1];
    
    
}
- (IBAction)Choose3:(id)sender {
    [self checkValid:2];
    
}
- (IBAction)Choose4:(id)sender {
    [self checkValid:3];
    
}
- (IBAction)Choose5:(id)sender {
    [self checkValid:4];
    
}
- (IBAction)Choose6:(id)sender {
    [self checkValid:5];
    
}
- (IBAction)Choose7:(id)sender {
    [self checkValid:6];
    
}
- (IBAction)Choose8:(id)sender {
    [self checkValid:7];
    
}
- (IBAction)Choose9:(id)sender {
    [self checkValid:8];
    
}
- (IBAction)Choose10:(id)sender {
    [self checkValid:9];
}
-(IBAction)otherSharingChoices: (id) sender{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSString *shareText = @"[https://www.facebook.com/TheOutliersInc] Play Word War III and beat me?";
    NSArray *shareItems = @[shareText,screenshotImage];
    UIActivityViewController *sharingOther = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:sharingOther animated:YES completion:nil];
}

-(IBAction) facebookSharing: (id) sender{
    // UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    FBPhotoParams *params = [[FBPhotoParams alloc] init];
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
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
- (void) setArrayButton{
    buttons= [[NSMutableArray alloc] initWithObjects:choice1,choice2,choice3,choice4,choice5,choice6,choice7,choice8,choice9,choice10, nil];
    pointArray = [NSMutableArray array];
    for (int i =0; i<10; i++){
        [pointArray addObject:[NSNumber numberWithInt:i]];
    }
    
}
- (void) setUpMenu{
    scoreNumber.text =[NSString stringWithFormat:@"%d / %ld",totalScore,(long)HighScoreNumber];
    keywordNumber.text = [NSString stringWithFormat:@"%d (%ld)",numberOfKeyword,(long)NumberOfKeywordAnswered];
}
- (void)viewDidLoad
{
    [moveViewControllerSound play];
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    HighNumberOfTurns  = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighNumberOfTurn"];
    NumberOfGamePlayed =[[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfGamePlayed"];
    NumberOfKeywordAnswered= [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfKeywordAnswered"];
    Score.text= [NSString stringWithFormat:@"%d",totalScore];
    Num_Turn.text = [NSString stringWithFormat:@"Turn: %d", numberOfTurn];
    LifePoint.text = [NSString stringWithFormat:@"%d", numberOfLifePoint];
    getExtraLifePoint.hidden=YES;
    imageButtons.hidden=NO;
    AddedScore.hidden=YES;
    LosingView.hidden=YES;
    LevelUpImage.hidden=YES;
    getLifeImage.hidden=YES;
    getLifePointButton.hidden=YES;
    LevelUpImage.hidden=YES;

    [self setGetLifeImage];
    
    levelLabel.text= [NSString stringWithFormat:@"Level: %d",level];
    [self setFont];
    [self setArrayButton];
    

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void) setFont{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"])
    {
        [Num_Turn setFont:[UIFont fontWithName:@"LAIKA" size:22]];
        [levelLabel setFont:[UIFont fontWithName:@"LAIKA" size:28]];
        [LifePoint setFont:[UIFont fontWithName:@"LAIKA"  size:30]];
        [Score setFont:[UIFont fontWithName:@"LAIKA"  size:70]];
        [AddedScore setFont:[UIFont fontWithName:@"LAIKA"  size:40]];
        [YourScore setFont:[UIFont fontWithName:@"LAIKA" size:20]];
        [scoreNumber setFont:[UIFont fontWithName:@"LAIKA" size:40]];
        [KeywordAnswered setFont:[UIFont fontWithName:@"LAIKA" size:22]];
        [keywordNumber setFont:[UIFont fontWithName:@"LAIKA" size:40]];
    }
    else{
        [Num_Turn setFont:[UIFont fontWithName:@"LAIKA" size:45]];
        [levelLabel setFont:[UIFont fontWithName:@"LAIKA" size:55]];
        [LifePoint setFont:[UIFont fontWithName:@"LAIKA"  size:45]];
        [Score setFont:[UIFont fontWithName:@"LAIKA"  size:140]];
        [AddedScore setFont:[UIFont fontWithName:@"LAIKA"  size:60]];
        [YourScore setFont:[UIFont fontWithName:@"LAIKA" size:45]];
        [scoreNumber setFont:[UIFont fontWithName:@"LAIKA" size:100]];
        [KeywordAnswered setFont:[UIFont fontWithName:@"LAIKA" size:45]];
        [keywordNumber setFont:[UIFont fontWithName:@"LAIKA" size:100]];

    }

    
}
- (void) setUpFlagPositionImages{
    FlagPosition = [[NSMutableArray alloc] init];
    [FlagPosition addObject:@"FlagPosition1.png"];
    [FlagPosition addObject:@"FlagPosition2.png"];
    [FlagPosition addObject:@"FlagPosition3.png"];
    [FlagPosition addObject:@"FlagPosition4.png"];
    [FlagPosition addObject:@"FlagPosition5.png"];
    
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
