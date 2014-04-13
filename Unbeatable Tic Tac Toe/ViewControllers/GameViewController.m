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
    
    [self.match makeMoveAtCell:tag - 1];
    
    [self redrawBoard];
    
    if ([self.match getMatchStatus] == kEnded) {
        NSString *alertTitle = NSLocalizedString(@"game_alert_title", nil);
        NSString *alertMessage = NSLocalizedString(@"game_alert_message", nil);
        NSString *alertCancelButton = NSLocalizedString(@"game_alert_cancel_button", nil);
        NSString *alertContinueButton = NSLocalizedString(@"game_alert_continue_button", nil);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMessage
                                                           delegate:self
                                                  cancelButtonTitle:alertCancelButton
                                                  otherButtonTitles:alertContinueButton, nil];
        
        [alertView show];
    }
}

#pragma UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // clicked cancel
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.match reset];
        [self redrawBoard];
    }
}

@end