//
//  Match.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "Match.h"

@interface Match()

@property (strong, nonatomic) TicTacToeAI *AI;

- (void)makeAIMovement;

@end

@implementation Match

@synthesize board = _board;
@synthesize playerStarts = _playerStarts;
@synthesize AI=_ai;

#pragma private implementation

- (void)makeAIMovement
{
    NSInteger aiMovesAt = [self.AI getMove];
    
    if (aiMovesAt != kMoveImpossible) {
        [self.board markAICellAt:aiMovesAt];
    }
}

#pragma public impementation

- (id)init
{
    self = [super init];
    
    if (self) {
        self.playerStarts = NO;
        self.board = [[Board alloc] init];
        self.AI = [[TicTacToeAI alloc] initWithBoard:self.board];
    }
    
    return self;
}

- (id)initWithPlayerStarts:(BOOL)playerStarts
{
    self = [self init];
    
    if (self) {
        self.playerStarts = playerStarts;
        
        if (!self.playerStarts) {
            [self makeAIMovement];
        }
    }
    
    return self;
}

- (BOOL)makeMoveAtCell:(NSInteger)index
{
    if ([self.board canMarkCellAt:index]) {
        [self.board markPlayerCellAt:index];
        
        if (![self.board isWinner:kPlayer]) {
            [self makeAIMovement];
        }
        
        return YES;
    }
    
    return NO;
}

- (NSInteger)getMatchStatus
{
    if ([self.board emptyCells] > 0 && ![self.board isWinner:kPlayer] && ![self.board isWinner:kAI]) {
        return kInProgress;
    }
    else {
        return kEnded;
    }
}

- (void)reset
{
    [self.board reset];
    
    if (!self.playerStarts) {
        [self makeAIMovement];
    }
}

@end
