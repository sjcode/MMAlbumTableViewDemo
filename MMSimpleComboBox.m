//
//  MMSimpleComboBox.m
//  MediaManager
//
//  Created by Arthur on 8/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSimpleComboBox.h"


@implementation MMSimpleComboBox

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if(self)
    {
        self.backgroundColor = [NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f];
    }
    
    return self;
}

- (void)highlightSelectionInClipRect:(NSRect)clipRect
{
	//绘制双色row
	NSColor *evenColor   // empirically determined color, matches iTunes etc.
	= [NSColor colorWithDeviceWhite:0.15f alpha:1.0f];
	NSColor *oddColor  = [NSColor colorWithDeviceRed:0.1961
											   green:0.1922 blue:0.1922 alpha:1.0];
	
	float rowHeight
	= [self rowHeight] + [self intercellSpacing].height;
	NSRect visibleRect = [self visibleRect];
	NSRect highlightRect;
	
	highlightRect.origin = NSMakePoint(
									   NSMinX(visibleRect),
									   (int)(NSMinY(clipRect)/rowHeight)*rowHeight);
	highlightRect.size = NSMakeSize(
									NSWidth(visibleRect),
									rowHeight - [self intercellSpacing].height+2);
	
	while (NSMinY(highlightRect) < NSMaxY(clipRect))
	{
		NSRect clippedHighlightRect
		= NSIntersectionRect(highlightRect, clipRect);
		int row = (int)
		((NSMinY(highlightRect)+rowHeight/2.0)/rowHeight);
		NSColor *rowColor
		= (0 == row % 2) ? evenColor : oddColor;
		[rowColor set];
		NSRectFill(clippedHighlightRect);
		highlightRect.origin.y += rowHeight;
	}
	
	[super highlightSelectionInClipRect: clipRect];
}

- (BOOL)acceptsFirstResponder
{
	//接受foucs,如果不想带蓝色毛边,需要把tableview的fousc ring设置为none
    return YES;
}

- (void)_manuallyDrawSourceListHighlightInRect:(NSRect)rect isButtedUpRow:(BOOL)flag 
{
	//绘制高亮row
	[[NSColor colorWithDeviceRed:0.5843f green:0.7961f blue:0.3020f alpha:1.0f]set];
	NSRectFill(rect);
}

- (BOOL)_manuallyDrawSourceListHighlight 
{
	//允许自绘SourceListHightLight ,IB里的Highlight为sourcelist
	return YES;
}


@end
