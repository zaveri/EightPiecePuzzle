//
//  MZTile.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZTile.h"
#import "UIFont+EightPiecePuzzleAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation MZTile

@synthesize number = _number;
@synthesize currentLocation = _currentLocation;
@synthesize originalLocation = _originalLocation;
@synthesize numberLabel = _numberLabel;
@synthesize delegate =_delegate;

//Tile Details
#define TILE_WIDTH 100.0f
#define TILE_HEIGHT 100.0f

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIFont colorWithHexString:@"52446b"]];
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 30)/2, (self.frame.size.height - 30)/2, 30, 30)];
        [self setNumberLabel:numberLabel];
        [self.numberLabel setFont:[UIFont boldCrunchFontOfSize:40.0f]];
        [self.numberLabel setTextColor:[UIFont colorWithHexString:@"a596c8"]];
        [self.numberLabel setBackgroundColor:[UIColor clearColor]];
        self.numberLabel.shadowColor = [UIFont colorWithHexString:@"655483"];
        self.numberLabel.shadowOffset = CGSizeMake(0.5,0.5);
        [self addSubview:self.numberLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveTile:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)moveTile:(UITapGestureRecognizer *)recognizer
{
    [self.delegate tileTapped:self];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIFont colorWithHexString:@"95c9aa"]set];
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeRect(context, rect);
}


- (BOOL)isInOriginalLocation
{
    if (CGPointEqualToPoint(self.currentLocation, self.originalLocation)){
        return YES;
    }else {
        return NO;
    }
}

- (void)moveTileWithDirection:(TileDirection)direction
{
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint offset = [self fetchOffset:direction];
        
        
        CGPoint newCenter = CGPointMake((self.currentLocation.x * TILE_WIDTH) + (TILE_WIDTH * .5), 
                                        (self.currentLocation.y * TILE_HEIGHT) + (TILE_HEIGHT * .5));
        newCenter.x += (offset.x * TILE_WIDTH);
        newCenter.y += (offset.y * TILE_HEIGHT);
        self.center = newCenter;
    }];
    
}

- (CGPoint)fetchOffset:(TileDirection)direction
{
    switch (direction) {
        case MoveLeft:
            return CGPointMake(-1, 0);
            break;
        case MoveRight:
            return CGPointMake(1, 0);
            break;
        case MoveUP:
            return CGPointMake(0, -1);
            break;
        case MoveDown:
            return CGPointMake(0, 1);
            break;
        case NoMove:
        default:
            break;
    }
    
    return CGPointMake(0, 0);
}

@end
