//
//  MenuViewController.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 09/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"

NSString * const MainIPhoneStoryBoard = @"Main_iPhone";

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma events

- (IBAction)didClickStartButton:(id)sender
{
    BOOL playerStarts = [sender tag] == 2;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainIPhoneStoryBoard bundle:nil];
    GameViewController *gameViewController = [storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    gameViewController.playerStarts = playerStarts;
    
    [self presentViewController:gameViewController animated:YES completion:nil];
}

@end
 