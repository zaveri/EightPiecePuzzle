//
//  MZFirstViewController.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZFirstViewController.h"
#import "UIFont+EightPiecePuzzleAdditions.h"
#import "UILabel+EightPiecePuzzleAdditions.h"
#import "MZCoreDataManager.h"

@interface MZFirstViewController ()

@end

@implementation MZFirstViewController

@synthesize gridView = _gridView;
@synthesize tiles = _tiles;
@synthesize emptyTilePosition = _emptyTilePosition;
@synthesize isShufflin = _isShufflin;
@synthesize shuffleButton = _shuffleButton;
@synthesize score = _score;
@synthesize scoreLabel = _scoreLabel;

#define GRID_WIDTH 300.0f
#define GRID_HEIGHT 300.0f

// Puzzle Specs
#define GRID_ROWS 3
#define GRID_COLUMNS 3
#define TOTAL_TILES 8
#define EMPTY_SPACES 1

//Tile Details
#define TILE_WIDTH 100.0f
#define TILE_HEIGHT 100.0f

#define SHUFFLE_ITERATIONS 100

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float viewWidth = self.view.frame.size.width;
    //    float viewHeight = self.view.frame.size.height;
    
    NSMutableArray *tiles = [[NSMutableArray alloc] init];
    [self setTiles:tiles];
    
    MZGrid *gridView = [[MZGrid alloc] initWithFrame:CGRectMake((viewWidth - GRID_WIDTH)/2, 10, GRID_WIDTH, GRID_HEIGHT)];
    self.gridView = gridView;
    [self.view addSubview:gridView];
    
    
    UIButton *shuffleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self setShuffleButton:shuffleButton];
    [self.shuffleButton setFrame:CGRectMake(20, 330, 100, 40)];
    [self.shuffleButton setTitle:@"Shuffle" forState:UIControlStateNormal];
    [self.shuffleButton setEnabled:YES];
    [self.shuffleButton addTarget:self action:@selector(shuffleButtonToggeled:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shuffleButton];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake((viewWidth - 30)/2, 330, 70, 40)];
    [self setScoreLabel:scoreLabel];
    [self.scoreLabel setFont:[UIFont boldCrunchFontOfSize:40.0f]];
    [self.scoreLabel setTextColor:[UIFont colorWithHexString:@"a596c8"]];
    [self.scoreLabel setBackgroundColor:[UIColor clearColor]];
    [self.scoreLabel updateLabel:self.score];
    [self.view addSubview:self.scoreLabel];
    
    self.emptyTilePosition = CGPointMake(2, 2);
    [self setupPuzzle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



#pragma mark
#pragma mark Setup Puzzle

- (void)setupPuzzle
{
    int countOfTiles = -1;
    for (int column = 0; column < GRID_COLUMNS; column ++) {
        for (int row = 0; row < GRID_ROWS; row ++) 
        {
            countOfTiles += 1;
            MZTile *tile = [[MZTile alloc] initWithFrame:CGRectMake(0, 0, TILE_WIDTH, TILE_HEIGHT)];
            [tile setDelegate:self];
            
            
            CGPoint originalPosition = CGPointMake(row, column);
            if (CGPointEqualToPoint(originalPosition, self.emptyTilePosition)) {
                continue;
            }
            tile.originalLocation = originalPosition;
            tile.currentLocation = originalPosition;
            [tile.numberLabel setText:[NSString stringWithFormat:@"%d", countOfTiles]];
            [self.tiles addObject:tile];
        }
    }
    
    [self.gridView populatePuzzleWithTiles:self.tiles andEmptyTile:self.emptyTilePosition];
    [self shuffleTiles];
}

#pragma mark
#pragma mark MZTileDelegate Methods

-(void)tileTapped:(MZTile *)tile{
    [self moveTile:tile];
}

#pragma mark
#pragma mark Tile Movement Methods

-(void)moveTile:(MZTile *)tile
{
    TileDirection direction = [self directionToMove:tile];
    
    if ([self isAdjacentTileBlank:tile forDirection:direction]) {
        switch (direction) {
            case MoveLeft:
                [tile moveTileWithDirection:MoveLeft];
                break;
            case MoveRight:
                [tile moveTileWithDirection:MoveRight];
                break;
            case MoveUP:
                [tile moveTileWithDirection:MoveUP];
                break;
            case MoveDown:
                [tile moveTileWithDirection:MoveDown];
                break;
            case NoMove:
            default:
                break;
        }
        
        [self updateTile:tile afterDirectionalMove:direction];
        
        if (!self.isShufflin) {
            if (direction != 4) {[self incrementScore];};
            [self finished];
        }   
    }
}

-(TileDirection)directionToMove:(MZTile *)tile
{
    if (tile.currentLocation.y == self.emptyTilePosition.y) {
        
        if ( self.emptyTilePosition.x < tile.currentLocation.x) {
            
            //            DLog(@"move left");
            return MoveLeft;
        }
        
        if ( self.emptyTilePosition.x > tile.currentLocation.x) {
            //            DLog(@"move right");
            return MoveRight;
        }
    }else if (tile.currentLocation.x == self.emptyTilePosition.x) {
        if ( self.emptyTilePosition.y < tile.currentLocation.y) {
            
            //            DLog(@"move up");
            return MoveUP;
        }
        
        if ( self.emptyTilePosition.y > tile.currentLocation.y) {
            //            DLog(@"move down");
            return MoveDown;
        }
    }
    return NoMove;
}


- (void)updateTile:(MZTile *)tile afterDirectionalMove:(TileDirection)direction{
    
    CGPoint emptyCenter = self.emptyTilePosition;
    CGPoint currentCenter = tile.currentLocation;
    
    switch (direction) {
        case MoveLeft:
            
            emptyCenter.x += 1;
            self.emptyTilePosition = emptyCenter;
            
            currentCenter.x -= 1; 
            tile.currentLocation = currentCenter;
            
            break;
        case MoveRight:
            
            emptyCenter.x -= 1;
            self.emptyTilePosition = emptyCenter;
            
            currentCenter.x += 1; 
            tile.currentLocation = currentCenter;
            
            break;
        case MoveUP:
            emptyCenter.y += 1; 
            self.emptyTilePosition = emptyCenter;
            
            currentCenter.y -= 1; 
            tile.currentLocation = currentCenter;
            break;
        case MoveDown:
            emptyCenter.y -= 1;
            self.emptyTilePosition = emptyCenter;
            
            currentCenter.y += 1;                       
            tile.currentLocation = currentCenter;
            
            break;
        case NoMove:
        default:
            break;
    }
    //    DLog(@"the new blanks is %f, %f", self.emptyTilePosition.x, self.emptyTilePosition.y);
    
}

-(BOOL)isAdjacentTileBlank:(MZTile *)currentTile forDirection:(TileDirection)direction
{   
    
    CGPoint directionOffset = [currentTile fetchOffset:direction];
    CGPoint adjacentPoint = CGPointMake(directionOffset.x + currentTile.currentLocation.x, directionOffset.y + currentTile.currentLocation.y);
    if (CGPointEqualToPoint(adjacentPoint, self.emptyTilePosition)) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark
#pragma mark Shufflin Methods

-(void)shuffleButtonToggeled:(UIButton*)sender{
    
    
    [self shuffleTiles];
}

-(void)shuffleTiles
{
    [self.shuffleButton setEnabled:NO];    
    self.score = 0;
    [self.scoreLabel updateLabel:self.score];
    self.isShufflin = YES;
    for (int i = 0; i < SHUFFLE_ITERATIONS; i++) {
        //get a random tile and try move it
        NSInteger randomIndex = arc4random()%([self.tiles count]-1);
        MZTile *tile = [self.tiles objectAtIndex:randomIndex];
        [self moveTile:tile];
    }
    self.isShufflin = NO;
    [self.shuffleButton setEnabled:YES];
}

#pragma mark
#pragma mark Game Management Methods

- (BOOL)finished
{
    for (int i = 0; i < self.tiles.count; i++) {
        if (![[self.tiles objectAtIndex:i] isInOriginalLocation]) {
            return NO;
        }
    }
    NSString *alertViewMessage = [NSString stringWithFormat:@"You solved the puzzle in %d moves! Enter your name to save the score.", self.score];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Won!" message:alertViewMessage delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
    [alertView setDelegate:self];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
    DLog(@"the empty position is %f %f", self.emptyTilePosition.x, self.emptyTilePosition.y);
    return YES;
}

-(void)incrementScore
{
    self.score += 1;
    [self.scoreLabel updateLabel:self.score];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *fullName = [[alertView textFieldAtIndex:0] text];
        NSDictionary *newScoreDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      fullName,@"fullName",
                                      [NSNumber numberWithInt:self.score], @"totalScore",
                                      nil];
        MZScore *newScore = [[MZScore alloc] initFromDictionary:newScoreDict];
        [[MZCoreDataManager sharedInstance] storeScoreDetails:newScore];
        
        [self shuffleTiles];
    }else {
        [self shuffleTiles];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
