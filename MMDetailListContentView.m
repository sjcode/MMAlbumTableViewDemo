//
//  MMDetailListContentView.m
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMDetailListContentView.h"

NSString * const kCustomCellImageDataKey = @"imageData";
NSString * const kCustomCellNameDataKey = @"nameData";
NSString * const kCustomCellAlbumDataKey = @"albumDataKey";
NSString * const kCustomCellDurationKey = @"DurationKey";

@interface MMDetailListContentView(Private)
- (void)layoutList;
@end

@implementation MMDetailListContentView
@synthesize dataSource,delegate;
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) 
	{
		NSRect bounds = [self bounds];
		detailListView = [[MMDetailListView alloc] initWithFrame:bounds];
		[detailListView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		
		scrollView = [[NSScrollView alloc]initWithFrame:bounds];
		[scrollView setDrawsBackground:NO];
		[scrollView setBorderType:NSNoBorder];
		[scrollView setAutohidesScrollers:YES];
		[scrollView setHasVerticalScroller:YES];
		[scrollView setHasHorizontalScroller:NO];
		[scrollView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		
		[[scrollView contentView] setAutoresizesSubviews:YES];
		[[scrollView verticalScroller] setControlSize:NSSmallControlSize];
		[[scrollView verticalScroller] setArrowsPosition:NSScrollerArrowsNone];
		[[scrollView contentView] setAutoresizesSubviews:YES];
		
		[self addSubview:scrollView];
		[scrollView setDocumentView:detailListView];
		[scrollView release];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:) name:NSViewFrameDidChangeNotification object:detailListView];
    }
    return self;
}

- (void)mainWindowChanged:(NSNotification *)notification
{
	[self layoutList];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (void)reloadData
{
	NSInteger count = 0;
	if(dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInListView:)])
	{
		count = [self.dataSource numberOfRowsInListView:self];
	}
	
	if(count==0)
		return;
	
	if(dataSource && [self.dataSource respondsToSelector:@selector(detailListContentView:row:)])
	{
		NSMutableArray *viewToRemove = [[NSMutableArray alloc]init];
		NSArray *subviews = [detailListView subviews];
		for(NSView *view in subviews)
		{
			[viewToRemove addObject:view];
		}
		[viewToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[viewToRemove release];
		for(int i = 0; i < count; i++)
		{
			NSMutableDictionary *customData = [self.dataSource detailListContentView:self row:i];
			if(customData)
			{
				NSImage *image;
				NSString *name,*album;
				NSNumber *duration;
				image = [customData objectForKey:kCustomCellImageDataKey];
				name = [customData objectForKey:kCustomCellNameDataKey];
				album = [customData objectForKey:kCustomCellAlbumDataKey];
				duration = [customData objectForKey:kCustomCellDurationKey];
				
				NSViewController *cellControl = [[NSViewController alloc] initWithNibName:@"MMDetailListCell" bundle:nil];
				if(cellControl)
				{
					MMDetailListCell *cell = (MMDetailListCell *)[cellControl view];
					[cell setAutoresizingMask:(NSViewMaxXMargin|NSViewMinYMargin)];
					
					[cell.name setStringValue:name];
					[cell.album setStringValue:album];
					[cell.duration setStringValue:[NSString stringWithFormat:@"%d",[duration intValue]]];
					[cell setAutoresizingMask:(NSViewMaxXMargin|NSViewMinYMargin)];
					[cell setImage:image];
				
					[detailListView addSubview:cell];
				}
			}
		}
	}
	[self layoutList];
}

- (void)layoutList
{
	NSArray *subViews = [detailListView subviews];
	if([subViews count] == 0)
		return;
	
	int count = [subViews count];
	if([detailListView bounds].size.height< 83 * count)
	{
		[detailListView setFrame:NSMakeRect(0, 0, [detailListView bounds].size.width, 83 * count)];
		[detailListView setNeedsDisplay:YES];
	}
	
	int origin_x = 0;
	int origin_y = 0;
	
	for(NSView * view in subViews)
	{
		[view setFrame:NSMakeRect(origin_x, origin_y, [detailListView bounds].size.width, [view bounds].size.height)];
		origin_y += [view bounds].size.height;
	}
	
}

@end
