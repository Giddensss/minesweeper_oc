//
//  CounterViewController.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/9.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "CounterView.h"
#import "../../support/constants.h"
@interface CounterView () {
    NSImageView *digit;
    NSImageView *decades;
    NSImageView *hundreds;
    float width;
    float height;
    
    BOOL isFinishLoading;
    NSMutableArray *digits;
}
@end

@implementation CounterView

- (id) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        width = frameRect.size.width;
        height = frameRect.size.height;
        isFinishLoading = NO;
    }
    return self;
}

- (void) drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self setup];
}

- (void) setup{
    // set background
    [self setWantsLayer:YES];
    self.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    // set ImageView
    float digitWidth = width / 3.0f;
    digit = [[NSImageView alloc] initWithFrame:CGRectMake(width - digitWidth + digitViewHorizontalConstraint, digitViewVerticalConstraint,
                                                          digitWidth - 2 * digitViewHorizontalConstraint,
                                                          height - 2 * digitViewVerticalConstraint)];
    [digit setImageScaling:NSImageScaleAxesIndependently];
    [self addSubview:digit];
    
    decades = [[NSImageView alloc] initWithFrame:CGRectMake(digitWidth + digitViewHorizontalConstraint , digitViewVerticalConstraint,
                                                            digitWidth - 2 * digitViewHorizontalConstraint,
                                                            height - 2 * digitViewVerticalConstraint)];
    [decades setImageScaling:NSImageScaleAxesIndependently];
   
    [self addSubview:decades];
    hundreds = [[NSImageView alloc] initWithFrame:CGRectMake(digitViewHorizontalConstraint, digitViewVerticalConstraint,
                                                             digitWidth - 2 * digitViewHorizontalConstraint,
                                                             height - 2 * digitViewVerticalConstraint)];
    [hundreds setImageScaling:NSImageScaleAxesIndependently];
    [self addSubview:hundreds];
    if (digits) {
        [digit setImage:[NSImage imageNamed:digits[0]]];
        [decades setImage:[NSImage imageNamed:digits[1]]];
        [hundreds setImage:[NSImage imageNamed:digits[2]]];
        digits = nil;
    }
    isFinishLoading = YES;
}

- (void) updateCounter:(int) counter {
    int d = counter % 10;
    int t = counter / 10;
    int h = counter / 100;
    //NSLog(@"%d %d %d",h,t,d);
    
    if (isFinishLoading ) {
        if (d >= 0 && t >= 0 && h >= 0) {
            [digit setImage:[NSImage imageNamed:[NSString stringWithFormat:@"digit_%d",d]]];
            [decades setImage:[NSImage imageNamed:[NSString stringWithFormat:@"digit_%d",t]]];
            [hundreds setImage:[NSImage imageNamed:[NSString stringWithFormat:@"digit_%d",h]]];
        } else if (d < 0 && t >= 0 && h >=0) {
            // -1 ~ -9
            [digit setImage:[NSImage imageNamed:[NSString stringWithFormat:@"digit_%d",abs(d)]]];
            [decades setImage:[NSImage imageNamed:@"digit_negative"]];
            [hundreds setImage:nil];
        } else if (d <= 0 && t < 0 && h >= 0) {
            // -10 ~ -99
            [digit setImage:[NSImage imageNamed:[NSString stringWithFormat:@"digit_%d",abs(d)]]];
            [decades setImage:[NSImage imageNamed:[NSString stringWithFormat:@"digit_%d",abs(t)]]];
            [hundreds setImage:[NSImage imageNamed:@"digit_negative"]];
        } else if (d <= 0 && t <= 0 && h < 0) {
            // -100 ~ -999
            [digit setImage:[NSImage imageNamed:@"digit_negative"]];
            [decades setImage:[NSImage imageNamed:@"digit_negative"]];
            [hundreds setImage:[NSImage imageNamed:@"digit_negative"]];
        }
    } else {
        digits = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"digit_%d",d],[NSString stringWithFormat:@"digit_%d",t],[NSString stringWithFormat:@"digit_%d",h],nil];
    }
}

@end
