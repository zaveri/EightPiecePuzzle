//
//  MZScore.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"

@class Score;

@interface MZScore : NSObject{
    
}


@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSNumber *totalScore;

- (id)initFromDictionary:(NSDictionary *)dict;
- (id) initFromScore:(Score *)score;
- (void)saveScoreCoreData:(NSManagedObjectContext *)context;
- (void)addNewSCore:(NSManagedObjectContext *)context;
- (void)updateScore:(Score *)score withContext:(NSManagedObjectContext *)context;
- (Score *)retrieveObject:(NSManagedObjectContext *)context;

@end
