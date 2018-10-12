//
//  DBManager.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/10.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "DBManager.h"
#import "FMDB/FMDB.h"
#import "queries.h"
#import "constants.h"
@interface DBManager(){
    FMDatabase *db;
}
@end
@implementation DBManager

- (id) init{
    self = [super init];
    if (self) {
        db =[FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),recordDir,recordDB]];
        if (![db open]){
            NSLog(@"fail to open db!");
        }
    }
    return self;
}

- (void) initTables{
    [db executeUpdate:create_table_Record];
    [db executeUpdate:create_table_difficulty];
    for (int i = 1; i <= numberOfDifficulties; i++ ){
        [db executeUpdate:insert_table_difficulty,[NSNumber numberWithInt:INT_MAX]];
    }
}

- (void) updateBestRecords:(int)record level:(int)l owner:(NSString *)name timeStamp:(NSString *)t{
    [db executeUpdate:insert_table_record,name,[NSNumber numberWithInt:record],t,[NSNumber numberWithInt:l+1]];
    [db executeUpdate:update_table_difficulty,[NSNumber numberWithInt:record],[NSNumber numberWithInt:l+1]];
}

- (int) getBestRecordForDifficulty:(int)level{
    FMResultSet *result = [db executeQuery:show_best_record_for_level,[NSNumber numberWithInt:level+1]];
    while([result next]) {
        return [result intForColumn:@"best_record"];
    }
    return INT_MAX;
}

- (NSDictionary *) getRecordsForDifficulty:(int)level {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *name = [NSMutableArray array];
    NSMutableArray *records  = [NSMutableArray array];
    NSMutableArray *time = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"%@%d%@",show_records_for_level,level,order_by_value]];
    while ([result next]) {
        [name addObject:[result stringForColumn:@"name"]];
        [records addObject:[NSNumber numberWithInt:[result intForColumn:@"value"]]];
        [time addObject:[result stringForColumn:@"time"]];
    }
    [dic setObject:name forKey:@"name"];
    [dic setObject:records forKey:@"records"];
    [dic setObject:time forKey:@"time"];
    return dic;
}




@end
