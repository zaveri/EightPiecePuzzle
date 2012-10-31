//
//  MZGrid.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZGrid.h"
#import "UIFont+EightPiecePuzzleAdditions.h"

@implementation MZGrid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIFont colorWithHexString:@"95c9aa"];
    }
    return self;
}

-(void)populatePuzzleWithTiles:(NSMutableArray *)tiles andEmptyTile:(CGPoint)emptyTile
{
    NSMutableArray *tilesQueuedUp = [NSMutableArray arrayWithArray:tiles];
    
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
            
            CGPoint tempPosition = CGPointMake(row, col);
            
            if (CGPointEqualToPoint(tempPosition, emptyTile)) {
                continue;
            }
            
            MZTile *tile = nil;
            tile = [tilesQueuedUp objectAtIndex:0]; 
            [self addSubview:tile];
            [tile setNeedsDisplay];
            [self insertTile:tile atCurrentLocation:tile.currentLocation];
            [tilesQueuedUp removeObject:tile];
        }
    }
}


- (void)insertTile:(MZTile*)tile atCurrentLocation:(CGPoint)location
{
    //Frame details within the grid/puzzle
    
    CGFloat x = location.x * tile.frame.size.width;
    CGFloat y = location.y * tile.frame.size.height;
    tile.frame = CGRectMake(x, y, tile.frame.size.width, tile.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
