//
//  TicTacToeAITests.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 14/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TicTacToeAI.h"

@interface TicTacToeAITests : XCTestCase

@property (strong, nonatomic) TicTacToeAI* ticTacToeAI;

@end

@implementation TicTacToeAITests

- (void)setUp
{
    [super setUp];
    
    Board* board = [[Board alloc] init];
    
    self.ticTacToeAI = [[TicTacToeAI alloc] initWithBoard:board];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_getMove_emptyBoard
{
    XCTAssert([self.ticTacToeAI getMove] != kMoveImpossible, @"Did not recognised that more moves can be performed");
}

- (void)test_getMove_fullBoard
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        [self.ticTacToeAI.board markPlayerCellAt:i];
    }
    
    XCTAssert([self.ticTacToeAI getMove] == kMoveImpossible, @"Did not recognised that no more moves can be performed");
}

- (void)test_getMove_winBlock
{
    /*
     0 . .
     . . .
     0 . x
     */
    
    [self.ticTacToeAI.board markPlayerCellAt:0];
    [self.ticTacToeAI.board markPlayerCellAt:6];
    [self.ticTacToeAI.board markAICellAt:8];
    
    XCTAssert([self.ticTacToeAI getMove] == 3, @"Did not block player win");
    
    [self.ticTacToeAI.board reset];
    
    /*
     0 . 0
     . x .
     . . .
     */
    
    [self.ticTacToeAI.board markPlayerCellAt:0];
    [self.ticTacToeAI.board markPlayerCellAt:2];
    [self.ticTacToeAI.board markAICellAt:4];
    
    XCTAssert([self.ticTacToeAI getMove] == 1, @"Did not block player win");
}

@end
