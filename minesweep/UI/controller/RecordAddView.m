//
//  RecordAddView.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/11.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "RecordAddView.h"
#import "../../AppDelegate.h"

@interface RecordAddView () {
    AppDelegate *myDelegate;
    IBOutlet NSTextField *recordDesciption;
    IBOutlet NSTextField *nameTextField;
    int record;
    int difficulty;
}
@end

@implementation RecordAddView

- (id) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        myDelegate = [NSApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.preferredContentSize = NSMakeSize(480,272);
}

- (void) setupRecordInformation:(int)r difficulty:(int)d {
    record = r;
    difficulty = d;
    NSString *description = [NSString stringWithFormat:@"%d seconds is the NEW RECORD on %@ level!",record,[self getDifficultyInString:difficulty]];
    recordDesciption.stringValue = description;
   
}

- (NSString *) getDifficultyInString:(int) difficulty {
    switch (difficulty) {
        case 0:
            return @"Beginner";
        case 1:
            return @"Intermedia";
        case 2:
            return @"Hard";
        default:
            return @"";
    }
}

- (IBAction)addClicked:(NSButton *)sender {
    NSString *name = nameTextField.stringValue;
    if ([name isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Warning!"];
        [alert setInformativeText:@"You cannot leave your NAME blank!"];
        [alert addButtonWithTitle:@"Ok, I'll tell you who I am."];
        [alert setIcon:[NSImage imageNamed:@"icon"]];
        [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:nil];
    } else {
        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
        NSString *date =  [formatter stringFromDate:[NSDate date]];
        NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
        [myDelegate updateRecord:record owner:name time:timeLocal difficulty:difficulty];
        [self dismissController:self];
    }
}
- (IBAction)dismissClicked:(NSButton *)sender {
    [self dismissController:self];
}

@end
