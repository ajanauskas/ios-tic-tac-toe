//
//  GameViewController.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

@synthesize match = _match;

+ (GameViewController *)instantiate
{
    NSString *storyboardName = @"Game_iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    GameViewController *gameViewController = [storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
                                              
    return gameViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.match = [[Match alloc] initWithPlayerStarts:YES];
    
    [self redrawBoard];
}

#pragma helpers

- (void)redrawBoard
{
    UIImage *imageOfCross = [UIImage imageNamed:@"cross256.png"];
    UIImage *imageOfCircle = [UIImage imageNamed:@"circle256.png"];
    
    for (int i = 1; i <= kBoardSize; i++) {
        NSInteger tag = (NSInteger)i;
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        
        if ([self.match.board isCellFilledByCircleAt:tag - 1]) {
            [button setImage:imageOfCircle forState:UIControlStateNormal];
        } else if ([self.match.board isCellFilledByCrossAt:tag - 1]) {
            [button setImage:imageOfCross forState:UIControlStateNormal];
        } else {
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
}

#pragma actions

- (IBAction)didSurrender:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didClickOnBoardCell:(id)sender
{
    NSInteger tag = [sender tag];
    
    [self.match.board markCellWithCircleAt:tag - 1];
    
    [self redrawBoard];
}

@end