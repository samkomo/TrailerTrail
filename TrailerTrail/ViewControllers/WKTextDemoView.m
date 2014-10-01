//
// WKVerticalScrollBar
// http://github.com/litl/WKVerticalScrollBar
//
// Copyright (C) 2012 litl, LLC
// Copyright (C) 2012 WKVerticalScrollBar authors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
//

#import "WKTextDemoView.h"

@implementation WKTextDemoView

@synthesize verticalPadding = _verticalPadding;

@synthesize textLabel = _textLabel;
@synthesize scrollView = _scrollView;
@synthesize verticalScrollBar = _verticalScrollBar;
@synthesize accessoryView = _accessoryView;
@synthesize socialImgHeight = _socialImgHeight;
@synthesize horizontalPadding = _horizontalPadding;
@synthesize socialImgWidth = _socialImgWidth;

@synthesize plotTrailerImage = _plotTrailerImage, posterImage=_posterImage;
@synthesize fbImageView = _fbImageView;
@synthesize genreLabel =_genreLabel;
@synthesize runtimeLabel =_runtimeLabel;
@synthesize titleLabel =_titleLabel;
@synthesize sLine1 = _sLine1, sLine2 = _sLine2;
@synthesize fbkImageView = _fbkImageView, tweeterImageView = _tweeterImageView, gplusImageView = _gplusImageView, emailImageView = _emailImageView, shareImageView = _shareImageView;
@synthesize releasedLabel = _releasedLabel;
@synthesize imgPlayTailer =_imgPlayTailer;
@synthesize commentsLabel =_commentsLabel;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        _verticalPadding = 10.0f;
        _horizontalPadding = 10.0f;
        _socialImgWidth = 48.0f;
        _socialImgHeight = 48.0f;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setBackgroundColor:[UIColor colorWithRed:0xE4 / 255.0f
                                                        green:0xE2 / 255.0f
                                                         blue:0xDD / 255.0f
                                                        alpha:1.0f]];
        [_scrollView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
//        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"Baskerville" size:16.0f]];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_scrollView addSubview:_titleLabel];
        
        
        _plotTrailerImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_plotTrailerImage setBackgroundColor:[UIColor grayColor]];
        [_plotTrailerImage setContentMode:UIViewContentModeScaleAspectFill];
        [_plotTrailerImage setClipsToBounds:YES];
        [_plotTrailerImage setUserInteractionEnabled:YES];
        //_storyImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_plotTrailerImage];
        
        _posterImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_posterImage setBackgroundColor:[UIColor grayColor]];
        [_posterImage setContentMode:UIViewContentModeScaleAspectFill];
        [_posterImage setClipsToBounds:YES];
        [_scrollView addSubview:_posterImage];
        
        _runtimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_runtimeLabel setBackgroundColor:[UIColor clearColor]];
        [_runtimeLabel setFont:[UIFont fontWithName:@"Baskerville" size:18.0f]];
        [_runtimeLabel setNumberOfLines:0];
        [_runtimeLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_scrollView addSubview:_runtimeLabel];
        
        
        _fbImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [_fbImageView setBackgroundColor:[UIColor grayColor]];
        [_scrollView addSubview:_fbImageView];
        
        
        _sLine1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _sLine2 = [[UILabel alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_sLine1];
        [_scrollView addSubview:_sLine2];
        
        _genreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_genreLabel setBackgroundColor:[UIColor clearColor]];
        [_genreLabel setFont:[UIFont fontWithName:@"Baskerville" size:14.0f]];
        [_genreLabel setNumberOfLines:0];
        [_genreLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_scrollView addSubview:_genreLabel];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_textLabel setBackgroundColor:[UIColor clearColor]];
        [_textLabel setFont:[UIFont fontWithName:@"Baskerville" size:18.0f]];
        [_textLabel setNumberOfLines:0];
        [_textLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [_textLabel setAttributedText:NSTextAlignmentJustified];
        [_scrollView addSubview:_textLabel];
        
        
        //social media icons
        _fbkImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_fbkImageView];
        
        _tweeterImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_tweeterImageView];
        
        _gplusImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_gplusImageView];
        
        _emailImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_emailImageView];
        
        _shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_shareImageView];
        
        
        //web link and comment frame
        _releasedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_releasedLabel setBackgroundColor:[UIColor clearColor]];
        [_releasedLabel setFont:[UIFont fontWithName:@"Baskerville" size:18.0f]];
        [_releasedLabel setNumberOfLines:0];
        [_releasedLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_releasedLabel setTextColor:[UIColor blueColor]];
        [_scrollView addSubview:_releasedLabel];
        
        _imgPlayTailer = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgPlayTailer.userInteractionEnabled = YES;
        [_plotTrailerImage addSubview:_imgPlayTailer];
        
        _commentsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_commentsLabel setBackgroundColor:[UIColor clearColor]];
        [_commentsLabel setFont:[UIFont fontWithName:@"Baskerville" size:18.0f]];
        [_commentsLabel setNumberOfLines:0];
        [_commentsLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_scrollView addSubview:_commentsLabel];


        // NOTE: Make sure vertical scroll bar is on top of the scroll view
        _verticalScrollBar = [[WKVerticalScrollBar alloc] initWithFrame:CGRectZero];
        [_verticalScrollBar setScrollView:_scrollView];
        [self addSubview:_verticalScrollBar];
        
        _accessoryView = [[WKAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
        [_accessoryView setForegroundColor:[UIColor colorWithWhite:0.2f alpha:1.0f]];
        [_verticalScrollBar setHandleAccessoryView:_accessoryView];
    }
    return self;
}

- (void)dealloc{

    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeFromSuperview];
    _scrollView = nil;
}

//- (void)dealloc
//{
//    [super dealloc];
//
//    
//
//    [_sLine1 release];
//    [_sLine1 release];
//    
//    [_genreLabel release];
//    [_runtimeLabel release];
//    [_plotTrailerImage release];
//    [_posterImage release];
//    [_fbImageView release];
//    [_titleLabel release];
//    [_genreLabel release];
//    
//    [_fbkImageView release];
//    [_tweeterImageView release];
//    [_gplusImageView release];
//    [_emailImageView release];
//    [_shareImageView release];
//
//    [_textLabel release];
//    [_scrollView release];
//    [_verticalScrollBar release];
//    
//    }

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = [self bounds];

    CGFloat columnWidth = bounds.size.width * 0.93f;
    CGSize titleSize = [[_titleLabel text] sizeWithFont:[_titleLabel font]
                                     constrainedToSize:CGSizeMake(columnWidth, FLT_MAX)];
    CGSize timeSize = [[_runtimeLabel text] sizeWithFont:[_runtimeLabel font]
                                     constrainedToSize:CGSizeMake(columnWidth, FLT_MAX)];
    CGSize authorSize = [[_genreLabel text] sizeWithFont:[_genreLabel font]
                                    constrainedToSize:CGSizeMake(columnWidth, FLT_MAX)];
    CGSize textSize = [[_textLabel text] sizeWithFont:[_textLabel font]
                                   constrainedToSize:CGSizeMake(columnWidth, FLT_MAX)];
    CGSize webSize = [[_releasedLabel text] sizeWithFont:[_releasedLabel font]
                                    constrainedToSize:CGSizeMake(columnWidth, FLT_MAX)];
    
    //set frames
    
    
    
    [_posterImage setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2), _verticalPadding, 110, 140)];
    
    //draw line
    [_sLine1 setFrame:CGRectMake((bounds.size.width/2)-(columnWidth/2), _posterImage.frame.size.height + _verticalPadding *2, columnWidth, 1)];
    _sLine1.backgroundColor = [UIColor colorWithRed:198/255.0
                                              green:198/255.0
                                               blue:198/255.0
                                              alpha:1.0];
    [_sLine2 setFrame:CGRectMake((bounds.size.width/2)-(columnWidth/2), _posterImage.frame.size.height + _verticalPadding*2, columnWidth, 1)];
    _sLine2.backgroundColor = [UIColor whiteColor];
    
    
    [_titleLabel setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2) + _posterImage.frame.size.width + _horizontalPadding, _verticalPadding, columnWidth - (_posterImage.frame.size.width + _horizontalPadding), titleSize.height)];
    
    [_genreLabel setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2) + _posterImage.frame.size.width + _horizontalPadding,titleSize.height + _verticalPadding, columnWidth - (_posterImage.frame.size.width + _horizontalPadding), authorSize.height)];
    
    [_releasedLabel setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2) + _posterImage.frame.size.width + _horizontalPadding,(_posterImage.frame.size.height) - webSize.height , columnWidth - (_posterImage.frame.size.width + _horizontalPadding), webSize.height)];
    
    [_runtimeLabel setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2) + _posterImage.frame.size.width + _horizontalPadding,(_posterImage.frame.size.height) - (webSize.height+timeSize.height) , columnWidth - (_posterImage.frame.size.width + _horizontalPadding), timeSize.height)];
    
    [_plotTrailerImage setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2), (_posterImage.frame.size.height +(_verticalPadding*3)), columnWidth, 180)];
    
    // Center the label in the screen
    [_textLabel setFrame:CGRectMake((bounds.size.width / 2) - (columnWidth / 2), (titleSize.height + (_plotTrailerImage.frame.size.height+_posterImage.frame.size.height +(_verticalPadding*2))),
                                    columnWidth-20, textSize.height)];

    
    double x = (bounds.size.width) - (timeSize.width + ((bounds.size.width / 2) - (columnWidth / 2)));
    [_fbImageView setFrame:CGRectMake(x, (titleSize.height + _plotTrailerImage.frame.size.height + (_verticalPadding*3)), 64.0f, 64.0f)];
    
    
    
    
  
    
    
    // Center the label in the screen
    
    
    
    //social media
    double xSoc = (bounds.size.width / 2) - (((_socialImgWidth *5) + (_horizontalPadding*4)) / 2);
    double ySoc = (titleSize.height + (_plotTrailerImage.frame.size.height+_posterImage.frame.size.height +(_verticalPadding *6)));
    
    [_fbkImageView setFrame:CGRectMake(xSoc, ySoc + (_verticalPadding * 7), _socialImgWidth, _socialImgHeight)];
    
    [_tweeterImageView setFrame:CGRectMake(xSoc + _socialImgWidth + _horizontalPadding, ySoc+ (_verticalPadding * 7), _socialImgWidth, _socialImgHeight)];
    
    [_gplusImageView setFrame:CGRectMake(xSoc + (_socialImgWidth * 2)+ (_horizontalPadding*2), ySoc + (_verticalPadding * 7), _socialImgWidth, _socialImgHeight)];
    
    [_emailImageView setFrame:CGRectMake(xSoc + (_socialImgWidth*3)+ (_horizontalPadding*3), ySoc + (_verticalPadding * 7), _socialImgWidth, _socialImgHeight)];
    
    
    [_shareImageView setFrame:CGRectMake(xSoc + (_socialImgWidth*4)+ (_horizontalPadding*4), ySoc + (_verticalPadding * 7), _socialImgWidth, _socialImgHeight)];
    
    
    [_imgPlayTailer setFrame:CGRectMake((_plotTrailerImage.frame.size.width / 2) - 22, (_plotTrailerImage.frame.size.height / 2) - 22, 44, 44)];

    
    [_scrollView setContentSize:CGSizeMake(bounds.size.width, ySoc + _socialImgHeight + webSize.height+ _imgPlayTailer.frame.size.height + (_verticalPadding * 10))];
    
    
    [_scrollView setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    [_verticalScrollBar setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (![keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
    
    CGFloat contentOffsetY = [_scrollView contentOffset].y;
    CGFloat contentHeight = [_scrollView contentSize].height;
    CGFloat frameHeight = [_scrollView frame].size.height;
    
    CGFloat percent = (contentOffsetY / (contentHeight - frameHeight)) * 100;
    [[_accessoryView textLabel] setText:[NSString stringWithFormat:@"%i%%", (int)percent]];
}

@end
