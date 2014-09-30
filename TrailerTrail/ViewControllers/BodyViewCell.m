//
//  BodyViewCell.m
//  StandardDigital
//
//  Created by Fahari on 5/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "BodyViewCell.h"

@implementation BodyViewCell
@synthesize imgTopStory = _imgTopStory;
@synthesize languageLabel = _languageLabel;
@synthesize titleLabel = _titleLabel, typeLabel=_typeLabel;
@synthesize verticalPadding = _verticalPadding;
@synthesize starView =_starView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _verticalPadding = 10;
        
        _imgTopStory = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgTopStory.backgroundColor = [UIColor clearColor];
        [_imgTopStory setContentMode:UIViewContentModeScaleAspectFill];
        [_imgTopStory  setClipsToBounds:YES];

        [self.contentView addSubview:_imgTopStory];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setFont:[UIFont fontWithName:@"Baskerville" size:16.0f]];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
//        _titleLabel.alpha = 0.5f;
        [self.contentView addSubview:_titleLabel];
        
        _languageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _languageLabel.font = [UIFont systemFontOfSize:14.0f];
        _languageLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_languageLabel];
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeLabel.font = [UIFont systemFontOfSize:14.0f];
        _typeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_typeLabel];
        
        //star rating
        _starView = [[RatingView alloc] initWithFrame:CGRectZero];
        _starView.backgroundColor = [UIColor clearColor];
        [_starView setUserInteractionEnabled:NO];
        [self.contentView addSubview:_starView];

    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = [self bounds];
    CGFloat columnWidth = bounds.size.width * 0.93f;

    [_imgTopStory setFrame:CGRectMake(5, 5, 80, 100.0f)];
    
    
    CGSize titleSize = [[_titleLabel text] sizeWithFont:[_titleLabel font]
                                      constrainedToSize:CGSizeMake(bounds.size.width, FLT_MAX)];
    CGSize timeSize = [[_languageLabel text] sizeWithFont:[_languageLabel font]
                                    constrainedToSize:CGSizeMake(columnWidth - _imgTopStory.frame.size.width +10, FLT_MAX)];
    
    CGSize typeSize = [[_typeLabel text] sizeWithFont:[_typeLabel font]
                                        constrainedToSize:CGSizeMake(columnWidth - _imgTopStory.frame.size.width +10, FLT_MAX)];

    
    
    
    [_titleLabel setFrame:CGRectMake(_imgTopStory.frame.size.width+15, 10, columnWidth - _imgTopStory.frame.size.width +10, titleSize.height)];
    
    
    [_languageLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + timeSize.height +typeSize.height, columnWidth - _imgTopStory.frame.size.width +10, timeSize.height)];
    
    [_typeLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + titleSize.height, columnWidth - _imgTopStory.frame.size.width +10, timeSize.height)];
    
    [_starView setFrame:CGRectMake(_titleLabel.frame.origin.x, _imgTopStory.frame.size.height- 24, 148, 24)];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake((bounds.size.width/2)-(columnWidth/2), 0, columnWidth, 110)];
    bg.backgroundColor = [UIColor clearColor];
    self.backgroundView = bg;
    
}


- (void)setFrame:(CGRect)frame {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        frame.origin.x += 10;
        frame.size.width -= 2 * 10;
    }
    [super setFrame:frame];

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
