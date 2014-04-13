//
//  Board.h
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 12/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int kEmpty = 0;
static const int kCross = 1;
static const int kCircle = 2;

static const int kBoardSize = 9;

@interface Board : NSObject

@property (strong, nonatomic) NSMutableArray* cells;

- (BOOL)canMarkCellAt:(NSInteger)index;
- (BOOL)isCellFilledByCrossAt:(NSInteger)index;
- (BOOL)isCellFilledByCircleAt:(NSInteger)index;
- (void)markCellWithCrossAt:(NSInteger)index;
- (void)markCellWithCircleAt:(NSInteger)index;

@end
