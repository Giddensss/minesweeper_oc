//
//  MineButton.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/6.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../listener/MineButtonClickedListener.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineButton : NSButton

@property int index;

- (void) setMouseDownListener:(id<MineButtonClickedListener>) listener;

- (void) setTitleColor:(NSColor *) color;

- (void) clickedOnMine:(BOOL) isClickOnThis;

- (void) clicked:(int) value titleColor:(NSColor *) color;

- (void) wrongMark;

- (void) reset;

@end

NS_ASSUME_NONNULL_END
