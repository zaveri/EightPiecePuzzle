//
//  Score.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Score : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSNumber * totalScore;

@end
