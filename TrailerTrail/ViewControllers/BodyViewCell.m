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
@synthesize timeLabel = _timeLabel;
@synthesize titleLabel = _titleLabel;
@synthesize verticalPadding = _verticalPadding;


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
        [_titleLabel setFont:[UIFont fontWithName:@"Baskerville" size:18.0f]];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
//        _titleLabel.alpha = 0.5f;
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:16.0f];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];

    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = [self bounds];
    CGFloat columnWidth = bounds.size.width * 0.93f;

    CGSize titleSize = [[_titleLabel text] sizeWithFont:[_titleLabel font]
                                      constrainedToSize:CGSizeMake(bounds.size.width, FLT_MAX)];
    CGSize timeSize = [[_timeLabel text] sizeWithFont:[_timeLabel font]
                                    constrainedToSize:CGSizeMake(140, FLT_MAX)];
    
    [_imgTopStory setFrame:CGRectMake(5, 5, 80, 100.0f)];
    
    [_titleLabel setFrame:CGRectMake(115, (_imgTopStory.frame.size.height/2)-titleSize.height, bounds.size.width - 140, titleSize.height)];
    
    
    [_timeLabel setFrame:CGRectMake(115, _imgTopStory.frame.size.height-timeSize.height, timeSize.width, timeSize.height)];
    
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
