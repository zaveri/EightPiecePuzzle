//
//  MZSecondViewController.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZSecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *scores;

-(void)fetchScoresFromCoreData;

@end
