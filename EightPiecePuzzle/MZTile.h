//
//  MZTile.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    MoveLeft,
    MoveRight,
    MoveUP,
    MoveDown,
    NoMove
}TileDirection;

//fwd decleration
@class MZTile;

//delegate

@protocol MZTileDelegate <NSObject>

@required
-(void)tileTapped:(MZTile *)tile;

@end

typedef int (^ComputationBlock)(int);


@interface MZTile : UIView {
    
}

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) CGPoint currentLocation;
@property (nonatomic, assign) CGPoint originalLocation;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) id delegate;


-(BOOL)isInOriginalLocation;
- (void)moveTileWithDirection:(TileDirection)direction;
- (CGPoint)fetchOffset:(TileDirection)direction;

@end
