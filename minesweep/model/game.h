//
//  game.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "board.h"
#import "../UI/listener/GameListener.h"
#import "constants.h"
@interface game : NSObject
@property (nonatomic) enum gameStatus gameStatusFlag;
- (int) getValueAtIndex:(int) index;

- (void) changeDifficulty:(int) difficulty;

- (int) getDifficulty;

- (int *) getBoardSize;

- (NSArray *) getMines;

- (void) markMine:(int) index isMark:(BOOL) flag;

- (NSArray *) getMarkedCells;

- (void) isWin;

- (void) resetGame;

- (void) setGameListener:(id<GameListener>) listener;

- (void) gameStart;

@end
