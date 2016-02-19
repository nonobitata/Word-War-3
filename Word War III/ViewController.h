//
//  ViewController.h
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dictionary.h"
#import <AVFoundation/AVFoundation.h>

int numberOfTurn;
int numberOfLifePoint;
int numberOfKeyword;
int LosingPointsNoAnswer;
int totalScore;
int level;
NSInteger HighScoreNumber;
NSInteger HighNumberOfTurns;
NSInteger NumberOfGamePlayed;
NSInteger NumberOfKeywordAnswered;
NSMutableArray *easyWords;
NSMutableArray *mediumWords;
NSMutableArray *hardWords;
Dictionary *dict;
AVAudioPlayer *backgroundMusicPlayer;
AVAudioPlayer *tapButtonSound;
AVAudioPlayer *moveViewControllerSound;
AVAudioPlayer *loseSound;
AVAudioPlayer *correctAnswerSound;



@interface ViewController : UIViewController{
    IBOutlet UIButton *soundControl;
    IBOutlet UIImageView *imageSound;

}
- (IBAction)tapSoundControl:(id)sender;
@end
