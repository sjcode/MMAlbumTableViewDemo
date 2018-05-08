//
//  MyTableHeaderCell.h
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MMSimpleListCell : NSTableHeaderCell 
{
	NSImage *divideLine;
	NSImage *contentLine;
	NSImage *ascendingArrow;
	NSImage *descendingArrow;
	int sortPriority;
	BOOL sortAscending;
	BOOL needSort;
	NSMutableDictionary *attributes;
}
@property (assign) BOOL sortAscending;
- (void)setNeedSort:(BOOL)sort;
@end
