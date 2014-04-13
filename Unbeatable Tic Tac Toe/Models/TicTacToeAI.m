//
//  TicTacToeAI.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "TicTacToeAI.h"

@implementation TicTacToeAI

- (id)initWithBoard:(Board *)board
{
    self = [self init];
    
    if (self) {
        self.board = board;
    }
    
    return self;
}

@end
