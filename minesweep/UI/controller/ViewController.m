//
//  ViewController.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//
#import "constants.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "MineButton.h"
#import "CounterView.h"
#import "ResetButton.h"
#import "RecordAddView.h"

@interface ViewController(){
    CGFloat frameWidth;
    CGFloat frameHeight;
    IBOutlet NSView *buttonView;
    IBOutlet NSView *infoView;
    ResetButton *resetButton;
    CounterView *counterView;
    CounterView *timerView;
    game *myGame;
    AppDelegate *delegate;
    NSArray *colors;
    NSArray *infoPanelBGImages;
    NSMutableArray<MineButton *> *mineButtons;
    NSMutableArray *expendedIndex;
    BOOL shouldLockBtn;
    NSTimer *clock;
    int time;
    BOOL isInited;
}
@end
@implementation ViewController
- (id) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self){
        colors = @[[NSColor blackColor],
                   [NSColor blueColor],
                   [NSColor colorWithRed:51.0f/255.0f green:126.0f/255.0f blue:10.0f/255.0f alpha:1],
                   [NSColor redColor],[NSColor purpleColor],
                   [NSColor colorWithRed:200.0f/255.0f green:165.0f/255.0f blue:8.0f/255.0f alpha:1],
                   [NSColor cyanColor],
                   [NSColor orangeColor],
                   [NSColor systemPinkColor],
                   [NSColor magentaColor]];
        infoPanelBGImages = @[@"info_panel_beginner",@"info_panel_intermedia",@"info_panel_hard"];
        shouldLockBtn = NO;
        time = 0;
        isInited = NO;
        /*if (frameWidth == 0){
            frameWidth = beginnerWindowWidth;
            frameHeight = beginnerWindowHeight;
        }*/
        delegate = [NSApplication sharedApplication].delegate;
        myGame = [[game alloc] init];
        [myGame setGameListener:self];
        [delegate setGame:myGame];
        [delegate setMainController:self];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear{
    if (!isInited) {
        [self changeDifficulty:[myGame getDifficulty]];
        isInited = YES;
        
    }
}

- (void) changeDifficulty:(int)difficulty{
    switch (difficulty) {
        case difficultyBeginner:
            frameWidth = beginnerWindowWidth;
            frameHeight = beginnerWindowHeight;
            break;
        case difficultyIntermedia:
            frameWidth = intermediaWindowWidth;
            frameHeight = intermediaWindowHeight;
            break;
        case difficultyHard:
            frameWidth = hardWindoWidth;
            frameHeight = hardWindowHeight;
            break;
    }
    [self resetUI];
    [myGame changeDifficulty:difficulty];
    [self changeWindowSizeInternal];
    
}

- (void) setup{
    mineButtons = [NSMutableArray array];
    int buttonsInRow = [myGame getBoardSize][0];
    int buttonsInColumn = [myGame getBoardSize][1];
    
    [buttonView setFrameSize:CGSizeMake(frameWidth, frameHeight - infoPanelHeight)];
    [buttonView setFrameOrigin:CGPointMake(windowMargin, windowMargin)];

    int row = 0;
    int column = 0;
    CGFloat startX = 0;
    CGFloat startY = buttonView.frame.size.height - mineIconWidth;
    for (int i = 0; i < buttonsInRow * buttonsInColumn; i ++){
        MineButton *button = [[MineButton alloc] initWithFrame:NSMakeRect(startX + column * mineIconWidth,
                                                                      startY - row * mineIconWidth,
                                                                      mineIconWidth, mineIconWidth)];
        //[button setTitle:[NSString stringWithFormat:@"%d",i]];
        [button setBordered:NO];
        [button setMouseDownListener:self];
        [button setRefusesFirstResponder:YES];
        [button setIndex:i];
        [buttonView addSubview:button];
        [mineButtons addObject:button];
        if (column == buttonsInRow - 1){
            column = 0;
            row ++;
        }else{
            column ++;
        }
    }
    
    // set info panel
    [infoView setFrameOrigin:CGPointMake(windowMargin, buttonView.frame.origin.y + buttonView.frame.size.height + windowMargin * 2)];
    [infoView setFrameSize:CGSizeMake(frameWidth,infoPanelHeight)];
    
    NSImageView *infoBG = [[NSImageView alloc] initWithFrame:CGRectMake(0, 0, infoView.frame.size.width, infoView.frame.size.height)];
    
    [infoBG setImage:[NSImage imageNamed:infoPanelBGImages[[myGame getDifficulty]]]];
    [infoBG setImageScaling:NSImageScaleAxesIndependently];
    [infoView addSubview:infoBG];
    
    
    counterView = [[CounterView alloc] initWithFrame:CGRectMake(infoPanelHorizontalConstraint, infoPanelVerticalConstraint - 1,
                                                                infoPanelWidgetWidth, infoPanelHeight - 2 * infoPanelVerticalConstraint)];
    [infoView addSubview:counterView];
    [counterView updateCounter:(int)[myGame getMines].count];
    
    timerView = [[CounterView alloc] initWithFrame:CGRectMake(infoView.frame.size.width - infoPanelWidgetWidth - infoPanelHorizontalConstraint,
                                                              infoPanelVerticalConstraint - 1,infoPanelWidgetWidth,
                                                              infoPanelHeight - 2 * infoPanelVerticalConstraint)];
    [timerView updateCounter:time];
    [infoView addSubview:timerView];
    
    resetButton = [[ResetButton alloc] initWithFrame:CGRectMake((infoView.frame.size.width - resetButtonSize) / 2,
                                                             (infoView.frame.size.height - resetButtonSize) / 2 - 2,
                                                             resetButtonSize, resetButtonSize)];
    [resetButton setImage:[NSImage imageNamed:@"reset_button_normal"]];
    [resetButton setImageScaling:NSImageScaleAxesIndependently];
    [resetButton setBordered:NO];
    [resetButton setRefusesFirstResponder:YES];
    [resetButton setTarget: self];
    [resetButton setAction:@selector(resetButtionClicked:)];
    [infoView addSubview:resetButton];
}

- (void) setGame:(game *)g{
    myGame = g;
    [myGame setGameListener: self];
}

- (void) resetButtionClicked:(NSButton *)sender {
    [myGame resetGame];
    //[myGame setGameStatusFlag:idle];
    [self resetUI];
}

- (void) resetUI {
    for (MineButton *btn in mineButtons) {
        [btn reset];
    }
    shouldLockBtn = NO;
    [clock invalidate];
    time = 0;
    [timerView updateCounter:time];
    [counterView updateCounter:(int)[myGame getMines].count];
}

- (void) onButtonLeftMouseDownOnClickedCell:(int)index sender:(id)sender {
    [self mouseDownShortcut:index];
}

- (void) onButtonLeftMouseDown:(int)index sender:(MineButton *)sender{
    if (myGame.gameStatusFlag == idle) {
        clock = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
        [myGame gameStart];
    }
    int value = [myGame getValueAtIndex:index];
    if (value > 0) {
        [sender setTitle:[NSString stringWithFormat:@"%d",value]];
        [sender setTitleColor:colors[value]];
    }  else if (value < 0) {
        // show all mines
        // gameover
        [self clickOnMine : index];
    } else {
        // shortcut
        expendedIndex = [NSMutableArray array];
        [self shortcut:index];
    }
}

-(void) clickOnMine:(int) index{
    NSArray *mines = [myGame getMines];
    for (NSNumber *i in mines) {
        if ([i intValue] == index) {
            [mineButtons[[i intValue]] clickedOnMine:YES];
        }else {
            [mineButtons[[i intValue]] clickedOnMine:NO];
        }
    }
    NSArray *makrdCells = [myGame getMarkedCells];
    for (NSNumber *i in makrdCells) {
        if (![mines containsObject:i]) {
            [mineButtons[[i intValue]] wrongMark];
        }
    }
    [myGame setGameStatusFlag:lose];
}

- (void)onButtonRightMouseDown:(int)index sender:(id)sender isMark:(BOOL)flag {
    if (myGame.gameStatusFlag == idle) {
        clock = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
        [myGame gameStart];
    }
    [myGame markMine:index isMark:flag];
    [counterView updateCounter:(int)[myGame getMines].count - (int)[myGame getMarkedCells].count];
    // check if game is win.
    [myGame isWin];
}

- (BOOL) isButtonLocked {
    return shouldLockBtn;
}

- (void) onGameOver {
    shouldLockBtn = YES;
    [resetButton setImage:[NSImage imageNamed:@"reset_button_lose"]];
    [clock invalidate];
}

- (void) onGameWin {
    shouldLockBtn = YES;
    [resetButton setImage:[NSImage imageNamed:@"reset_button_win"]];
    [clock invalidate];
    if ([delegate checkRecord:time difficulty: [myGame getDifficulty]] ){
        NSStoryboard *myStoryBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
        RecordAddView * view = [myStoryBoard instantiateControllerWithIdentifier:@"recordAddView"];
        [view.view setFrameOrigin:NSMakePoint(self.view.frame.size.width / 2 - view.view.frame.size.width / 2,
                                                 self.view.frame.size.height / 2 - view.view.frame.size.height / 2)];
        [view setupRecordInformation:time difficulty:[myGame getDifficulty]];
        [self presentViewControllerAsSheet:view];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Congratulation!"];
        [alert setInformativeText:[NSString stringWithFormat:@"You have swept off all the mines with total time %d seconds!",time]];
        [alert addButtonWithTitle:@"CHEER!"];
        [alert setIcon:[NSImage imageNamed:@"icon"]];
        [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:nil];
    }
}


- (void) changeWindowSizeInternal{
    NSRect frame = self.view.window.frame;
    frame.size = CGSizeMake(frameWidth + windowMargin * 2,frameHeight + windowMargin * 2 + 30);
    frame.origin = CGPointMake(([NSScreen mainScreen].frame.size.width - frame.size.width) / 2,
                               ([NSScreen mainScreen].frame.size.height - frame.size.height) / 2);
    [self.view.window setFrame:frame display:YES];
    [self setup];
}

- (void) shortcut:(int) index {
    int realIndex;
    int iteration = 0;
    int dividor = 0;
    int remainder = 0;
    if (index % [myGame getBoardSize][0] == 0) {
        realIndex = index - [myGame getBoardSize][0];
        iteration = 6;
        dividor = 2;
        remainder = 1;
    }else if ((index + 1) % [myGame getBoardSize][0] == 0) {
        realIndex = index - [myGame getBoardSize][0] - 1;
        iteration = 6;
        dividor = 2;
        remainder = 1;
    } else {
        realIndex = index - [myGame getBoardSize][0]-1;
        iteration = 9;
        dividor = 3;
        remainder = 2;
    }
    
    [expendedIndex addObject:[NSNumber numberWithInt:index]];
    for (int i = 0; i < iteration; i++) {
        if (realIndex >= 0 && realIndex < myGame.getBoardSize[0] * myGame.getBoardSize[1]) {
            int value = [myGame getValueAtIndex:realIndex];
            if (value > 0 && ![[myGame getMarkedCells] containsObject:[NSNumber numberWithInt:realIndex]]) {
                [mineButtons[realIndex] clicked:value titleColor:colors[value]];
            }else if (value == 0 && ![expendedIndex containsObject:[NSNumber numberWithInt:realIndex]] && ![[myGame getMarkedCells] containsObject:[NSNumber numberWithInt:realIndex]]) {
                [mineButtons[realIndex] clicked:value titleColor:colors[value]];
                [self shortcut:realIndex];
            }
        }
        
        if (i % dividor == remainder) {
            realIndex += myGame.getBoardSize[0]-remainder;
        }else {
            realIndex += 1;
        }
    }
}

- (void) mouseDownShortcut:(int) index{
    int realIndex;
    int value = [myGame getValueAtIndex:index];
    int iteration = 0;
    int dividor = 0;
    int remainder = 0;
    int count = 0;
    int temp = 0;
    if (index % [myGame getBoardSize][0] == 0) {
        realIndex = index - [myGame getBoardSize][0];
        iteration = 6;
        dividor = 2;
        remainder = 1;
    }else if ((index + 1) % [myGame getBoardSize][0] == 0) {
        realIndex = index - [myGame getBoardSize][0] - 1;
        iteration = 6;
        dividor = 2;
        remainder = 1;
    } else {
        realIndex = index - [myGame getBoardSize][0]-1;
        iteration = 9;
        dividor = 3;
        remainder = 2;
    }
    temp = realIndex;
    NSArray *marked = [myGame getMarkedCells];
    for (int i = 0; i < iteration; i++) {
        if ([marked containsObject:[NSNumber numberWithInt:realIndex]]){
            count += 1;
        }
        if (i % dividor == remainder) {
            realIndex += myGame.getBoardSize[0]-remainder;
        }else {
            realIndex += 1;
        }
    }
    if (count >= value) {
        realIndex = temp;
        for (int i = 0; i < iteration; i++) {
             if (realIndex >= 0 && realIndex < myGame.getBoardSize[0] * myGame.getBoardSize[1]) {
                 value = [myGame getValueAtIndex:realIndex];
                 if (value > 0 && ![marked containsObject:[NSNumber numberWithInt:realIndex]]) {
                     [mineButtons[realIndex] clicked:value titleColor:colors[value]];
                 }else if (value == 0 && ![marked containsObject:[NSNumber numberWithInt:realIndex]]) {
                     expendedIndex = [NSMutableArray array];
                     [mineButtons[realIndex] clicked:value titleColor:colors[value]];
                     [self shortcut:realIndex];
                 }else if (value < 0){
                     if (![marked containsObject:[NSNumber numberWithInt:realIndex]]) {
                         [self clickOnMine:realIndex];
                         return;
                     }
                 }
             }
            
            if (i % dividor == remainder) {
                realIndex += myGame.getBoardSize[0]-remainder;
            }else {
                realIndex += 1;
            }
        }
    }
    
}

- (void) updateClock {
    time += 1;
    [timerView updateCounter:time];
}


@end
