//
//  GameViewController.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "GameViewController.h"
#import "Match.h"
#import "Board.h"

NSInteger const kDefaultBoardSize = 9;

@interface GameViewController ()

- (void)redrawBoard;
- (void)drawCellAtTag:(NSInteger)tag;

@end

@implementation GameViewController

@synthesize match = _match;
@synthesize playerStarts = _playerStarts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.match = [[Match alloc] initWithPlayerStarts:self.playerStarts];
    
    [self redrawBoard];
    
    UISwipeGestureRecognizer *mSwipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
    
    [mSwipeDownRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [[self view] addGestureRecognizer:mSwipeDownRecognizer];
}

#pragma mark private implementation

- (void)redrawBoard
{
    for (NSInteger i = 1; i <= kDefaultBoardSize; i++) {
        [self drawCellAtTag:i];
    }
}

- (void)drawCellAtTag:(NSInteger)tag
{
    UIImage *imageOfCross = [UIImage imageNamed:@"cross256.png"];
    UIImage *imageOfCircle = [UIImage imageNamed:@"circle256.png"];
    UIButton *button = (UIButton *)[self.view viewWithTag:tag];
    
    switch ([self.match.board getCellAt:tag - 1]) {
        case kPlayer:
            if (self.match.playerStarts) {
                [button setImage:imageOfCross forState:UIControlStateNormal];
            }
            else {
                [button setImage:imageOfCircle forState:UIControlStateNormal];
            }
            break;
        case kAI:
            if (self.match.playerStarts) {
                [button setImage:imageOfCircle forState:UIControlStateNormal];
            }
            else {
                [button setImage:imageOfCross forState:UIControlStateNormal];
            }
            break;
        default:
            [button setImage:nil forState:UIControlStateNormal];
            break;
    }
}

#pragma mark actions

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
        NSString *alertTitle;
        NSString *changeWhoStartsButton;
        NSString *alertCancelButton = NSLocalizedString(@"game_alert_cancel_button", nil);
        NSString *alertContinueButton = NSLocalizedString(@"game_alert_continue_button", nil);
        NSString *alertMessage = NSLocalizedString(@"game_alert_message", nil);
        
        if (self.playerStarts) {
            changeWhoStartsButton = NSLocalizedString(@"game_alert_change_roles_to_iphone", nil);
        }
        else {
            changeWhoStartsButton = NSLocalizedString(@"game_alert_change_roles_to_player", nil);
        }
        
        if ([self.match.board isWinner:kAI]) {
            alertTitle = NSLocalizedString(@"game_alert_title_ai_won", nil);
        }
        else if ([self.match.board isWinner:kPlayer]) {
            alertTitle = NSLocalizedString(@"game_alert_title_player_won", nil);
        }
        else {
            alertTitle = NSLocalizedString(@"game_alert_title_draw", nil);
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMessage
                                                           delegate:self
                                                  cancelButtonTitle:alertCancelButton
                                                  otherButtonTitles:alertContinueButton, changeWhoStartsButton, nil];
        
        [alertView show];
    }
}

#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // clicked cancel
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (buttonIndex == 1) {
        // clicked new match
        [self.match reset];
        [self redrawBoard];
    } else {
        // wants to change sides
        self.playerStarts = !self.playerStarts;
        self.match.playerStarts = self.playerStarts;
        [self.match reset];
        [self redrawBoard];
    }
}

# pragma mark UISwipeGestureRecognizer

- (void)didSwipeDown:(UIGestureRecognizer *)gestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end