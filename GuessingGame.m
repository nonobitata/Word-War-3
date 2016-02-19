//
//  GuessingGame.m
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import "GuessingGame.h"
#import "ViewController.h"
#import "RandomGame.h"
#import <FacebookSDK/FacebookSDK.h>
@interface GuessingGame ()

@end

@implementation GuessingGame
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)prepareAGuessWord{
    TypingPlace.hidden=NO;
    Submit.Hidden=NO;
    long length = 0;
    if (level<=5){
        randomWordIndex = arc4random() % 39417;
        OriginalWordFullText=[NSString stringWithFormat:@"%@",[easyWords objectAtIndex:randomWordIndex]];
        OriginalWordGuessText= OriginalWordFullText;
        length = [OriginalWordFullText length];
        NSLog(@"Length: %li",length);
    };
    if (level>5 && level<=15){
        randomWordIndex = arc4random() % 56409;
        OriginalWordFullText=[NSString stringWithFormat:@"%@",[mediumWords objectAtIndex:randomWordIndex]];
        OriginalWordGuessText= OriginalWordFullText;
        length = [OriginalWordFullText length];
        NSLog(@"Length: %li",length);
    };
    if (level>15){
        randomWordIndex = arc4random() % 13755;
        OriginalWordFullText= [NSString stringWithFormat:@"%@",[hardWords objectAtIndex:randomWordIndex]];
        OriginalWordGuessText= OriginalWordFullText;
        length = [OriginalWordFullText length];
        NSLog(@"Length: %li",length);
    }
    randomPosition = arc4random() %(length-1);
    
    /*
     randomWordIndex = arc4random() %58109;
     OriginalWordFullText= [dict getAWordAtIndex:randomWordIndex];
     OriginalWordGuessText= OriginalWordFullText;
     length = [OriginalWordFullText length];
     NSLog(@"Length: %li",length);*/
    //    int numberSpace = ((float) length / 2) +1;
    //  NSLog(@"numberSpace: %d", numberSpace);
    
    for (int i=0; i<length; i++){
        if (i != randomPosition ){
            // NSLog(@"%d", randomPosition);
            NSRange range = NSMakeRange(i,1);
            OriginalWordGuessText = [OriginalWordGuessText stringByReplacingCharactersInRange:range withString:@"_"];
        }
        
    }
    IncompleteWord.text=OriginalWordGuessText;
   
    NSLog(@"Keyword: %@",OriginalWordFullText);
    
}
-(void) reward{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"])
    {
        [confirmQuitSentence setFont:[UIFont fontWithName:@"LAIKA" size:25]];
    }
    else{
        [confirmQuitSentence setFont:[UIFont fontWithName:@"LAIKA" size:42]];
    };
    numberOfLifePoint=numberOfLifePoint+1;
    numLife.text= [NSString stringWithFormat:@"%d",numberOfLifePoint];
    numberOfKeyword = numberOfKeyword+1;
    TypingPlace.hidden=YES;
    [self.view endEditing:YES];
    Submit.Hidden=YES;
    CommentSentence.text=[NSString stringWithFormat:@"Wow! You are talented!"];
    CommentSentence.hidden=NO;
    instructionAfterAnswer.hidden=NO;
    instructionGuessWord.hidden=YES;
    instructionGetHelp.hidden=YES;

}
-(IBAction)submit:(id)sender{
    TypingWord= TypingPlace.text;
    NSLog(@"%@",TypingWord);
    
    
    NSString *checkingWord = [IncompleteWord.text lowercaseString];
    NSLog(@"check: %@",checkingWord);
    if ([checkingWord length] == [OriginalWordFullText length]){
        if ([checkingWord characterAtIndex:randomPosition] == [OriginalWordFullText characterAtIndex:randomPosition]){
            for (int i=0; i<109582 ; i++){
                if ([checkingWord isEqualToString:[dict getAWordAtIndex:i]]){
                    NumberOfKeywordAnswered = NumberOfKeywordAnswered +1;
                    [[NSUserDefaults standardUserDefaults] setInteger:NumberOfKeywordAnswered forKey:@"NumberOfKeywordAnswered"];
                    
                    NSLog(@"Correct: %@, original word: %@", TypingWord, OriginalWordFullText);
                    [self reward];
                    founded = YES;
                    
                    [correctAnswerSound play];
                    if (NumberOfKeywordAnswered%5 ==0){
                        [interstitial_ loadRequest:[GADRequest request]];
                        interstitial_.delegate = self;
                    }
                };
            }
            if (founded == NO){
                [loseSound play];
                CommentSentence.text=[NSString stringWithFormat:@"Good guessing but this word is not in our dictionary!"];
                [self showWrongCommentin2Seconds];
                instructionGetHelp.hidden=NO;

                
            }
        }
        else {
            [loseSound play];
            CommentSentence.text=[NSString stringWithFormat:@"Please double-check at the hint character position."];
            [self showWrongCommentin2Seconds];
            instructionGetHelp.hidden=NO;

        }
    }
    else{
        [loseSound play];
        CommentSentence.text=[NSString stringWithFormat:@"Take time and recount your word."];
        [self showWrongCommentin2Seconds];
        instructionGetHelp.hidden=NO;

    }
    
}
- (void) showWrongCommentin2Seconds{
    CommentSentence.hidden=NO;
    TypingPlace.hidden=YES;
    Submit.hidden=YES;
    
    showWrongChoice = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideCommentAgain) userInfo:nil repeats:NO];
}
- (void) hideCommentAgain{
    CommentSentence.hidden=YES;
    TypingPlace.hidden=NO;
    Submit.hidden=NO;
    
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [interstitial_ presentFromRootViewController:self];
}
- (IBAction)tapBack:(id)sender{
    [moveViewControllerSound play];

    if (founded==YES){
        confirmQuitSentence.text = [NSString stringWithFormat:@"Congratulation! You just got 1 extra life point ;)"];
        quitNoAnswer.hidden=YES;
        quitWithAnswer.hidden=NO;
        cancelQuit.hidden=YES;
    }
    else{
        confirmQuitSentence.text = [NSString stringWithFormat:@"Quit before answering question may cause you - %d points. Try your best or get help from friends ;)",LosingPointsNoAnswer];
        quitNoAnswer.hidden=NO;
        quitWithAnswer.hidden=YES;
        cancelQuit.hidden=NO;
    }
    confirmQuitView.hidden=NO;
    instructionGetHelp.hidden=YES;
    instructionAfterAnswer.hidden=YES;


}
- (IBAction)tapAcceptQuitWithNoAnswer:(id)sender{
    totalScore = totalScore-LosingPointsNoAnswer;
    LosingPointsNoAnswer= LosingPointsNoAnswer+10;
    NSLog(@"Point lose: %d",LosingPointsNoAnswer);
    
}
- (IBAction)tapCancelQuit:(id)sender{
    [tapButtonSound play];
    confirmQuitView.hidden=YES;
    instructionGetHelp.hidden=NO;
    
}
- (IBAction)tapShare:(id)sender{
    [tapButtonSound play];
    if (facebookShare.hidden == YES){
        facebookShare.hidden=NO;
        otherShare.hidden=NO;
    }
    else {
        facebookShare.hidden=YES;
        otherShare.hidden=YES;
    }
}

-(IBAction)otherSharingChoices: (id) sender{
    [tapButtonSound play];

    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSString *shareText = @"[Word War 3 - https://www.facebook.com/TheOutliersInc] What is your guessing word?!";
    NSArray *shareItems = @[shareText,screenshotImage];
    UIActivityViewController *sharingOther = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:sharingOther animated:YES completion:nil];
}

-(IBAction) facebookSharing: (id) sender{
    [tapButtonSound play];

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
- (void)viewDidLoad
{
    [moveViewControllerSound play];

    facebookShare.hidden=YES;
    otherShare.hidden=YES;
    CommentSentence.hidden=YES;
    founded=NO;
    confirmQuitView.hidden=YES;
    [self.view endEditing:NO];

    [self setFont];
    numLife.text= [NSString stringWithFormat:@"%d",numberOfLifePoint];
    numTurn.text= [NSString stringWithFormat:@"Turn: %d",numberOfTurn];
    numLevel.text=[NSString stringWithFormat:@"Level %d",level];
    [self prepareAGuessWord];
    [super viewDidLoad];
    NumberOfKeywordAnswered =[[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfKeywordAnswered"];
    [TypingPlace addTarget:self
                  action:@selector(editingChanged:)
        forControlEvents:UIControlEventEditingChanged];
    confirmQuitView.layer.cornerRadius = 15;
    confirmQuitView.layer.masksToBounds = YES;
    instructionAfterAnswer.hidden=YES;
    instructionGuessWord.hidden=NO;
    instructionGetHelp.hidden=YES;
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = @"ca-app-pub-7471986215840359/3244690625";
    // Do any additional setup after loading the view.
    

}
-(IBAction)tapAcceptQuit:(id)sender{
    
}


- (void) editingChanged: (id) sender{
    NSString *temp_update = TypingPlace.text;
   // NSLog(@"temp String :%@",temp_update);
    int length = [OriginalWordGuessText length];
    for (int i = 0; i < length; i++){
       // NSLog(@"temp_update length: %d ; i: %d",[temp_update length],i);
        if (i!= randomPosition && i <[temp_update length]){
            NSString *temp = [NSString stringWithFormat:@"%c", [temp_update characterAtIndex:i]];
            NSRange range = NSMakeRange(i,1);
            OriginalWordGuessText = [OriginalWordGuessText stringByReplacingCharactersInRange:range withString:temp];
            IncompleteWord.text =[ NSString stringWithFormat:@"%@", OriginalWordGuessText];
            
        }
        if (i!= randomPosition && i>= [temp_update length]){
            NSRange range = NSMakeRange(i,1);
            OriginalWordGuessText = [OriginalWordGuessText stringByReplacingCharactersInRange:range withString:@"_"];
            IncompleteWord.text =[ NSString stringWithFormat:@"%@", OriginalWordGuessText];
            

            
        }
    }
}
- (void) setFont{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"])
    {
        [CommentSentence setFont:[UIFont fontWithName:@"LAIKA" size:25]];
        [numTurn setFont:[UIFont fontWithName:@"LAIKA" size:22]];
        [numLevel setFont:[UIFont fontWithName:@"LAIKA" size:28]];
        [numLife setFont:[UIFont fontWithName:@"LAIKA"  size:30]];
        [confirmQuitSentence setFont:[UIFont fontWithName:@"LAIKA" size:20]];
        if (level <=20){
            [IncompleteWord setFont:[UIFont fontWithName:@"LAIKA" size:45]];
        }
        else [IncompleteWord setFont:[UIFont fontWithName:@"LAIKA" size:35]];
    }
    else{
        [CommentSentence setFont:[UIFont fontWithName:@"LAIKA" size:50]];
        [numTurn setFont:[UIFont fontWithName:@"LAIKA" size:45]];
        [numLevel setFont:[UIFont fontWithName:@"LAIKA" size:55]];
        [numLife setFont:[UIFont fontWithName:@"LAIKA"  size:50]];
        [confirmQuitSentence setFont:[UIFont fontWithName:@"LAIKA" size:30]];
        if (level <=20){
            [IncompleteWord setFont:[UIFont fontWithName:@"LAIKA" size:90]];
        }
        else [IncompleteWord setFont:[UIFont fontWithName:@"LAIKA" size:75]];

        
    }
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    facebookShare.hidden=YES;
    otherShare.hidden=YES;
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
