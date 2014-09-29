//
//  BodyViewCell.h
//  StandardDigital
//
//  Created by Fahari on 5/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imgTopStory;
@property (strong, nonatomic) UILabel *titleLabel, *timeLabel;
@property (nonatomic, readwrite) CGFloat verticalPadding;

@end
