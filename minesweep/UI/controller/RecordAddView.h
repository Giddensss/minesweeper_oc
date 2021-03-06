//
//  RecordAddView.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/11.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordAddView : NSViewController
- (void) setupRecordInformation:(int) record difficulty:(int) difficulty;
@end

NS_ASSUME_NONNULL_END
