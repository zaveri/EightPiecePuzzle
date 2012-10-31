//
//  MZFirstViewController.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZGrid.h"
#import "MZTile.h"
#import "MZScore.h"

@interface MZFirstViewController : UIViewController  <MZTileDelegate, UIAlertViewDelegate, UIAccelerometerDelegate> {
    
}

@property(nonatomic, strong) MZGrid *gridView;
@property(nonatomic, strong) NSMutableArray *tiles;
@property(nonatomic, strong) UIButton *shuffleButton;
@property(nonatomic, strong) UILabel *scoreLabel;
@property(nonatomic, assign) NSInteger score;
@property(nonatomic, assign) CGPoint emptyTilePosition;
@property(nonatomic, assign) BOOL isShufflin;



@end
