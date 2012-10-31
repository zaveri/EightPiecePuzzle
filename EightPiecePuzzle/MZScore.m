//
//  MZScore.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZScore.h"

@implementation MZScore

@synthesize fullName = _fullName;
@synthesize totalScore = _totalScore;


-(id)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.fullName = [dict objectForKey:@"fullName"];
        self.totalScore = [dict objectForKey:@"totalScore"];
    }
    return self;
}

- (id) initFromScore:(Score *)score 
{
    self = [super init];
    if (self) {
        self.fullName = [score valueForKey:@"fullName"];
        self.totalScore = [score valueForKey:@"totalScore"];
    }
    return self;
}

-(void)saveScoreCoreData:(NSManagedObjectContext *)context{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Score" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"(fullName == %@)", self.fullName]];
    
    NSError *error;
    NSArray *duplicate = [context executeFetchRequest:fetchRequest error:&error];
    
    if (duplicate.count == 0) {
        [self addNewSCore:context];
    }else if (duplicate.count == 1) {
        Score *score = [duplicate objectAtIndex:0];
        [self updateScore:score withContext:context];
    }
}

- (void)addNewSCore:(NSManagedObjectContext *)context
{
    Score *scoreObject = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:context];
    NSArray *keys = [NSArray arrayWithObjects:@"fullName", @"totalScore", nil];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:keys];
    [scoreObject setValuesForKeysWithDictionary:dict];
    
    NSError *error = nil;
    if (![context save:&error]) {
        DLog(@"Error inserting new List %@, %@", error, [error userInfo]);
    }
}

-(void)updateScore:(Score *)score withContext:(NSManagedObjectContext *)context
{
    NSArray *keys = [NSArray arrayWithObjects:@"fullName", @"totalScore", nil];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:keys];
    [score setValuesForKeysWithDictionary:dict];
    
    NSError *error = nil;
    if (![context save:&error]) {
        DLog(@"Error saving List %@, %@", error, [error userInfo]);
    }  
}

-(Score *)retrieveObject:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Score" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"(permalink == %@)", self.fullName]];
    
    NSError *error;
    NSArray *duplicate = [context executeFetchRequest:fetchRequest error:&error];
    
    Score *scoreObject;
    if (duplicate.count >= 1) {
        scoreObject = [duplicate objectAtIndex:0];
    }
    
    return scoreObject;
}


@end
