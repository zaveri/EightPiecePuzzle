//
//  UIFont+EightPiecePuzzleAdditions.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (EightPiecePuzzleAdditions)

+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (UIFont *)crunchFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldCrunchFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldItalicCrunchFontOfSize:(CGFloat)fontSize;
+ (UIFont *)italicCrunchFontOfSize:(CGFloat)fontSize;

@end
