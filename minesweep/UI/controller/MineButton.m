//
//  MineButton.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/6.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "MineButton.h"
#import "../../support/constants.h"
@interface MineButton() {
    int status; /* The status of a button: 0: normal 1:clicked 2:flaged 3:hold*/
    id<MineButtonClickedListener> mouseListener;
    float totalDraggedX;
    float totalDraggedY;
    float mouseDownX;
    float mouseDownY;
    float posX;
    float posY;
}
@end
@implementation MineButton
- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        status = 0;
        [self setTitle:@""];
        [self setImage:[NSImage imageNamed:@"button_empty"]];
        [self setBordered:NO];
        [self setFont:[NSFont boldSystemFontOfSize:14.0f]];
        posX = frameRect.origin.x;
        posY = frameRect.origin.y;
        
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
}

- (void) mouseDown:(NSEvent *)event {
    if ((status != 0 && status != 1) || [mouseListener isButtonLocked]) {
        return;
    }
    mouseDownX = event.locationInWindow.x;
    mouseDownY = event.locationInWindow.y;
    if (status == 0) {
        [self setImage:[NSImage imageNamed:@"button_empty_clicked"]];
    }
}

- (void) mouseUp:(NSEvent *)event {
    if ([mouseListener isButtonLocked]) {
        totalDraggedX = 0;
        totalDraggedY = 0;
        return;
    }
    if (status == 0) {
        if ([self inButton]) {
            [self setImage:[NSImage imageNamed:@"button_empty"]];
        } else {
            
            [self setImage:[NSImage imageNamed:@"button_clicked"]];
            [mouseListener onButtonLeftMouseDown:self.index sender:self];
            status = 1;
        }
    } else if (status == 1) {
        if (! [self inButton]) {
            [mouseListener onButtonLeftMouseDownOnClickedCell:self.index sender:self];
        }
    }
    totalDraggedX = 0;
    totalDraggedY = 0;
    
}

- (void)rightMouseDown:(NSEvent *)event {
    if (status == 1 || [mouseListener isButtonLocked]) {
        return;
    }
    mouseDownX = event.locationInWindow.x;
    mouseDownY = event.locationInWindow.y;
    [self setImage:[NSImage imageNamed:@"button_empty_clicked"]];
    
}

- (void) mouseDragged:(NSEvent *)event{
    totalDraggedX += event.deltaX;
    totalDraggedY += event.deltaY;
    
}

- (void) rightMouseDragged:(NSEvent *)event {
    totalDraggedX += event.deltaX;
    totalDraggedY += event.deltaY;
}

- (void) rightMouseUp:(NSEvent *)event {
    if ([mouseListener isButtonLocked]) {
        totalDraggedX = 0;
        totalDraggedY = 0;
        return;
    }
    if (status != 1) {
        if ([self inButton]) {
            switch (status) {
                case 0:
                    [self setImage:[NSImage imageNamed:@"button_empty"]];
                    break;
                case 2:
                    [self setImage:[NSImage imageNamed:@"button_flag"]];
                    break;
            }
        }else {
            switch (status) {
                case 0:
                    [self setImage:[NSImage imageNamed:@"button_flag"]];
                    status = 2;
                    [mouseListener onButtonRightMouseDown:self.index sender:self isMark:YES];
                    break;
                case 2:
                    [self setImage:[NSImage imageNamed:@"button_empty"]];
                    status = 0;
                    [mouseListener onButtonRightMouseDown:self.index sender:self isMark:NO];
                    break;
            }
        }
    }
    totalDraggedX = 0;
    totalDraggedY = 0;
}

-(void) otherMouseDown:(NSEvent *)event {
    NSLog(@"other?");
}

- (void) setMouseDownListener:(id<MineButtonClickedListener>)listener {
    mouseListener = listener;
}

- (void)setTitleColor:(NSColor *)color {
    NSMutableAttributedString *colorTitle = [[NSMutableAttributedString alloc] initWithAttributedString: [self attributedTitle]];
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:titleRange];
    [self setAttributedTitle:colorTitle];
}

- (void)clickedOnMine:(BOOL) isClickedOnThis{
    if (status != 2) {
        [self setImage:isClickedOnThis ? [NSImage imageNamed:@"mine_clicked"] : [NSImage imageNamed:@"mine_normal"]];
    }

}

- (void) clicked:(int) value titleColor:(nonnull NSColor *)color{
    if (value > 0) {
        [self setTitle:[NSString stringWithFormat:@"%d",value]];
        [self setTitleColor:color];
    }
    [self setImage:[NSImage imageNamed:@"button_clicked"]];
    status = 1;
}

- (void) wrongMark {
    [self setImage: [NSImage imageNamed:@"button_flag_wrong"]];
}

- (void) reset {
    status = 0;
    [self setTitle:@""];
    [self setImage:[NSImage imageNamed:@"button_empty"]];
}

-(BOOL) inButton{
    return (mouseDownX + totalDraggedX > posX + mineIconWidth + 5 ||
    mouseDownX + totalDraggedX < posX - 5 ||
    mouseDownY - totalDraggedY  > posY + mineIconWidth + 5 ||
            mouseDownY - totalDraggedY < posY - 5);
}
@end
