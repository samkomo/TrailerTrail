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

#import <UIKit/UIKit.h>
#import "WKVerticalScrollBar.h"
#import "WKAccessoryView.h"

@interface WKTextDemoView : UIView

@property (nonatomic, readwrite) CGFloat verticalPadding;
@property (nonatomic, readwrite) CGFloat horizontalPadding;
@property (nonatomic, readwrite) CGFloat socialImgWidth;
@property (nonatomic, readwrite) CGFloat socialImgHeight;

@property (nonatomic, readonly) UIImageView *posterImage;
@property (nonatomic, readonly) UIImageView *plotTrailerImage;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *genreLabel;
@property (nonatomic, readonly) UILabel *runtimeLabel;
@property (nonatomic, readonly) UIImageView *fbImageView;

@property (nonatomic, readonly) UILabel *sLine1;
@property (nonatomic, readonly) UILabel *sLine2;

@property (nonatomic, readonly) UIImageView *fbkImageView;
@property (nonatomic, readonly) UIImageView *tweeterImageView;
@property (nonatomic, readonly) UIImageView *gplusImageView;
@property (nonatomic, readonly) UIImageView *emailImageView;
@property (nonatomic, readonly) UIImageView *shareImageView;

@property (nonatomic, readonly) UILabel *releasedLabel;
@property (nonatomic, readonly) UIImageView *imgPlayTailer;
@property (nonatomic, readonly) UILabel *commentsLabel;


@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, readonly) WKVerticalScrollBar *verticalScrollBar;
@property (nonatomic, readonly) WKAccessoryView *accessoryView;

@end
