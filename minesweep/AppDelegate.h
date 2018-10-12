//
//  AppDelegate.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"
#import "game.h"
#import "support/DBManager.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (void) changeDifficulty:(int) difficulty;

- (void) setMainController:(ViewController *) controller;

- (void) setGame:(game *) g;

- (BOOL) checkRecord:(int) record difficulty:(int) difficulty;

- (void) updateRecord:(int )record owner:(NSString *)owner time:(NSString *) time difficulty:(int) difficulty;

- (NSDictionary *) showRecordsForDifficulty:(int) difficulty;

- (void) showWindow:(NSViewController *) view;
@end

