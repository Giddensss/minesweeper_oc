//
//  RecordViewController.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/11.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "RecordViewController.h"
#import "../../../AppDelegate.h"
@interface RecordViewController () {
    
    IBOutlet NSTableView *RecordTable;
    int difficulty;
    NSDictionary *records;
    NSArray *name;
    NSArray *record;
    NSArray *time;
    AppDelegate *myDelegate;
}
@end

@implementation RecordViewController

- (id) initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myDelegate = [NSApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [RecordTable setDelegate:self];
    [RecordTable setDataSource:self];
    [RecordTable reloadData];
}

- (void) setDifficulty:(int)d{
    difficulty = d;
    records = [myDelegate showRecordsForDifficulty:difficulty];
    name = [records objectForKey:@"name"];
    record = [records objectForKey:@"records"];
    time = [records objectForKey:@"time"];
    
}


#pragma tabel delegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return ((NSArray *)[records objectForKey:@"name"]).count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString *identifier = [tableColumn identifier];
    NSTableCellView *view = [tableView makeViewWithIdentifier:identifier owner:self];
    if(view == nil){
        NSTableCellView *view = [[NSTableCellView alloc]initWithFrame:NSMakeRect(0, 0, 100, 30)];
        view.identifier = [tableColumn identifier];
        NSTextField *textfield = [[NSTextField alloc] initWithFrame:NSInsetRect(view.frame, 2, 2)];
        textfield.autoresizingMask = NSViewMaxXMargin | NSViewMinYMargin; //changed to autoresizing
        textfield.backgroundColor = [NSColor redColor];
        [textfield setEditable:NO];
        [view addSubview:textfield];
        view.textField = textfield;
    }
    if ([identifier isEqualToString:@"owner"]){
        view.textField.stringValue = name[row];
    }else if ([identifier isEqualToString:@"record"]){
        view.textField.stringValue = record[row];
    }else if ([identifier isEqualToString:@"time"]){
        view.textField.stringValue = time[row];
    }
    return view;
}

@end
