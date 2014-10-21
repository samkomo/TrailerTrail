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
#import "WKTextDemoView.h"
#import "BaseViewController.h"
#import "PreviewFilm.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Movie.h"
#import "AppDelegate.h"

@interface FilmDetailViewController : BaseViewController {
    WKTextDemoView *demoView;
}

@property (nonatomic, strong) PreviewFilm *film;
@property (nonatomic, strong) Movie *filmSaved;
@property (nonatomic) BOOL isSaved;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
-(void)playMovie:(UITapGestureRecognizer *)gesture;

- (IBAction)addBookMarkedFilms:(UIBarButtonItem *)sender;



//data persistent with core data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


//sharing via facebook
-(void)favcebookSharing;
//staging image
-(void)stageImage;
//set publish permission
-(void) publishingPermission;


@end
