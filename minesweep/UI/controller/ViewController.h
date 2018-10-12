//
//  ViewController.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "game.h"
#import "../listener/MineButtonClickedListener.h"
#import "../listener/GameListener.h"
@interface ViewController : NSViewController<MineButtonClickedListener,GameListener>

- (void) changeDifficulty:(int) difficulty;

- (void) setGame:(game *) g;
@end

