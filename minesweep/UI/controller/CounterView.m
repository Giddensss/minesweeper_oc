//
//  CounterViewController.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/9.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "CounterViewController.h"

@interface CounterView () {
    NSImageView *digit;
    NSImageView *decades;
    NSImageView *hundreds;
    float width;
    float height;
}
@end

@implementation CounterViewController

- (id) initWithFrame:(NSRect)frameRect {
    
}

- (void) drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void) setup{
    // set background
    [self setWantsLayer:YES];
    self.layer.backgroundColor = [NSColor blackColor].CGColor;
}

- (void) updateCounter:(int) counter {
    int d = counter % 10;
    int t = counter / 10;
    int h = counter / 100;
}

@end
