//
//  TicTacToeAI.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "TicTacToeAI.h"

@interface TicTacToeAI()

- (NSInteger)chooseRandomMoveFromList:(NSArray*)list;
- (NSInteger)getRandomNumberBetween:(int)from to:(int)to;
- (NSInteger)getBlockMove;
- (NSInteger)getWinMove;
- (NSInteger)createFork;
- (NSInteger)blockFork;
- (NSInteger)shouldTakeOppositeCorner;

@end

@implementation TicTacToeAI

@synthesize board = _board;

# pragma private implementation

- (NSInteger)chooseRandomMoveFromList:(NSArray*)list
{
    NSMutableArray *possibleMoves = [[NSMutableArray alloc] init];
    
    for (NSNumber *number in list) {
        NSInteger move = [number integerValue];
        if ([self.board canMarkCellAt:move]) {
            [possibleMoves addObject:@(move)];
        }
    }
    
    if ([possibleMoves count] != 0) {
        NSInteger randomMove = [self getRandomNumberBetween:0 to:[possibleMoves count] - 1];
        NSNumber *number = [possibleMoves objectAtIndex:randomMove];
        return [number integerValue];
    }
    
    return kMoveImpossible;
}

- (int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

- (NSInteger)getBlockMove
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        Board *boardCopy = [self.board copy];
        
        if ([boardCopy canMarkCellAt:i]) {
            [boardCopy markPlayerCellAt:i];
            
            if ([boardCopy isWinner:kPlayer]) {
                return i;
            }
        }
    }
    
    return kMoveImpossible;
}

- (NSInteger)getWinMove
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        Board *boardCopy = [self.board copy];
        
        if ([boardCopy canMarkCellAt:i]) {
            [boardCopy markAICellAt:i];
            
            if ([boardCopy isWinner:kAI]) {
                return i;
            }
        }
    }
    
    return kMoveImpossible;
}

- (NSInteger)createFork
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        Board *boardCopy = [self.board copy];
        
        if ([boardCopy canMarkCellAt:i]) {
            [boardCopy markAICellAt:i];
            
            if ([boardCopy isForkedBy:kAI]) {
                return i;
            }
        }
    }
    
    return kMoveImpossible;
}

- (NSInteger)blockFork
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        Board *boardCopy = [self.board copy];
        
        if ([boardCopy canMarkCellAt:i]) {
            [boardCopy markPlayerCellAt:i];
            
            if ([boardCopy isForkedBy:kPlayer]) {
                return i;
            }
        }
    }
    
    return kMoveImpossible;   
}

- (NSInteger)shouldTakeOppositeCorner
{
    if ([self.board emptyCells] == 8) {
        if (![self.board canMarkCellAt:0]) {
            return 8;
        } else if (![self.board canMarkCellAt:2]) {
            return 6;
        } else if (![self.board canMarkCellAt:6]) {
            return 2;
        } else if (![self.board canMarkCellAt:8]) {
            return 0;
        }
    }
    
    return kMoveImpossible;
}

# pragma public implementation

- (id)initWithBoard:(Board *)board
{
    self = [self init];
   
    if (self) {
        self.board = board;
    }
    
    return self;
}

/*
 The following algorithm will allow you (or the AI) to always deny your opponent victory:
 
 Win:
 If you have two in a row, you can place a third to get three in a row.
 Block:
 If the opponent has two in a row, you must play the third to block the opponent.
 Fork:
 Create an opportunity where you have two threats to win (two non-blocked lines of 2).
 Blocking an opponent's fork:
 If there is a configuration where the opponent can fork, you must block that fork.
 Center:
 You play the center if open.
 Opposite corner:
 If the opponent is in the corner, you play the opposite corner.
 Empty corner:
 You play in a corner square.
 Empty side:
 You play in a middle square on any of the 4 sides.
 */

- (NSInteger)getMove
{
    NSInteger move;
    // First, check if we can win in the next move
    move = [self getWinMove];
    
    if (move != kMoveImpossible) {
        return move;
    }
    
    // Check if the player could win on his next move, and block them.
    move = [self getBlockMove];
    if (move != kMoveImpossible) {
        return move;
    }
    
    // Fork - situation where we have 2 threats
    // Check if we can create fork for player
    move = [self createFork];
    if (move != kMoveImpossible) {
        return move;
    }
    
    // Can we prevent fork?
    move = [self blockFork];
    if (move != kMoveImpossible) {
        return move;
    }
    
    // try taking center
    if ([self.board canMarkCellAt:4]) {
        return 4;
    }
   
    move = [self shouldTakeOppositeCorner];
    if (move != kMoveImpossible) {
        return move;
    }
    
    // Try to take one of the corners, if they are free.
    NSArray *corners = [NSArray arrayWithObjects:@0, @2, @6, @8, nil];
    move = [self chooseRandomMoveFromList:corners];
    
    if (move != kMoveImpossible) {
        return move;
    }
  
    // take sides
    NSArray *sides = [NSArray arrayWithObjects:@1, @3, @5, @7, nil];
    return [self chooseRandomMoveFromList:sides];
}

@end
