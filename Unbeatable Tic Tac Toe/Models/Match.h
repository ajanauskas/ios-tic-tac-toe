//
//  Match.h
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board, TicTacToeAI;

static const NSInteger kInProgress = 0;
static const NSInteger kEnded = 1;

@interface Match : NSObject

@property (strong, nonatomic) Board *board;
@property BOOL playerStarts;

- (id)initWithPlayerStarts:(BOOL)playerStarts;
- (BOOL)makeMoveAtCell:(NSInteger)index;
- (NSInteger)getMatchStatus;
- (void)reset;

@end
