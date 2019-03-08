//
//  queries.h
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/10.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#ifndef queries_h
#define queries_h

NSString *create_table_Record = @"CREATE TABLE IF NOT EXISTS Records (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value integer, time text, difficulty interger)";
NSString *create_table_difficulty = @"CREATE TABLE IF NOT EXISTS Difficulty (level INTEGER PRIMARY KEY AUTOINCREMENT, best_record integer)";
NSString *insert_table_difficulty = @"INSERT INTO Difficulty (best_record) VALUES (?)";
NSString *insert_table_record = @"INSERT INTO Records (name, value, time, difficulty) VALUES (?,?,?,?)";
NSString *update_table_difficulty = @"UPDATE Difficulty SET best_record= ? WHERE level= ?";
NSString *show_best_records = @"SELECT level, best_record FROM Difficulty";
NSString *show_best_record_for_level = @"SELECT best_record FROM Difficulty WHERE level= ?";
NSString *show_records_for_level = @"SELECT name, value, time FROM Records WHERE difficulty= ";
NSString *order_by_value = @" ORDER BY value";
#endif /* queries_h */

