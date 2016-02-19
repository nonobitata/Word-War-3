//
//  ViewController.m
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "Dictionary.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)tapSoundControl:(id)sender{
    NSString *soundONorOFF = [[NSUserDefaults standardUserDefaults] stringForKey:@"OnOrOff"];
    if ([soundONorOFF isEqualToString:@"On"]){
        imageSound.image= [UIImage imageNamed:@"SoundOFF.png"];
        [backgroundMusicPlayer setVolume:0.0];
        [tapButtonSound setVolume:0.0];
        [moveViewControllerSound setVolume:0.0];
        [loseSound setVolume:0.0];
        [correctAnswerSound setVolume:0.0];
        [[NSUserDefaults standardUserDefaults] setValue:@"Off" forKey:@"OnOrOff"];
        NSLog(@"min volume");

        
    }
    else{
        [[NSUserDefaults standardUserDefaults] setValue:@"On" forKey:@"OnOrOff"];
        imageSound.image= [UIImage imageNamed:@"SoundON.png"];
        [backgroundMusicPlayer setVolume:1.0];
        [tapButtonSound setVolume:1.0];
        [moveViewControllerSound setVolume:1.0];
        [loseSound setVolume:1.0];
        [correctAnswerSound setVolume:1.0];
        NSLog(@"max volume");
    }
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    numberOfTurn=0;
    numberOfLifePoint=3;
    totalScore=0;
    numberOfKeyword=0;
    LosingPointsNoAnswer=10;
    level = 1;
    [self setUpButtonSound];
    [self setUp_3_WordsArray];
    [backgroundMusicPlayer play];

    NSString *soundONorOFF = [[NSUserDefaults standardUserDefaults] stringForKey:@"OnOrOff"];

    if ([soundONorOFF isEqualToString:@"Off"]){
        imageSound.image = [UIImage imageNamed:@"SoundOFF.png"];
        [backgroundMusicPlayer setVolume:0.0];
        [tapButtonSound setVolume:0.0];
        [moveViewControllerSound setVolume:0.0];
        [loseSound setVolume:0.0];
        [correctAnswerSound setVolume:0.0];
    }

    NSLog(@"sound at beginning: %@", soundONorOFF);

    if ([soundONorOFF isEqualToString:@"On"] == NO &&[soundONorOFF isEqualToString:@"Off"] == NO ){
        soundONorOFF= [NSString stringWithFormat:@"On"];
        [[NSUserDefaults standardUserDefaults] setValue:@"On" forKey:@"OnOrOff"];
    };
    NSLog(@"sound after modify: %@", soundONorOFF);
    

   // [interstitial_ presentFromRootViewController:self];
    }


 
- (void) setUpButtonSound{
    NSURL *urll = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"MonkeySpinning"
                                         ofType:@"mp3"]];
    backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urll error:nil];
    backgroundMusicPlayer.numberOfLoops = -1;
    [backgroundMusicPlayer prepareToPlay];

    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"Tap"
                                         ofType:@"mp3"]];
    tapButtonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    tapButtonSound.numberOfLoops = 0;
    [tapButtonSound prepareToPlay];
    NSURL *url1 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"Tap2"
                                         ofType:@"mp3"]];
    moveViewControllerSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    moveViewControllerSound.numberOfLoops = 0;
    [moveViewControllerSound prepareToPlay];
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"Losing"
                                          ofType:@"mp3"]];
    loseSound= [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    loseSound.numberOfLoops = 0;
    [loseSound prepareToPlay];
    NSURL *url3 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"LargeCrowdApplause"
                                          ofType:@"mp3"]];

    correctAnswerSound= [[AVAudioPlayer alloc] initWithContentsOfURL:url3 error:nil];
    correctAnswerSound.numberOfLoops = 0;
    [correctAnswerSound prepareToPlay];

    
}
- (void)setUp_3_WordsArray{
    dict= [[Dictionary alloc] initWithPath:@"109582"];
    NSString *tempWord;
    int num_easy=0;
    int num_medium=0;
    int num_hard=0;
    easyWords = [[NSMutableArray alloc] init];
    mediumWords = [[NSMutableArray alloc] init];
    hardWords = [[NSMutableArray alloc] init];
    for (int i=0; i < 109582; i++){
        tempWord=[dict getAWordAtIndex:i];
        if ([tempWord length] <=7){
            [easyWords addObject:tempWord];
            num_easy++;
        }
        else {
            if([tempWord length] >7 && [tempWord length] <=11){
                [mediumWords addObject:tempWord];
                num_medium++;
                //      NSLog(@"%@",tempWord);
                
            }
            else{
                if ([tempWord length] >11){
                    [hardWords addObject:tempWord];
                    num_hard++;
                };
            }
        }
    }
   

    NSLog(@"Easy: %d",num_easy);
    NSLog(@"Medium: %d",num_medium);
    NSLog(@"Hard: %d",num_hard);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
