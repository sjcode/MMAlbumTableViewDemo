//
//  MyTableHeaderCell.m
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSimpleListCell.h"

@interface MMSimpleListCell(Private)
- (void)prepareTextAttributes;
- (void)drawStringCenterIn:(NSRect)r;
@end


@implementation MMSimpleListCell
@synthesize sortAscending;
- (id)initTextCell:(NSString *)aString
{
	if (self = [super initTextCell:aString]) 
	{
		divideLine = [NSImage imageNamed:@"icon_divide"];
		contentLine = [NSImage imageNamed:@"bg_content_divide"];
		ascendingArrow = [NSImage imageNamed:@"icon_ascending"];
		descendingArrow = [NSImage imageNamed:@"icon_descending"];
		sortAscending = YES; //default ascending
		
		[self prepareTextAttributes];
	}
	return self;
	
}

- (void)dealloc
{
	[super dealloc];
}

- (void)prepareTextAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	[attributes setObject:[NSFont fontWithName:@"Helvetica" size:18] forKey:NSFontAttributeName]; 
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
}

- (void)drawStringCenterIn:(NSRect)r
{
	NSSize strSize = [[self title] sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + 5;
	strOrigin.y = r.origin.y + (r.size.height - strSize.height) / 2;
	[[self title]drawAtPoint:strOrigin withAttributes:attributes];
}

- (void)drawWithFrame:(CGRect)cellFrame
          highlighted:(BOOL)isHighlighted
               inView:(NSView *)view
{
	
	/*
	CGRect fillRect, 
	borderRect;
	CGRectDivide(cellFrame, &borderRect, &fillRect, 1.0, CGRectMaxYEdge);
	
	NSGradient *gradient = [[NSGradient alloc]
							initWithStartingColor:[NSColor colorWithCalibratedRed:0.1490
																			green:0.1490 blue:0.1490 alpha:1.0]
							endingColor:[NSColor colorWithCalibratedRed:0.2078
																  green:0.2078 blue:0.2039 alpha:1.0]];
	[gradient drawInRect:fillRect angle:90.0];
	[gradient release];
	
	if (isHighlighted) {
		[[NSColor colorWithDeviceWhite:0.0 alpha:0.1] set];
		NSRectFillUsingOperation(fillRect, NSCompositeSourceOver);
	}
	
	[[NSColor colorWithDeviceWhite:0.8 alpha:1.0] set];
	NSRectFill(borderRect);
	
	[self setTextColor:[NSColor whiteColor]];
	
	[self drawInteriorWithFrame:fillRect inView:view];
	*/
	
	/*
	NSGradient *gradient = [[NSGradient alloc]
							initWithStartingColor:[NSColor colorWithCalibratedRed:0.1490
																			green:0.1490 blue:0.1490 alpha:1.0]
							endingColor:[NSColor colorWithCalibratedRed:0.2078
																  green:0.2078 blue:0.2039 alpha:1.0]];
	[gradient drawInRect:cellFrame angle:90.0];
	*/
	
	[[NSColor colorWithCalibratedRed:0.1490 green:0.1490 blue:0.1490 alpha:1.0]set];
	NSRectFill(cellFrame);
	
	[self drawStringCenterIn:cellFrame];
	
	if(cellFrame.origin.x>0)
	{
		NSRect divideRc;
		divideRc.origin.x = cellFrame.origin.x;
		//NSLog(@"divideRc.origin.x = %f",divideRc.origin.x);
		divideRc.origin.y = -2;
		divideRc.size.width = 1;
		divideRc.size.height = 38;
		[divideLine drawInRect:divideRc fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}

	if(needSort)
	{
		NSRect arrowRect = [self sortIndicatorRectForBounds: cellFrame];
		if(sortAscending)
		{
			[ascendingArrow drawInRect:arrowRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
		}
		else 
		{
			[descendingArrow drawInRect:arrowRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
		}
	}
	
	//if(sortAscending)
//	{
//		NSRect arrowRect = [self sortIndicatorRectForBounds: cellFrame];
//		NSBezierPath *arrow = [[NSBezierPath alloc] init];
//		NSPoint points[3];
//		
//		points[0] = NSMakePoint(NSMinX(arrowRect), NSMinY(arrowRect) +2);
//		points[1] = NSMakePoint(NSMaxX(arrowRect), NSMinY(arrowRect) +2);
//		points[2] = NSMakePoint(NSMidX(arrowRect), NSMaxY(arrowRect));
//		[arrow appendBezierPathWithPoints: points count: 3];
//		
//		[[NSColor whiteColor]set];
//		
//		[arrow fill];
//		[arrow release];
//	}
	
	
	
	NSRect rc = cellFrame;
	rc.origin.y = rc.size.height-2;
	rc.size.width = cellFrame.size.width;
	rc.size.height = contentLine.size.height;
	[contentLine drawInRect:rc fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	 
	//[gradient release];
}

- (void)drawWithFrame:(CGRect)cellFrame inView:(NSView *)view
{
	[self drawWithFrame:cellFrame highlighted:NO inView:view];
}

- (void)highlight:(BOOL)isHighlighted
        withFrame:(NSRect)cellFrame
           inView:(NSView *)view
{
	[self drawWithFrame:cellFrame highlighted:isHighlighted inView:view];
}

- (void)drawSortIndicatorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView ascending:(BOOL)ascending priority:(NSInteger)priority
{
	
}

- (void)setNeedSort:(BOOL)sort
{
	needSort = sort;
	sortAscending = !sortAscending;
	[(NSControl *)[self controlView] updateCell: self];
}

@end
