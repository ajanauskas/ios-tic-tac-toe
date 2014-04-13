//
//  MatchTests.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Match.h"

@interface MatchTests : XCTestCase

@property (strong, nonatomic) Match* match;

@end

@implementation MatchTests

- (void)setUp
{
    [super setUp];
    
    self.match = [[Match alloc] initWithPlayerStarts:YES];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_getMatchStatus_boardFull
{
    for (NSInteger i = 0; i < kBoardSize; i++) {
        [self.match.board markPlayerCellAt:i];
    }
    
    XCTAssertEqual([self.match getMatchStatus], kEnded, @"Filled board should return ended status");
}

- (void)test_getMatchStatus_boardEmpty
{
    XCTAssertEqual([self.match getMatchStatus], kInProgress, @"Empty board should return in progress status");
}

- (void)test_getMatchStatus_winningPositions
{
    [self.match.board markPlayerCellAt:0];
    [self.match.board markPlayerCellAt:1];
    [self.match.board markPlayerCellAt:2];
    
     XCTAssertEqual([self.match getMatchStatus], kEnded, @"Should return ended status");
    
    [self.match reset];
    
    [self.match.board markPlayerCellAt:0];
    [self.match.board markPlayerCellAt:4];
    [self.match.board markPlayerCellAt:8];
    
    XCTAssertEqual([self.match getMatchStatus], kEnded, @"Should return ended status");
}

@end
