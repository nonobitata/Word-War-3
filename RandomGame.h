//
//  RandomGame.h
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomGame : UIViewController{
    int randomDieIndex1, randomDieIndex2, randomDieIndex3;
    IBOutlet UIButton *choice1;
    IBOutlet UIButton *choice2;
    IBOutlet UIButton *choice3;
    IBOutlet UIButton *choice4;
    IBOutlet UIButton *choice5;
    IBOutlet UIButton *choice6;
    IBOutlet UIButton *choice7;
    IBOutlet UIButton *choice8;
    IBOutlet UIButton *choice9;
    IBOutlet UIButton *choice10;
    
    IBOutlet UIButton *getExtraLifePoint;
    
    IBOutlet UIButton *getLifePointButton;
    IBOutlet UIButton *Retry;
    IBOutlet UIButton *Menu;
    IBOutlet UIButton *Share;
    IBOutlet UIButton *FacebookShare;
    IBOutlet UIButton *OtherShare;
    IBOutlet UIButton *Back;
    IBOutlet UIButton *closeButton;
    IBOutlet UILabel *Score;
    IBOutlet UIImageView *LevelUpImage;
    IBOutlet UIImageView *getLifeImage;
    IBOutlet UILabel *LifePoint;
    IBOutlet UILabel *Num_Turn;
    IBOutlet UILabel *AddedScore;
    IBOutlet UILabel *levelLabel;
    
    IBOutlet UIView *LosingView;
    
    IBOutlet UILabel *YourScore;
    IBOutlet UILabel *KeywordAnswered;
    IBOutlet UILabel *scoreNumber;
    IBOutlet UILabel *keywordNumber;
    
    NSMutableArray *buttons;
    NSMutableArray *pointArray;
    NSMutableArray *FlagPosition;
    NSTimer *hideButtonTimer;
    NSTimer *showAddedScore;
    NSTimer *showLevelUp;
    
    IBOutlet UIImageView *lifePointsImage;
    IBOutlet UIImageView *imageButtons;
}

- (void) setArrayButton;
- (void) ButtonAnimationStart;

- (void) showingAddedScore;
- (void) setUpMenu;

- (void) startGame;
- (void) gameOver;
- (void) checkValid:(int) tapIndex;
- (void) setDiePosition;
- (void) decreaseLifePoint;

@end
