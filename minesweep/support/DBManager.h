//
//  DBManager.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/10.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject
- (void) initTables;

- (void) updateBestRecords:(int) record level:(int) l owner:(NSString *) name timeStamp:(NSString *)t;

- (int) getBestRecordForDifficulty:(int) level;

- (NSDictionary *) getRecordsForDifficulty:(int) level;
@end

NS_ASSUME_NONNULL_END
