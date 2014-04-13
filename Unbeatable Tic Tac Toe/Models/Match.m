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

- (void)makeAIMovement
{
    if ([self.board emptyCells] > 0) {
        for(NSInteger i = 0; i < kBoardSize; i++) {
            if ([self.board canMarkCellAt:i]) {
                if (self.playerStarts) {
                    [self.board markCellWithCircleAt:i];
                }
                else {
                    [self.board markCellWithCrossAt:i];
                }
                
                return;
            }
        }
    }
}

- (Match*)init
{
    self = [super init];
    
    if (self) {
        self.playerStarts = NO;
        self.board = [[Board alloc] init];
    }
    
    return self;
}

- (Match*)initWithPlayerStarts:(BOOL)playerStarts
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
        if (self.playerStarts) {
            [self.board markCellWithCrossAt:index];
        }
        else {
            [self.board markCellWithCircleAt:index];
        }
        
        [self makeAIMovement];
        
        return YES;
    }
    
    return NO;
}

- (NSInteger)getMatchStatus
{
    if ([self.board emptyCells] > 0) {
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
