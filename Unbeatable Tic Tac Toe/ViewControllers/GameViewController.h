//
//  GameViewController.h
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"
#import "MenuViewController.h"

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton* surrenderButton;

@property (strong, nonatomic) Match *match;

+ (GameViewController *)instantiate;

- (void)redrawBoard;

- (IBAction)didSurrender:(id)sender;
- (IBAction)didClickOnBoardCell:(id)sender;

@end
