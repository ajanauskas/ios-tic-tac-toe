//
//  MenuViewController.h
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 09/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startGameButton;

- (IBAction)handleStartGameButtonClick:(id)sender;

@end