//
//  MenuViewController.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 09/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize startGameButton = _startGameButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma events

- (IBAction)handleStartGameButtonClick:(id)sender
{
    GameViewController *gameViewController = [GameViewController instantiate];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

@end
 