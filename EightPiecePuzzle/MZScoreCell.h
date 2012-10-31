//
//  MZScoreCell.h
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Badged Cells thanks to Tim Davies!
//  TDBadgedCell.h
//  TDBadgedTableCell
//	TDBageView
//
//	Any rereleasing of this code is prohibited.
//	Please attribute use of this code within your application
//
//	Any Queries should be directed to hi@tmdvs.me | http://www.tmdvs.me
//	
//  Created by Tim
//  Copyright 2011 Tim Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MZBadgeView : UIView
{
}

@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, strong)   NSString *badgeString;
@property (nonatomic, assign)   UITableViewCell *parent;
@property (nonatomic, strong)   UIColor *badgeColor;
@property (nonatomic, strong)   UIColor *badgeColorHighlighted;
@property (nonatomic, assign)   BOOL showShadow;
@property (nonatomic, assign)   CGFloat radius;

@end

@interface MZScoreCell : UITableViewCell {
    
}

@property (nonatomic, strong)   NSString *badgeString;
@property (readonly, strong)    MZBadgeView *badge;
@property (nonatomic, strong)   UIColor *badgeColor;
@property (nonatomic, strong)   UIColor *badgeColorHighlighted;
@property (nonatomic, assign)   BOOL showShadow;

@end
