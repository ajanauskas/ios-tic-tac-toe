//
//  Board.h
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger kEmpty = 0;
static const NSInteger kPlayer = 1;
static const NSInteger kAI = 2;

static const int kBoardSize = 9;

@interface Board : NSObject <NSCopying>

@property (strong, nonatomic) NSMutableArray* cells;

- (BOOL)canMarkCellAt:(NSInteger)index;
- (BOOL)isWinner:(NSInteger)player;
- (NSInteger)getCellAt:(NSInteger)index;
- (void)markPlayerCellAt:(NSInteger)index;
- (void)markAICellAt:(NSInteger)index;
- (NSInteger)emptyCells;
- (void)reset;

@end
