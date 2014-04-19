//
//  AboutViewController.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 19/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

- (void)didSwipeDown:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *mSwipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
    
    [mSwipeDownRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [[self view] addGestureRecognizer:mSwipeDownRecognizer];
}

# pragma mark UISwipeGestureRecognizer

- (void)didSwipeDown:(UIGestureRecognizer *)gestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
