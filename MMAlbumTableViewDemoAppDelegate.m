//
//  MMAlbumTableViewDemoAppDelegate.m
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAlbumTableViewDemoAppDelegate.h"
#import "MMSimpleListCell.h"

#define MMKeySongName @"songname"
#define MMKeyAlbum @"album"
#define MMKeyArtistName @"artistname"
#define MMKeyPlays @"plays"
#define MMKeyDuration @"duration"

@implementation MMAlbumTableViewDemoAppDelegate

@synthesize window,mytableView,detailView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	// Insert code here to initialize your application 
	
	//[mytableView setBackgroundColor:[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490 alpha:1]];
	//[myScrollView setBorderType:NSNoBorder];
	//NSRect tableRc = [mytableView bounds];
	//NSTableHeaderView *tableHeaderView = [[NSTableHeaderView alloc] initWithFrame:NSMakeRect(0, 0, tableRc.size.width, 60)];
    //[mytableView setHeaderView:tableHeaderView];
	//[[mytableView headerView] setBackgroundColor:[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490 alpha:1]];
	//[mytableView setRowHeight:27];
	
	//myArray = [[NSMutableArray alloc]initWithObjects:@"",]

	[window makeKeyAndOrderFront:self];
}

- (IBAction)doubleClickTableView:(id)sender
{
	NSRunAlertPanel(@"MediaManager", @"doubleClickTableView", nil, nil, nil);

}

- (void)awakeFromNib
{
    _tableContents = [[NSMutableArray alloc]init];
    [self willChangeValueForKey:@"_tableContents"];
    [_tableContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"test song1",MMKeySongName,
                               @"my album1",MMKeyAlbum,
                                @"artist1",MMKeyArtistName,
                               [NSNumber numberWithInt:1],MMKeyPlays,
                              [NSNumber numberWithInt:1],MMKeyDuration,
                               nil]];
    [_tableContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"test song2",MMKeySongName,
                               @"my album2",MMKeyAlbum,
                               @"artist2",MMKeyArtistName,
                               [NSNumber numberWithInt:2],MMKeyPlays,
                              [NSNumber numberWithInt:1],MMKeyDuration,
                               nil]];
    [_tableContents addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"test song3",MMKeySongName,
                               @"my album3",MMKeyAlbum,
                               @"artist3",MMKeyArtistName,
                               [NSNumber numberWithInt:3],MMKeyPlays,
                               [NSNumber numberWithInt:1],MMKeyDuration,
                               nil]];
   
    [self didChangeValueForKey:@"_tableContents"];
    
	[window setBackgroundColor:[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490 alpha:1]];
	myArray = [[NSMutableArray alloc]init];
	detailListArray = [[NSMutableArray alloc]init];
	
	self.detailView.dataSource = self;
	self.detailView.delegate = self;
	/*
	for(NSView * subview in [myScrollView subviews])
	{          
		for(NSView * subSubView in [subview subviews])
		{
			if([[subSubView  className] isEqualToString:@"NSTableHeaderView"] &&  [[subview className] isEqualToString:@"NSClipView"])
			{
				[subSubView setFrameSize:NSMakeSize(subSubView.frame.size.width, subSubView.frame.size.height+20)];//HeaderView Frame
				[subview setFrameSize:NSMakeSize(subview.frame.size.width, subview.frame.size.height+20)];//ClipView Frame
			}
			
		}
		if ([[subview className] isEqualToString:@"_NSCornerView"])
		{
			[subview setFrameSize:NSMakeSize(subview.frame.size.width, subview.frame.size.height+5)]; //CornerView Frame
		}
	}*/
	
	//[mytableView setDoubleAction:@selector(doubleClickTableView:)];
}
 
- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [myArray count];
}

- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColume row:(int)row
{
	id theRecord, theValue;
	theRecord = [myArray objectAtIndex:row];
	theValue = [theRecord objectForKey:[tableColume identifier]];
	return theValue;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	//点击row
	NSLog(@"");
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	//设置row的文字颜色为白色
	if ([cell isKindOfClass:[NSTextFieldCell class]]) 
	{
		[cell setTextColor: [NSColor whiteColor]];
	}
}

- (void)sortWithDescriptor:(id)descriptor
{
	NSMutableArray *sorted = [[NSMutableArray alloc] initWithCapacity:1];
	[sorted addObjectsFromArray:[myArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]]];
	[myArray removeAllObjects];
	[myArray addObjectsFromArray:sorted];
	[mytableView reloadData];
	[sorted release];
}

- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn 
{	
	NSArray *allColumns=[mytableView tableColumns];
	NSInteger i;
	//遍历所有的列信息
	for (i=0; i<[mytableView numberOfColumns]; i++) 
	{
		NSTableColumn *column = [allColumns objectAtIndex:i];
		if (column!=tableColumn)
		{
			//移除非排序的列上的排序图片
			[(MMSimpleListCell*)[column headerCell] setNeedSort:NO];
		}
		else 
		{
			//设置排序列上的排序图片
			[(MMSimpleListCell*)[column headerCell] setNeedSort:YES];
			BOOL bAscending = [(MMSimpleListCell*)[column headerCell] sortAscending];
			if(bAscending)
			{
				//升序
				NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:[tableColumn identifier] ascending:YES];
				[self sortWithDescriptor:sortDesc];
				[sortDesc release];
			}
			else 
			{	
				//降序
				NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:[tableColumn identifier] ascending:NO];
				[self sortWithDescriptor:sortDesc];
				[sortDesc release];
			}
		}
	}
	//[mytableView setHighlightedTableColumn:tableColumn];  //设置column高亮,触发MyTableHeaderCell::highlight函数,来绘制高亮
}

- (IBAction)addNewRecord:(id)sender
{
	//为表里填加一条记录
    
    
    
    
	NSMutableDictionary *record = [[NSMutableDictionary alloc] init];
	recordcount++;
	[record setObject:[NSString stringWithFormat:@"songname%03d",recordcount] forKey:@"songname"];
	[record setObject:[NSString stringWithFormat:@"albumname%03d",recordcount ] forKey:@"album"];
	[record setObject:[NSString stringWithFormat:@"artistname%03d",recordcount] forKey:@"artistname"];
	[record setObject:[NSNumber numberWithInt:recordcount] forKey:@"plays"];
	[record setObject:[NSNumber numberWithInt:240] forKey:@"duration"]; 
	//[myArray addObject:record];
    [self willChangeValueForKey:@"_tableContents"];
    [_tableContents addObject:record];
    [self didChangeValueForKey:@"_tableContents"];
	//[mytableView reloadData];
}

- (IBAction)deleteRecord:(id)sender
{
	//删除一条记录
	
}

#pragma mark -MMDetailListContentView
- (int)numberOfRowsInListView:(MMDetailListContentView *)v
{
	return [detailListArray count];
}

- (id)detailListContentView:(MMDetailListContentView *)v row:(int)row
{
	NSInteger count = [detailListArray count];
	if(count == 0)
		return nil;
	id customData = [detailListArray objectAtIndex:row];
	if(customData)
		return customData;
	return nil;
}

- (IBAction)addNewAlbum:(id)sender
{
	albumcount++;
	NSImage *image = [NSImage imageNamed:@"icon_music_thumbnail"];
	NSString *name = [NSString stringWithFormat:@"songname%03d",albumcount];
	NSString *album = [NSString stringWithFormat:@"album%03d",albumcount];
	NSNumber *duration = [[NSNumber alloc] initWithInt:4*60];

	NSMutableDictionary *customData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									   image,kCustomCellImageDataKey,
									   name,kCustomCellNameDataKey,
									   album,kCustomCellAlbumDataKey,
									   duration,kCustomCellDurationKey,nil];
	
	[detailListArray addObject:customData];
	[duration release];
	[detailView reloadData];
}

- (IBAction)deleteAlbum:(id)sender
{

}

@end
