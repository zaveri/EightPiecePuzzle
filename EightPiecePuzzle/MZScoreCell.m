//
//  MZScoreCell.m
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


#import "MZScoreCell.h"

@implementation MZBadgeView

@synthesize width = _width;
@synthesize badgeString = _badgeString;
@synthesize parent = _parent;
@synthesize badgeColor = _badgeColor;
@synthesize badgeColorHighlighted = _badgeColorHighlighted;
@synthesize showShadow = _showShadow;
@synthesize radius = _radius;

- (id) initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{		
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;	
}

-(void)drawRect:(CGRect)rect
{
    CGFloat fontsize = 18;
    
	CGSize numberSize = [self.badgeString sizeWithFont:[UIFont boldSystemFontOfSize: fontsize]];
    
    CGRect bounds = CGRectMake(0 , 0, numberSize.width + 12 , 18);
	CGFloat radius = (self.radius)?self.radius:4.0;
    UIColor *colour;
    
    if((self.parent.selectionStyle != UITableViewCellSelectionStyleNone) && (self.parent.highlighted || self.parent.selected))
    {
		if (self.badgeColorHighlighted) 
        {
			colour = self.badgeColorHighlighted;
		} else {
			colour = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.000f];
		}
	} else {
		if (self.badgeColor) 
        {
			colour = self.badgeColor;
		} else {
			colour = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
		}
	}
    
    // Bounds for thet text label
	bounds.origin.x = (bounds.size.width - numberSize.width) / 2.0f + 0.5f;
	bounds.origin.y += 2;
	
    CALayer *_badge = [CALayer layer];
	[_badge setFrame:rect];
    
    CGSize imageSize = _badge.frame.size;
    
    // Render the image @x2 for retina people
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00)
    {
        imageSize = CGSizeMake(_badge.frame.size.width * 2, _badge.frame.size.height * 2);
        [_badge setFrame:CGRectMake(_badge.frame.origin.x, 
                                    _badge.frame.origin.y,
                                    _badge.frame.size.width*2, 
                                    _badge.frame.size.height*2)];
        fontsize = (fontsize * 2);
        bounds.origin.x = ((bounds.size.width * 2) - (numberSize.width * 2)) / 2.0f + 1;
        bounds.origin.y += 3;
        bounds.size.width = bounds.size.width * 2;
        radius = radius * 2;
    }
    
    [_badge setBackgroundColor:[colour CGColor]];
	[_badge setCornerRadius:radius];
    
    UIGraphicsBeginImageContext(imageSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	[_badge renderInContext:context];
	CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
	
	[self.badgeString drawInRect:bounds withFont:[UIFont boldSystemFontOfSize:fontsize] lineBreakMode:UILineBreakModeClip];
	
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	[outputImage drawInRect:rect];
    
    if((self.parent.selectionStyle != UITableViewCellSelectionStyleNone) && (self.parent.highlighted || self.parent.selected) && self.showShadow)
	{
		[[self layer] setCornerRadius:radius];
		[[self layer] setShadowOffset:CGSizeMake(0, 1)];
		[[self layer] setShadowRadius:1.0];
		[[self layer] setShadowOpacity:0.8];
	} else {
		[[self layer] setCornerRadius:radius];
		[[self layer] setShadowOffset:CGSizeMake(0, 0)];
		[[self layer] setShadowRadius:0];
		[[self layer] setShadowOpacity:0];
	}
    
}


@end


@implementation MZScoreCell

@synthesize badgeString = _badgeString;
@synthesize badge = _badge;
@synthesize badgeColor = _badgeColor;
@synthesize badgeColorHighlighted  = _badgeColorHighlighted;
@synthesize showShadow = _showShadow;

- (void)configureSelf 
{
    // Initialization code
    _badge = [[MZBadgeView alloc] initWithFrame:CGRectZero];
    self.badge.parent = self;
    
    [self.contentView addSubview:self.badge];
    [self.badge setNeedsDisplay];
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super initWithCoder:decoder])) 
    {
        [self configureSelf];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSelf];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.badgeString)
	{
		//force badges to hide on edit.
		if(self.editing)
			[self.badge setHidden:YES];
		else
			[self.badge setHidden:NO];
		
		
		CGSize badgeSize = [self.badgeString sizeWithFont:[UIFont boldSystemFontOfSize: 11]];
		CGRect badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width + 35),
                                       (CGFloat)round((self.contentView.frame.size.height - 18) / 2),
                                       badgeSize.width + 20,
                                       25);
		
        if(self.showShadow)
            [self.badge setShowShadow:YES];
        else
            [self.badge setShowShadow:NO];
        
		[self.badge setFrame:badgeframe];
		[self.badge setBadgeString:self.badgeString];
		
		if ((self.textLabel.frame.origin.x + self.textLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.textLabel.frame.size.width - badgeframe.size.width - 10.0f;
			
			self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, badgeWidth, self.textLabel.frame.size.height);
		}
		
		if ((self.detailTextLabel.frame.origin.x + self.detailTextLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.detailTextLabel.frame.size.width - badgeframe.size.width - 10.0f;
			
			self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, badgeWidth, self.detailTextLabel.frame.size.height);
		}
        
		//set badge highlighted colours or use defaults
		if(self.badgeColorHighlighted)
			self.badge.badgeColorHighlighted = self.badgeColorHighlighted;
		else 
			self.badge.badgeColorHighlighted = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.000f];
		
		//set badge colours or impose defaults
		if(self.badgeColor)
			self.badge.badgeColor = self.badgeColor;
		else
			self.badge.badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
	}
	else
	{
		[self.badge setHidden:YES];
	}
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	[self.badge setNeedsDisplay];
    
    if(self.showShadow)
    {
        [[[self textLabel] layer] setShadowOffset:CGSizeMake(0, 1)];
        [[[self textLabel] layer] setShadowRadius:1];
        [[[self textLabel] layer] setShadowOpacity:0.8];
        
        [[[self detailTextLabel] layer] setShadowOffset:CGSizeMake(0, 1)];
        [[[self detailTextLabel] layer] setShadowRadius:1];
        [[[self detailTextLabel] layer] setShadowOpacity:0.8];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	[self.badge setNeedsDisplay];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	
	if (editing) 
    {
		self.badge.hidden = YES;
		[self.badge setNeedsDisplay];
		[self setNeedsDisplay];
	}
	else 
	{
		self.badge.hidden = NO;
		[self.badge setNeedsDisplay];
		[self setNeedsDisplay];
	}
}

@end