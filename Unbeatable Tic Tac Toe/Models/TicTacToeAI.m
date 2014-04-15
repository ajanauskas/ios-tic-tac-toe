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

# pragma public implementation

- (id)initWithBoard:(Board *)board
{
    self = [self init];
   
    if (self) {
        self.board = board;
    }
    
    return self;
}

- (NSInteger)getMove
{
    // Here is our algorithm for our Tic Tac Toe AI:
    // First, check if we can win in the next move
    for (NSInteger i = 0; i < kBoardSize; i++) {
        @autoreleasepool {
            Board *boardCopy = [self.board copy];
            
            if ([boardCopy canMarkCellAt:i]) {
                [boardCopy markAICellAt:i];
                
                if ([boardCopy isWinner:kAI]) {
                    return i;
                }
            }
        }
    }

    // Check if the player could win on his next move, and block them.
    for (NSInteger i = 0; i < kBoardSize; i++) {
        @autoreleasepool {
            Board *boardCopy = [self.board copy];
            
            if ([boardCopy canMarkCellAt:i]) {
                [boardCopy markPlayerCellAt:i];
                
                if ([boardCopy isWinner:kPlayer]) {
                    return i;
                }
            }
        }
    }
    
    // Try to take center if its first move
    if ([self.board canMarkCellAt:4] && [self.board emptyCells] == 9) {
        return 4;
    }
    
    // Try to take one of the corners, if they are free.
    NSArray *corners = [NSArray arrayWithObjects:@0, @2, @6, @8, nil];
    NSInteger move = [self chooseRandomMoveFromList:corners];
    
    if (move != kMoveImpossible) {
        return move;
    }
    
    if ([self.board canMarkCellAt:4]) {
        return 4;
    }
   
    // take sides
    NSArray *sides = [NSArray arrayWithObjects:@1, @3, @5, @7, nil];
    return [self chooseRandomMoveFromList:sides];
}

@end
