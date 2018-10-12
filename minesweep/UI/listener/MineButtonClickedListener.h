//
//  MineButtonClickedListener.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/6.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#ifndef MineButtonClickedListener_h
#define MineButtonClickedListener_h

@protocol MineButtonClickedListener <NSObject>

- (BOOL) isButtonLocked;

- (void) onButtonLeftMouseDownOnClickedCell:(int) index sender:(id) sender;

- (void) onButtonLeftMouseDown:(int) index sender:(id) sender;

- (void) onButtonRightMouseDown:(int) index sender:(id) sender isMark:(BOOL) flag;

@end
#endif /* MineButtonClickedListener_h */
