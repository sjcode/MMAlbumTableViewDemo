//
//  MMDetailListCell.m
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMDetailListCell.h"


@implementation MMDetailListCell
@synthesize name,album,duration;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        divideLine = [NSImage imageNamed:@"bg_content_divide"];
        
        arrayController = [[NSArrayController alloc]init];
        tableContent = [[NSMutableArray alloc]init];
//        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                                NSConditionallySetsEditableBindingOption, [NSNumber numberWithBool:YES],
//                                 NSRaisesForNotApplicableKeysBindingOption,[NSNumber numberWithBool:YES],
//                                 nil];
        [arrayController bind:@"contentArray" toObject:self withKeyPath:@"tableContent" options:nil];
        [self willChangeValueForKey:@"tableContent"];
        [tableContent addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"songname", @"song",nil]];
        [self didChangeValueForKey:@"tableContent"];
    }
    return self;
}



- (void)drawRect:(NSRect)dirtyRect 
{
	[[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f] set];
	NSRectFill(dirtyRect);
	
	NSRect bounds = [self bounds];
	NSRect lineRc;
	lineRc.origin.x = 0;
	lineRc.origin.y = 2;
	lineRc.size.width = bounds.size.width;
	lineRc.size.height = 2;
	[divideLine drawInRect:lineRc fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	if(bHeighLight)
	{
		[[NSColor colorWithDeviceRed:0.5843f green:0.7961f blue:0.3020f alpha:1.0f]set];
		NSRectFill(dirtyRect); 
	}
}

- (void)setImage:(NSImage *)img
{
	if(img)
	{
		[imageView setImage:img];
		[img release];
	}
}

- (void)heighLight:(BOOL)b
{
	if(bHeighLight != b)
	{
		bHeighLight = b;
		[self setNeedsDisplay:YES];
	}
}


//- (void)mouseEntered:(NSEvent *)theEvent
//{
//	NSLog(@"mouseEnter = %@",self.name);
//	bMoveEntered = YES;
//	[self setNeedsDisplay:YES];
//}
//
//- (void)mouseExited:(NSEvent *)theEvent
//{
//	NSLog(@"mouseExit = %@",self.name);
//	bMoveEntered = NO;
//	[self setNeedsDisplay:YES];
//}
//
//- (void)mouseMoved:(NSEvent *)theEvent
//{
//	//NSLog(@"mouseMoved = %@",self.name);
//}

@end
