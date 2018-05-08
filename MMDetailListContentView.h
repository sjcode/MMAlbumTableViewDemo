//
//  MMDetailListContentView.h
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMDetailListView.h"
#import "MMDetailListCell.h"

extern NSString * const kCustomCellImageDataKey;
extern NSString * const kCustomCellNameDataKey;
extern NSString * const kCustomCellAlbumDataKey;
extern NSString * const kCustomCellDurationKey;

@protocol MMDetailListContentViewDataSource;
@protocol MMDetailListContentViewDelegate;

@interface MMDetailListContentView : NSView 
{
	NSScrollView *scrollView;
	MMDetailListView *detailListView;
	id<MMDetailListContentViewDataSource> dataSource;
	id<MMDetailListContentViewDelegate> delegate;
}

@property (retain) id dataSource;
@property (retain) id delegate;

- (void)reloadData;

@end

@protocol MMDetailListContentViewDataSource
- (int)numberOfRowsInListView:(MMDetailListContentView *)v;
- (id)detailListContentView:(MMDetailListContentView *)v row:(int)row;
@end

@protocol MMDetailListContentViewDelegate

//- (void)needPlayAlbum:(NSInteger)row;


@end
