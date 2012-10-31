//
//  MZCoreDataManager.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZScore.h"

@interface MZCoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, strong) NSManagedObjectContext * backgroundObjectContext;


+ (MZCoreDataManager *)sharedInstance;
- (void)storeScoreDetails:(MZScore *)people;

@end
