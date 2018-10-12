//
//  game.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#import "game.h"

@interface game(){
    board *gameBoard;
    int difficulty;
    NSMutableArray *markedCell;
    id<GameListener> gameListener;
}
@end
@implementation game
- (id) init{
    self = [super init];
    if (self){
        difficulty = difficultyBeginner;
        //gameBoard = [[board alloc] initWithDifficulty:difficulty];
        //markedCell = [NSMutableArray array];
        //_gameStatusFlag = idle;
    }
    return self;
}

- (void) changeDifficulty:(int)difficulty{
    self->difficulty = difficulty;
    gameBoard = [[board alloc] initWithDifficulty:difficulty];
    markedCell = [NSMutableArray array];
    _gameStatusFlag = idle;
}

- (int *) getBoardSize{
    return [gameBoard getBoardSize];
}

- (int) getDifficulty{
    return difficulty;
}

- (int) getValueAtIndex:(int) index{
    return [gameBoard getValueAtIndex:index];
}

- (NSArray *) getMines{
    return [gameBoard getMines];
}

- (void) markMine:(int)index isMark:(BOOL)flag{
    if (flag) {
        [markedCell addObject:[NSNumber numberWithInt:index]];
    }else {
        [markedCell removeObject:[NSNumber numberWithInt:index]];
    }
}

- (NSArray *) getMarkedCells {
    return markedCell;
}

- (void) isWin {
    NSArray *mines = [gameBoard getMines];
    if (mines.count == markedCell.count){
        BOOL flag = YES;
        for (NSNumber *i in mines) {
            if (![markedCell containsObject:i]){
                flag = NO;
                break;
            }
        }
        if (flag) {
            [gameListener onGameWin];
            _gameStatusFlag = win;
        }
    }    
}

- (void) resetGame {
    [self changeDifficulty:difficulty];
}

- (void) setGameListener:(id<GameListener>) listener {
    gameListener = listener;
}

- (void) gameStart {
    if (_gameStatusFlag == idle) {
        _gameStatusFlag = playing;
    }
}

- (void) setGameStatusFlag:(enum gameStatus)gameStatusFlag {
    _gameStatusFlag = gameStatusFlag;
    if (_gameStatusFlag == lose) {
        [gameListener onGameOver];
    }else if (_gameStatusFlag == win) {
        [gameListener onGameWin];
    }
}
@end
