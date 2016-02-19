//
//  Instruction.m
//  Word War III
//
//  Created by Outliers on 8/20/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import "Instruction.h"
#import "ViewController.h"
@interface Instruction ()

@end

@implementation Instruction

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)segmentChange:(id)sender {
    [tapButtonSound play];

    if (InstructionParts.selectedSegmentIndex==0){
        imageInstruction.image =[UIImage imageNamed:@"Randomize_Instruction.png"];
    }
    else {
        imageInstruction.image =[UIImage imageNamed:@"WordGuessInstruction.png"];
    }
}


- (void)viewDidLoad
{
    [moveViewControllerSound play];
    [super viewDidLoad];
        
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
