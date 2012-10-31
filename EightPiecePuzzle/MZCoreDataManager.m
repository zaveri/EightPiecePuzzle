//
//  MZCoreDataManager.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZCoreDataManager.h"
#import "MZAppDelegate.h"

@implementation MZCoreDataManager

@synthesize mainObjectContext = _mainObjectContext;
@synthesize backgroundObjectContext = _backgroundObjectContext;

+(MZCoreDataManager *)sharedInstance
{
    static dispatch_once_t predicate;
    static MZCoreDataManager *_sharedInstanceSource = nil;
    
    dispatch_once(&predicate, ^{
        _sharedInstanceSource = [[self alloc] init];
    });
    
	return _sharedInstanceSource;
}

- (id) init
{
    self = [super init];
    if(self) {
        self.mainObjectContext = [MZAppDelegateInstance managedObjectContext];
    }
    
    return self;
}

-(void)storeScoreDetails:(MZScore *)details
{
    [details saveScoreCoreData:self.mainObjectContext];
}

@end
