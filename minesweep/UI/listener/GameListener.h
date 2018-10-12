//
//  gameListener.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/9.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#ifndef GameListener_h
#define GameListener_h

@protocol GameListener <NSObject>

- (void) onGameOver;

- (void) onGameWin;

@end

#endif /* GameListener_h */
