//
//  MZGrid.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTile.h"

@interface MZGrid : UIView {
    
}

- (id)initWithFrame:(CGRect)frame;

- (void)populatePuzzleWithTiles:(NSMutableArray *)tiles andEmptyTile:(CGPoint)emptyTile;
- (void)insertTile:(MZTile*)tile atCurrentLocation:(CGPoint)location;

@end
