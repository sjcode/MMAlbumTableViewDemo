//
//  MyTableView.m
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSimpleListView.h"
#import "MMSimpleListCell.h"

/*
@implementation NSTableHeaderCell (VBNSTableHeaderCell)

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	
    NSGradient *grayGradient = [[NSGradient alloc] initWithColorsAndLocations: [NSColor colorWithCalibratedRed:0.1490
																										 green:0.1490 blue:0.1490 alpha:1.0], 0.1,
                                 nil];
    [grayGradient drawInRect:cellFrame angle:90];
    [[self stringValue] drawInRect:cellFrame withAttributes:nil];
}
@end
*/
@implementation MMSimpleListView

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder: aDecoder]; 
	
	if(self) {
		
		//Setup Header Cells
		NSEnumerator*   aEnumerator;
		NSTableColumn*  aColumn;
		
		aEnumerator = [[self tableColumns] objectEnumerator];
		
		while (aColumn = [aEnumerator nextObject]) 
		{
			id cell = [aColumn headerCell];
			if([cell class]== [NSTableHeaderCell class]) 
			{
				MMSimpleListCell *newHeader = [[MMSimpleListCell alloc] initTextCell: [cell title]];
				[newHeader setFont:[NSFont fontWithName:@"微软雅黑" size:8]];
				[aColumn setHeaderCell: newHeader];
				[newHeader release];
			} else {
			}
		}
        self.backgroundColor = [NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f];
	}
	
	return self;
}

- (void)awakeFromNib
{
	//加载nib后,需要调整NSTableHeaderView的高度为32
	NSRect rc = [self bounds];
	NSTableHeaderView *tableHeaderView = [[NSTableHeaderView alloc] initWithFrame:NSMakeRect(0, 0, rc.size.width, 32)];
    [self setHeaderView:tableHeaderView];
}

- (void)highlightSelectionInClipRect:(NSRect)clipRect
{
	//绘制双色row
	NSColor *evenColor   // empirically determined color, matches iTunes etc.
	= [NSColor colorWithCalibratedRed:0.1490
								green:0.1490 blue:0.1490 alpha:1.0];
	NSColor *oddColor  = [NSColor colorWithCalibratedRed:0.2078
												   green:0.2078 blue:0.2039 alpha:1.0];
	
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

- (void)keyDown:(NSEvent *)theEvent
{
	//检查委托对象是否实现 numberOfRowsInTableView
	if([self dataSource] && [[self dataSource] respondsToSelector:@selector(numberOfRowsInTableView:)])
	{
		//如果记录为0,就返回
		if([[self dataSource] numberOfRowsInTableView:self] == 0)
			return;
	}
	else 
	{
		//未实现也返回
		return;
	}
	
	unsigned short code = [theEvent keyCode];
	switch (code) 
	{
		case 125://arrowdown
			{
				NSInteger recordCount = [[self dataSource] numberOfRowsInTableView:self];
				NSInteger row = [self selectedRow];
				if(row == -1)//没有选中的
				{
					//从第一条记录开始
					recordCount = [[self dataSource] numberOfRowsInTableView:self];
					NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
					//模拟选择一条记录
					[self selectRowIndexes:indexSet byExtendingSelection:NO];
					[self scrollRowToVisible:0];
				}
				else if(row >= 0 && row<recordCount-1) 
				{		
					NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:row+1];
					//模拟选择一条记录
					[self selectRowIndexes:indexSet byExtendingSelection:NO];
					[self scrollRowToVisible:row+1];
				}
				else 
				{
					//选的是最后一条记录,什么也别做
				}
			}
			break;
		case 126: //arrowup
			{
				NSInteger recordCount;
				NSInteger row = [self selectedRow];
				if(row == -1)//没有选中的
				{
					//从最后一条记录开始
					recordCount = [[self dataSource] numberOfRowsInTableView:self];
					NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:recordCount-1];
					//模拟选择一条记录
					[self selectRowIndexes:indexSet byExtendingSelection:NO];
					[self scrollRowToVisible:recordCount-1];
				}
				else if(row > 0) 
				{		
					NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:row-1];
					//模拟选择一条记录
					[self selectRowIndexes:indexSet byExtendingSelection:NO];
					[self scrollRowToVisible:row-1];
				}
				else 
				{
					//选的是第一条记录,什么也别做
				}
				
			}
			break;
		default:
			break;
	}
}

- (IBAction)menuItem1Action:(id)sender
{
	NSLog(@"menuItem1Action [%d]",[sender tag]);
}

- (NSMenu*)menuForRightMouseDownEvent 
{
	//返回一个菜单
    NSMenu* newMenu = [[[NSMenu alloc] initWithTitle:@"Custom"]autorelease];
	
	NSMenuItem* item = [newMenu addItemWithTitle:@"Menu Item# 1" action:@selector(menuItem1Action:) keyEquivalent:@""];
    [item setTag:1];
	
	item = [newMenu addItemWithTitle:@"Menu Item# 2" action:@selector(menuItem1Action:) keyEquivalent:@""];
    [item setTag:2];
	
	item = [newMenu addItemWithTitle:@"Menu Item# 3" action:@selector(menuItem1Action:) keyEquivalent:@""];
    [item setTag:3];
	
	return newMenu;
}

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
	if ([theEvent type] == NSRightMouseDown)//检查是否是单击右键
	{
		NSPoint clickPt = [self convertPoint:[theEvent locationInWindow] fromView:nil];//取回单击坐标
		NSInteger row = [self rowAtPoint:clickPt];//通过pt返回row index
		if(row != -1)
		{
			NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:row];//单击右键也算选中,并高亮
			//模拟选择一条记录
			[self selectRowIndexes:indexSet byExtendingSelection:NO];
			return [self menuForRightMouseDownEvent];
		}
	}
	return nil;
}

@end
