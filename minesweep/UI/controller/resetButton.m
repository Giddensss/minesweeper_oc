//
//  ResetButton.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/9.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "ResetButton.h"
@interface ResetButton(){
    SEL act;
}
@end
@implementation ResetButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
}

- (void) mouseDown:(NSEvent *)event {
    [self setImage:[NSImage imageNamed:@"reset_button_clicked"]];
}

- (void) mouseUp:(NSEvent *)event{
    [self setImage:[NSImage imageNamed:@"reset_button_normal"]];
    [self sendAction:act to:self.target];
}

- (void)setAction:(SEL)action {
    act = action;
}


@end
