//
//  RecordViewWindow.m
//  minesweep
//
//  Created by Alan L  Hamilton on 2018/10/11.
//  Copyright © 2018 Alan L  Hamilton. All rights reserved.
//

#import "RecordViewWindow.h"
#import "ViewContorllerForTabView/RecordViewController.h"

@interface RecordViewWindow (){
    IBOutlet NSTabView *recordTabView;
    RecordViewController *recordTable;
}
@end

@implementation RecordViewWindow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [recordTabView setDelegate:self];
    NSString *identifier = [recordTabView selectedTabViewItem].identifier;
    recordTable = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    [recordTable setDifficulty:[self getDifficulty:identifier] + 1];
    [[recordTabView selectedTabViewItem] setView:recordTable.view];
    self.preferredContentSize = NSMakeSize(480,272);
   
}

- (void) tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem{
    NSString *identifier = tabViewItem.identifier;
    recordTable = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    [recordTable setDifficulty:[self getDifficulty:identifier] + 1];
    [tabViewItem setView:recordTable.view];
    
}

- (int) getDifficulty:(NSString *)identifier{
    if ([identifier isEqualToString:@"beginner"]){
        return 0;
    } else if ([identifier isEqualToString:@"intermedia"]) {
        return 1;
    } else if ([identifier isEqualToString:@"hard"]) {
        return 2;
    }
    return -1;
}

- (IBAction)dismissClicked:(NSButton *)sender {
    [self dismissController:self];
}

@end
