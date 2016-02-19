//
//  Statistics.h
//  Word War III
//
//  Created by Outliers on 8/18/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
@interface Statistics : UIViewController{
    IBOutlet UILabel *highScore;
    IBOutlet UILabel *highNumTurn;
    IBOutlet UILabel *numKeyword;
    IBOutlet UILabel *numGamePlayed;
    IBOutlet UIButton *ShareChoice;
    IBOutlet UIButton *FacebookShare;
    IBOutlet UIButton *OtherShare;
   GADBannerView *bannerView_;

}
- (void) setFont;
@end
