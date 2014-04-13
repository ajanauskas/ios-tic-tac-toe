//
//  Match.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "Match.h"

@interface Match()

- (void)makeAIMovement;

@end

@implementation Match

@synthesize board = _board;
@synthesize playerStarts = _playerStarts;

#pragma private implementation

- (void)makeAIMovement
{
    if ([self.board emptyCells] > 0) {
        for(NSInteger i = 0; i < kBoardSize; i++) {
            if ([self.board canMarkCellAt:i]) {
                [self.board markAICellAt:i];
                
                return;
            }
        }
    }
}

#pragma public impementation

- (id)init
{
    self = [super init];
    
    if (self) {
        self.playerStarts = NO;
        self.board = [[Board alloc] init];
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
        
        [self makeAIMovement];
        
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
}

@end
