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
   
 
    if (self.isSaved) {
        [[demoView titleLabel] setText:self.filmSaved.title];
        
        // download the image asynchronously
        if (![self.filmSaved.poster  isEqual: @"N/A"]) {
            [self downloadImageWithURL:[NSURL URLWithString:self.filmSaved.poster] completionBlock:^(BOOL succeeded, UIImage *image) {
                if (succeeded) {
                    // change the image in the cell
                    [demoView plotTrailerImage].image = image;
                    [demoView posterImage].image = image;
                }
            }];
        }
        
        
        
        [[demoView runtimeLabel] setText:self.filmSaved.runtime];
        [[demoView fbImageView] setImage:[UIImage imageNamed:@"1399655270_comments.png"]];
        [[demoView genreLabel] setText:self.filmSaved.genre];
        [[demoView textLabel] setText:self.filmSaved.plot];
        [[demoView releasedLabel] setText:self.filmSaved.released];
        
    } else {
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
        [[demoView releasedLabel] setText:self.film.released];
        
        
        
    }
    
    [[demoView fbkImageView] setImage:[UIImage imageNamed:@"1399640891_facebook_circle_color.png"]];
    [[demoView tweeterImageView] setImage:[UIImage imageNamed:@"1399640970_twitter_circle_color.png"]];
    [[demoView gplusImageView] setImage:[UIImage imageNamed:@"1399640923_google_circle_color.png"]];
    [[demoView emailImageView] setImage:[UIImage imageNamed:@"1399641171_open-email.png"]];
    [[demoView shareImageView] setImage:[UIImage imageNamed:@"1399641044_647404-share.png"]];
    
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
    
    
    //core data
    //1
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;

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
    
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Rate this App" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share on Facebook", @"Bookmark", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
    
    
//    PreviewFilm *film1 = [[PreviewFilm alloc] init];
//    [film1.bookmarkedFilms addObjectsFromArray:[PreviewFilm unarchive]];
//    
//    [film1.bookmarkedFilms addObject:self.film];
//    [film1 saveLocally];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        [self facebookSharing];
        break;
        case 1:
        [self showActivityIndicator];
        [self showProgressHUDWithSuccess:@"Bookmark Successful!"];
        
        // Add Entry to PhoneBook Data base and reset all fields
        //  1
        Movie * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:self.managedObjectContext];
        
        //  2
        
            newEntry.title = self.film.title;
            newEntry.imdbID = self.film.imdbID;
            newEntry.type = self.film.type;
            newEntry.language = self.film.language;
            newEntry.poster = self.film.poster;
            newEntry.starRating = self.film.starRating;
            newEntry.plot = self.film.plot;
            newEntry.runtime = self.film.runtime;
            newEntry.released = self.film.released;
            newEntry.genre = self.film.genre;
            
        
        //  3
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

        break;
        
    } 
}

-(void) facebookSharing{
    
//    [self publishingPermission];
    
    
    
    
    
    
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        
        // Put together the dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Sharing Tutorial", @"name",
                                       @"Build great social apps and get more installs.", @"caption",
                                       @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                       @"https://developers.facebook.com/docs/ios/share/", @"link",
                                       @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }

}

-(void)publishingPermission{
    
    // Check for publish permissions
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  NSDictionary *permissions= [(NSArray *)[result data] objectAtIndex:0];
                                  if (![permissions objectForKey:@"publish_actions"]){
                                      // Permission hasn't been granted, so ask for publish_actions
                                      [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                                                            defaultAudience:FBSessionDefaultAudienceFriends
                                                                          completionHandler:^(FBSession *session, NSError *error) {
                                                                              if (!error) {
                                                                                  if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound){
                                                                                      // Permission not granted, tell the user we will not share to Facebook
                                                                                      NSLog(@"Permission not granted, we will not share to Facebook.");
                                                                                      
                                                                                  } else {
                                                                                      // Permission granted, publish the OG story
                                                                                      [self stageImage];
                                                                                  }
                                                                                  
                                                                              } else {
                                                                                  // An error occurred, we need to handle the error
                                                                                  // See: https://developers.facebook.com/docs/ios/errors
                                                                                  NSLog(@"Encountered an error requesting permissions: %@", error.description);
                                                                              }
                                                                          }];
                                      
                                  } else {
                                      // Permissions present, publish the OG story
                                      [self stageImage];
                                  }
                                  
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                                  NSLog(@"Encountered an error checking permissions: %@", error.description);
                              }
                          }];
}

-(void)stageImage{
    // download the image asynchronously
    if (![self.film.poster  isEqual: @"N/A"]) {
        [self downloadImageWithURL:[NSURL URLWithString:self.film.poster] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                
                // stage an image
                [FBRequestConnection startForUploadStagingResourceWithImage:image completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if(!error) {
                        // Log the uri of the staged image
                        NSLog(@"Successfuly staged image with staged URI: %@", [result objectForKey:@"uri"]);
                        
                        // Further code to post the OG story goes here
                        
                    } else {
                        // An error occurred
                        NSLog(@"Error staging an image: %@", error);
                    }
                }];
                
            }
        }];
    }
}


// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
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
