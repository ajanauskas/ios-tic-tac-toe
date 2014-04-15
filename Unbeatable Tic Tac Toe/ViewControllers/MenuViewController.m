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

- (IBAction)didClickStartButton:(id)sender
{
    BOOL playerStarts = [sender tag] == 2;
    
    GameViewController *gameViewController = [GameViewController instantiateWithPlayerStarts:playerStarts];
    
    [self presentViewController:gameViewController animated:YES completion:nil];
}

@end
 