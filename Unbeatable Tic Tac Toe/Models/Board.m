//
//  Board.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "Board.h"

@interface Board()

- (BOOL)cellsAreMarkedAt:(NSInteger *)indexes by:(NSInteger)by;

@end

@implementation Board

@synthesize cells = _cells;

# pragma private implementation

- (BOOL)cellsAreMarkedAt:(NSInteger*)indexes by:(NSInteger)by
{
    NSNumber *player = [NSNumber numberWithInteger:by];
    NSNumber *firstCell = [self.cells objectAtIndex:indexes[0]];
    NSNumber *secondCell = [self.cells objectAtIndex:indexes[1]];
    NSNumber *thirdCell = [self.cells objectAtIndex:indexes[2]];
    
    return (
            [firstCell isEqualToNumber:player] &&
            [secondCell isEqualToNumber:player] &&
            [thirdCell isEqualToNumber:player]
            );
}

# pragma public implementation

- (id)init
{
    self = [super init];
    
    if (self) {
        self.cells = [NSMutableArray array];
        
        for (NSInteger i = 0; i < kBoardSize; i++) {
            [self.cells addObject:[NSNumber numberWithInteger:kEmpty]];
        }
    }

    return self;
}

- (BOOL)isWinner:(NSInteger)player
{
    int winningSituations[8][3] = {
        {6, 7, 8},
        {3, 4, 5},
        {0, 1, 2},
        {0, 3, 6},
        {1, 4, 7},
        {2, 5, 8},
        {0, 4, 8},
        {2, 4, 6}
    };
    
    for (int i = 0; i < 8; i++) {
        if ([self cellsAreMarkedAt:winningSituations[i] by:player]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSInteger)getCellAt:(NSInteger)index
{
    NSNumber *cell = [self.cells objectAtIndex:index];
    return [cell integerValue];
}

- (BOOL)canMarkCellAt:(NSInteger)index
{
    return [[self.cells objectAtIndex:index] isEqualToNumber:@(kEmpty)];
}

- (BOOL)isForkedBy:(NSInteger)player
{
    NSInteger threats = 0;
    
    for (NSInteger i = 0; i < kBoardSize; i++) {
        Board *boardCopy = [self copy];
        
        if ([boardCopy canMarkCellAt:i]) {
            if (player == kPlayer) {
                [boardCopy markPlayerCellAt:i];
            } else {
                [boardCopy markAICellAt:i];
            }
            
            if ([boardCopy isWinner:player]) {
                threats += 1;
            }
        }
    }
    
    return threats > 1;
}

- (void)markPlayerCellAt:(NSInteger)index
{
    if ([self canMarkCellAt:index]) {
        [self.cells replaceObjectAtIndex:index withObject:@(kPlayer)];
    }
}

- (void)markAICellAt:(NSInteger)index
{
    if ([self canMarkCellAt:index]) {
        [self.cells replaceObjectAtIndex:index withObject:@(kAI)];
    }
}

- (NSInteger)emptyCells
{
    NSInteger emptyCellsCount = 0;
    
    for (NSInteger i = 0; i < kBoardSize; i++) {
        if ([self canMarkCellAt:i]) {
            emptyCellsCount += 1;
        }
    }
    
    return emptyCellsCount;
}

- (void)reset
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        [self.cells replaceObjectAtIndex:i withObject:@(kEmpty)];
    }
}

# pragma NSCopying implementation

- (id)copyWithZone:(NSZone *)zone
{
    Board *copy = [[Board allocWithZone:zone] init];
    copy.cells = [self.cells mutableCopyWithZone:zone];
    
    return copy;
}

@end