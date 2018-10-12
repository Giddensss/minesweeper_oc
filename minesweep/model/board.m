//
//  board.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#import "board.h"
#import "constants.h"


#define DEBUGPRINT 1
@interface board(){
    int boardWidth;
    int boardHeight;
    int mineAmount;
    NSMutableArray <NSNumber *> *gameBoard;
    int boardSize[2];
    NSMutableArray *mines;
}
@end
@implementation board

- (id) initWithDifficulty:(int) difficulty{
    self = [super init];
    if (self){
        switch (difficulty) {
            case difficultyBeginner:
                boardWidth = beginnerBoardWidth;
                boardHeight = beginnerBoardHeight;
                mineAmount = beginnerMineAmount;
                break;
            case difficultyIntermedia:
                boardWidth = intermediaBoardWidth;
                boardHeight = intermediaBoardHeight;
                mineAmount = intermediaMineAmount;
                break;
            case difficultyHard:
                boardWidth = hardBoardWidth;
                boardHeight = hardBoardHeigth;
                mineAmount = hardMineAmount;
                break;
        }
        mines = [NSMutableArray array];
        [self setupBoard];
    }
    return self;
}

- (int*) getBoardSize{
    boardSize[0] = boardWidth;
    boardSize[1] = boardHeight;
    return boardSize;
}

- (int) getValueAtIndex:(int)index{
    return [gameBoard[index] intValue];
}

- (void) setupBoard {
    // the default filling orientation is horizontal, form left to right.
    gameBoard = [NSMutableArray array];
    NSMutableArray<NSNumber *> *index = [NSMutableArray array];
    for (int i = 0; i < boardWidth * boardHeight; i ++){
        [gameBoard addObject:[NSNumber numberWithInt:0]];
        [index addObject:[NSNumber numberWithInt:i]];
    }
    
    // setting up the mines
    for (int i = 0; i < mineAmount; i++){
        int ind = [self getRandomNumberBetween:0 to:(int)index.count-1];
        [mines addObject: index[ind]];
        gameBoard[[index[ind] intValue]] = [NSNumber numberWithInt:-1];
        [index removeObjectAtIndex:ind];
    }
    
    
    // do the calculation
    for (int i = 0; i < (int)index.count; i ++){
        int ind = [index[i] intValue];
        gameBoard[ind] = [NSNumber numberWithInt:[self calculateMines:ind]];
    }
#if DEBUGPRINT
    [self printBoard];
#endif
}

- (void) printBoard{
    int columeCount = 1;
    NSMutableString *toPrint = [NSMutableString string];
    for (int i = 0; i < boardWidth * boardHeight; i ++) {
        [toPrint appendFormat:@"%@",gameBoard[i]];
        if ([gameBoard[i] intValue] != -1 && [gameBoard[i] intValue] < 10){
             [toPrint appendString:@"  "];
        }else if ([gameBoard[i] intValue] == -1){
              [toPrint appendString:@" "];
        }
        if (columeCount == boardWidth ){
            [toPrint appendString:@"\n"];
            columeCount = 1;
        }else{
            columeCount ++;
        }
    }
    NSLog(@"\n%@",toPrint);
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)(from + arc4random() % (to-from+1));
}

- (NSArray *) getMines{
    return mines;
}

- (int) calculateMines:(int) index{
    int realIndex;
    int count = 0;
    int iteration = 0;
    int dividor = 0;
    int remainder = 0;
    if (index % boardWidth == 0) {
        realIndex = index - boardWidth;
        iteration = 6;
        dividor = 2;
        remainder = 1;
    }else if ((index + 1) % boardWidth == 0) {
        realIndex = index - boardWidth - 1;
        iteration = 6;
        dividor = 2;
        remainder = 1;
    } else {
        realIndex = index - boardWidth-1;
        iteration = 9;
        dividor = 3;
        remainder = 2;
    }
    for (int i = 0; i < iteration; i++ ){
        // NSLog(@"realIndex %d",realIndex);
        if (realIndex >= 0 && realIndex < boardWidth * boardHeight) {
            if ([gameBoard[realIndex] intValue] == -1) {
                count += 1;
            }
        }
        
        if (i % dividor == remainder) {
            realIndex += boardWidth-remainder;
        } else {
            realIndex += 1;
        }
    }
    //NSLog(@"%d %d",index,count);
    return count;
}

- (int) getMineAount {
    return  mineAmount;
}


@end
