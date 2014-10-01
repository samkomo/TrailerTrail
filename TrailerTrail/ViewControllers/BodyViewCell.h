//
//  BodyViewCell.h
//  StandardDigital
//
//  Created by Fahari on 5/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"

@interface BodyViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imgTopStory;
@property (strong, nonatomic) UILabel *titleLabel, *languageLabel, *typeLabel;
@property (nonatomic, readwrite) CGFloat verticalPadding;
@property (nonatomic, strong) RatingView *starView;

@end
