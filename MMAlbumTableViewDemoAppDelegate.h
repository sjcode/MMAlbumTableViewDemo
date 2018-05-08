//
//  MMAlbumTableViewDemoAppDelegate.h
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMDetailListContentView.h"

@interface MMAlbumTableViewDemoAppDelegate : NSObject <NSApplicationDelegate,MMDetailListContentViewDataSource,MMDetailListContentViewDelegate> 
{
    NSWindow *window;
	NSMutableArray *myArray;
	NSMutableArray *detailListArray;
	NSInteger recordcount;
	NSInteger albumcount;
   // IBOutlet NSArrayController *dataArrayController;
    NSMutableArray *_tableContents;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *mytableView;
@property (assign) IBOutlet MMDetailListContentView *detailView;

- (IBAction)addNewRecord:(id)sender;
- (IBAction)deleteRecord:(id)sender;

- (IBAction)addNewAlbum:(id)sender;
- (IBAction)deleteAlbum:(id)sender;

- (IBAction)doubleClickTableView:(id)sender;

@end
