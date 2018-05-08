//
//  MMDetailListCell.h
//  MMAlbumTableViewDemo
//
//  Created by Arthur on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MMDetailListCell : NSView 
{
	IBOutlet NSImageView *imageView;
	IBOutlet NSTextField *name;
	IBOutlet NSTextField *album;
	IBOutlet NSTextField *duration;
    IBOutlet NSScrollView *scrollView;
	NSImage *divideLine;
	BOOL bHeighLight;
    NSArrayController *arrayController;
    NSMutableArray *tableContent;
}

@property (nonatomic,retain) NSTextField *name;
@property (nonatomic,retain) NSTextField *album;
@property (nonatomic,retain) NSTextField *duration;

- (void)setImage:(NSImage *)image;
- (void)heighLight:(BOOL)b;
@end
