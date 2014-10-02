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
#import "PreviewFilm.h"

@implementation FilmDetailViewController

@synthesize film=_film;

- (void)loadView
{
    demoView = [[WKTextDemoView alloc] initWithFrame:CGRectZero];
    [self setView:demoView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showProgressHUDCompleteMessage:@"Bookmark Successful!"];
   
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"fillerati" ofType:@"txt"];
    NSString *text = @"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER."; //[NSString stringWithContentsOfFile:fullPath
//                                               encoding:NSUTF8StringEncoding
//                                                  error:nil];
    
    [[demoView titleLabel] setText:self.film.title];
    
    // download the image asynchronously
    if (![self.film.poster  isEqual: @"N/A"]) {
        [self downloadImageWithURL:[NSURL URLWithString:self.film.poster] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                [demoView plotTrailerImage].image = image;
                [demoView posterImage].image = image;
            }
        }];
    }
    

    
    [[demoView runtimeLabel] setText:self.film.runtime];
    [[demoView fbImageView] setImage:[UIImage imageNamed:@"1399655270_comments.png"]];
    [[demoView genreLabel] setText:self.film.genre];
    [[demoView textLabel] setText:self.film.plot];
    
    [[demoView fbkImageView] setImage:[UIImage imageNamed:@"1399640891_facebook_circle_color.png"]];
    [[demoView tweeterImageView] setImage:[UIImage imageNamed:@"1399640970_twitter_circle_color.png"]];
    [[demoView gplusImageView] setImage:[UIImage imageNamed:@"1399640923_google_circle_color.png"]];
    [[demoView emailImageView] setImage:[UIImage imageNamed:@"1399641171_open-email.png"]];
    [[demoView shareImageView] setImage:[UIImage imageNamed:@"1399641044_647404-share.png"]];
    
    [[demoView releasedLabel] setText:self.film.released];
    [[demoView imgPlayTailer] setImage:[UIImage imageNamed:@"btnPlay_Small"]];
    
//    [[demoView imgPlayTailer] addTarget:self action:@selector(searchGoogle:) forControlEvents:UIControlEventTouchUpInside];
    
    //create a tapgesture to release keyboard on tap
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playMovie:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setDelegate:self];
    [[demoView imgPlayTailer] addGestureRecognizer:tap];
    [[demoView plotTrailerImage] addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    [tap setDelaysTouchesEnded:NO];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


-(void)playMovie:(UITapGestureRecognizer *)gesture
{
    NSURL *url = [NSURL URLWithString:
                  @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    
    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
}

- (IBAction)addBookMarkedFilms:(UIBarButtonItem *)sender {
    [self showActivityIndicator];
    PreviewFilm *film1 = [[PreviewFilm alloc] init];
    [film1.bookmarkedFilms addObjectsFromArray:[PreviewFilm unarchive]];
    
    [film1.bookmarkedFilms addObject:self.film];
    [film1 saveLocally];
    
<<<<<<< HEAD
    [self showProgressHUDWithSuccess:@"Bookmark Successful!"];
=======
    [self showProgressHUDCompleteMessage:NSLocalizedString(@"No films found!", @"Informing the user a process has failed")];
>>>>>>> FETCH_HEAD
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}



@end
