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
        
        for (int i = 0; i < kBoardSize; i++) {
            [self.cells addObject:[NSNumber numberWithInt:kEmpty]];
        }
    }

    return self;
}


- (BOOL)canMarkCellAt:(NSInteger)index
{
    return [[self.cells objectAtIndex:index] isEqualToNumber:[NSNumber numberWithInt:kEmpty]];
}

- (BOOL)isCellFilledByCrossAt:(NSInteger)index
{
    return [[self.cells objectAtIndex:index] isEqualToNumber:[NSNumber numberWithInt:kCross]];
}

- (BOOL)isCellFilledByCircleAt:(NSInteger)index
{
    return [[self.cells objectAtIndex:index] isEqualToNumber:[NSNumber numberWithInt:kCircle]];
}

- (void)markCellWithCrossAt:(NSInteger)index
{
    if ([self canMarkCellAt:index]) {
        [self.cells replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:kCross]];
    }
}

- (void)markCellWithCircleAt:(NSInteger)index
{
    if ([self canMarkCellAt:index]) {
        [self.cells replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:kCircle]];
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
        [self.cells replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:kEmpty]];
    }
}

@end