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

#import "FilmDetailViewController.h"
#import "WKVerticalScrollBar.h"
#import "SWRevealViewController.h"

@implementation FilmDetailViewController


- (void)loadView
{
    demoView = [[WKTextDemoView alloc] initWithFrame:CGRectZero];
    [self setView:demoView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"fillerati" ofType:@"txt"];
    NSString *text = @"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER."; //[NSString stringWithContentsOfFile:fullPath
//                                               encoding:NSUTF8StringEncoding
//                                                  error:nil];
    
    [[demoView titleLabel] setText:@"True Grit"];
    [[demoView plotTrailerImage] setImage:[UIImage imageNamed:@"CORDmeet301013.jpg"]];
    [[demoView runtimeLabel] setText:@"110 min"];
    [[demoView fbImageView] setImage:[UIImage imageNamed:@"1399655270_comments.png"]];
    [[demoView genreLabel] setText:@"Adventure, Drama, Western"];
    [[demoView textLabel] setText:text];
    
    [[demoView fbkImageView] setImage:[UIImage imageNamed:@"1399640891_facebook_circle_color.png"]];
    [[demoView tweeterImageView] setImage:[UIImage imageNamed:@"1399640970_twitter_circle_color.png"]];
    [[demoView gplusImageView] setImage:[UIImage imageNamed:@"1399640923_google_circle_color.png"]];
    [[demoView emailImageView] setImage:[UIImage imageNamed:@"1399641171_open-email.png"]];
    [[demoView shareImageView] setImage:[UIImage imageNamed:@"1399641044_647404-share.png"]];
    
    [[demoView releasedLabel] setText:@"22 Dec 2010"];
    [[demoView frmCommentImageView] setImage:[UIImage imageNamed:@"frame.png"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
