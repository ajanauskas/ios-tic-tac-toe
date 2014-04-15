//
//  TicTacToeAI.h
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

static const NSInteger kMoveImpossible = -1;

@interface TicTacToeAI : NSObject

@property (strong, nonatomic) Board *board;

- (id)initWithBoard:(Board*)board;
- (NSInteger)getMove;

@end
