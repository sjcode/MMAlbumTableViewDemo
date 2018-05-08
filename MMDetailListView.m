//
//  MMDetailListView.m
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMDetailListView.h"
#import "MMDetailListCell.h"

@implementation MMDetailListView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        divideLine = [NSImage imageNamed:@"bg_content_divide"];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect 
{
	[[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f] set];
	NSRectFill(dirtyRect);
}

- (BOOL)isFlipped
{
	return YES;
}

- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint eyeCenter = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSArray *subviews = [self subviews];
	
	for(NSView * cell in subviews)
	{
		if(cell)
		{
			NSRect viewFrame;
			viewFrame = [cell frame];
			[((MMDetailListCell*)cell) heighLight:[self mouse:eyeCenter inRect:viewFrame]];
		}
	}
}

@end
