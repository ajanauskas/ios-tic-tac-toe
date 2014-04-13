//
//  Match.m
//  Unbeatable Tic Tac Toe
//
//  Created by Andrius Janauskas on 13/04/14.
//  Copyright (c) 2014 Andrius Janauskas. All rights reserved.
//

#import "Match.h"

@implementation Match

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
    }
    
    return self;
}

@end
