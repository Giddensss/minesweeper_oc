//
//  constants.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/4/28.
//  Copyright © 2018年 Alan L  Hamilton. All rights reserved.
//

#ifndef constants_h
#define constants_h

#endif /* constants_h */
#import <AppKit/AppKit.h>

static const float windowMargin = 3.0f;
static const float infoPanelHeight = 48.0f;
static const float mineIconWidth = 31.0f;
static const float resetButtonSize = 30.0f;
static const float infoPanelHorizontalConstraint = 15.0f;
static const float infoPanelVerticalConstraint = 10.0f;
static const float infoPanelWidgetWidth = 56.0f;

static const float digitViewHorizontalConstraint = 2.0f;
static const float digitViewVerticalConstraint = 2.5f;

static const int numberOfDifficulties = 3;

static const int beginnerBoardWidth = 9;
static const int beginnerBoardHeight = 9;
static const int beginnerMineAmount = 10;

static const float beginnerWindowWidth = beginnerBoardWidth * mineIconWidth;
static const float beginnerWindowHeight = beginnerBoardHeight * mineIconWidth + infoPanelHeight;

static const int intermediaBoardWidth = 16;
static const int intermediaBoardHeight = 15;
static const int intermediaMineAmount = 40;

static const float intermediaWindowWidth = intermediaBoardWidth * mineIconWidth;
static const float intermediaWindowHeight = intermediaBoardHeight * mineIconWidth + infoPanelHeight;

static const int hardBoardWidth = 32;
static const int hardBoardHeigth = 16;
static const int hardMineAmount = 99;

static const int modDividors[3] = {9,16,32};

static const float hardWindoWidth = hardBoardWidth * mineIconWidth;
static const float hardWindowHeight = hardBoardHeigth * mineIconWidth + infoPanelHeight;

static const NSString *recordDir = @"Library/Application Support/Records";
static const NSString *recordDB = @"gameRecords.db";

enum difficulty{
    difficultyBeginner,
    difficultyIntermedia,
    difficultyHard
};

enum gameStatus{
    idle,
    playing,
    win,
    lose
};
