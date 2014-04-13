//
//  Board.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "Board.h"

@implementation Board

@synthesize cells = _cells;

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

- (NSInteger)getCellAt:(NSInteger)index
{
    NSNumber *cell = [self.cells objectAtIndex:index];
    return [cell integerValue];
}

- (BOOL)canMarkCellAt:(NSInteger)index
{
    return [[self.cells objectAtIndex:index] isEqualToNumber:[NSNumber numberWithInteger:kEmpty]];
}

- (void)markPlayerCellAt:(NSInteger)index
{
    if ([self canMarkCellAt:index]) {
        [self.cells replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:kPlayer]];
    }
}

- (void)markAICellAt:(NSInteger)index
{
    if ([self canMarkCellAt:index]) {
        [self.cells replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:kAI]];
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
        [self.cells replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:kEmpty]];
    }
}

@end