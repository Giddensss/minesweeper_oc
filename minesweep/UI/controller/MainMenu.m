//
//  MainMenu.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/10.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "MainMenu.h"
#import "../../AppDelegate.h"
#import "RecordViewWindow.h"
@interface MainMenu () {
    AppDelegate *myDelegate;
    RecordViewWindow *window;
}
@end
@implementation MainMenu
- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        myDelegate = [NSApplication sharedApplication].delegate;
        NSStoryboard *myStoryBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
        window = [myStoryBoard instantiateControllerWithIdentifier:@"recordWindow"];
    }
    return self;
}
- (IBAction)recordItemClicked:(NSMenuItem *)sender {
    [myDelegate showWindow:window];
}
- (IBAction)difficultyItemClicked:(NSMenuItem *)sender {
    NSLog(@"%@",sender.identifier);
    NSString *identifier = sender.identifier;
    if ([identifier isEqualToString:@"beginner"]) {
        [myDelegate changeDifficulty:difficultyBeginner];
    } else if ([identifier isEqualToString:@"intermedia"]) {
        [myDelegate changeDifficulty:difficultyIntermedia];
    } else if ([identifier isEqualToString:@"hard"]) {
        [myDelegate changeDifficulty:difficultyHard];
    }
}

@end
