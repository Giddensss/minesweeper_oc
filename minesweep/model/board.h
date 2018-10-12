//
//  board.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface board : NSObject
- (id) initWithDifficulty:(int) difficulty;
- (int) getMineAount;
- (int *) getBoardSize;
- (int) getValueAtIndex:(int) index;
- (NSArray *) getMines;
@end
