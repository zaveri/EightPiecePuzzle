//
//  UILabel+EightPiecePuzzleAdditions.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel+EightPiecePuzzleAdditions.h"

@implementation UILabel (EightPiecePuzzleAdditions)

- (void)updateLabel:(NSInteger)integerValue
{
[self setText:[NSString stringWithFormat:@"%d", integerValue]];
}

@end
