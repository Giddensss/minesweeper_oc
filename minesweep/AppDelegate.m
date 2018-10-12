//
//  AppDelegate.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//
#import "support/constants.h"
#import "AppDelegate.h"
@interface AppDelegate (){
    ViewController *mainController;
    game *myGame;
    NSString *filePath;
    NSMutableDictionary *records;
    DBManager *dbManager;
}
@end

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    filePath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),recordDir];
    BOOL shouldInitDB = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",filePath,recordDB] contents:nil attributes:nil];
        shouldInitDB = YES;
    }
    dbManager = [[DBManager alloc] init];
    if (shouldInitDB) {
        [dbManager initTables];
    }
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void) changeDifficulty:(int)difficulty{
    [mainController changeDifficulty:difficulty];
}

- (void) setGame:(game *)g{
    myGame = g;
}

- (void) setMainController:(ViewController *)controller{
    mainController = controller;
}

- (BOOL) checkRecord:(int)record difficulty:(int)difficulty {
    int best = [dbManager getBestRecordForDifficulty:difficulty];
    return record < best ? YES :NO;
}

- (void) updateRecord:(int)record owner:(NSString *)owner time:(NSString *)time difficulty:(int)difficulty{
    [dbManager updateBestRecords:record level:difficulty owner:owner timeStamp:time];
}

- (NSDictionary *) showRecordsForDifficulty:(int)difficulty {
    return [dbManager getRecordsForDifficulty:difficulty];
}

- (void) showWindow:(NSViewController *)view {
    [mainController presentViewControllerAsSheet:view];
}
@end
