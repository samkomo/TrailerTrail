//
//  FilmDetailsViewController.h
//  TrailerTrail
//
//  Created by Sammy on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FilmDetailsViewController : BaseViewController

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
- (IBAction)playMovie:(id)sender;

@end
