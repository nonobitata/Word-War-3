//
//  GuessingGame.h
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "GADInterstitial.h"

int randomWordIndex;
NSString* OriginalWordFullText;
NSString* OriginalWordGuessText;
NSString* TypingWord;
Boolean founded;
int randomPosition;
int check;
@interface GuessingGame : UIViewController{
    IBOutlet UIButton *shareChoices;
    IBOutlet UIButton *facebookShare;
    IBOutlet UIButton *otherShare;
    
    IBOutlet UILabel *numTurn;
    IBOutlet UILabel *numLife;
    IBOutlet UILabel *numLevel;
    
     IBOutlet UILabel *IncompleteWord;
    IBOutlet UITextField *TypingPlace;
    IBOutlet UIButton *Submit;
    IBOutlet UILabel *CommentSentence;
    
    
    IBOutlet UILabel *confirmQuitSentence;
    IBOutlet UIView *confirmQuitView;
    IBOutlet UIButton *quitNoAnswer;
    IBOutlet UIButton *quitWithAnswer;
    IBOutlet UIButton *cancelQuit;
    
    IBOutlet UIImageView *instructionGuessWord;
    IBOutlet UIImageView *instructionGetHelp;
    IBOutlet UIImageView *instructionAfterAnswer;
    NSTimer *showWrongChoice;
    GADInterstitial *interstitial_;

}
-(void) prepareAGuessWord;
-(IBAction)tapBack:(id)sender;
-(IBAction)tapAcceptQuit:(id)sender;
-(IBAction)tapCancelQuit:(id)sender;
@end

