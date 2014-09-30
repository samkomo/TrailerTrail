//
//  PreviewFilm.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "PreviewFilm.h"

//tags to retrieve contents from the api items
#define kRated @"Rated"
#define kReleased @"Released"
#define kRuntime @"Runtime"
#define kDirector @"Director"
#define kWriter @"Writer"
#define kActors @"Actors"
#define kPlot @"Plot"
#define kPoster @"Poster"
#define kLanguage @"Language"
#define kimdbVotes @"imdbVotes"
#define kGenre @"Genre"
#define kImdbRating @"imdbRating"

//tags to retrieve contents from the api items
#define kTitle @"Title"
#define kImdbID @"imdbID"
#define kType @"Type"
#define kYear @"Year"

@implementation PreviewFilm
@synthesize rated=_rated, released=_released, runtime=_runtime, director=_director, writer=_writer, plot=_plot, poster=_poster, language=_language, imdbVotes=_imdbVotes, genre=_genre, starRating =_starRating;

-(NSMutableArray *) previewFilms{
    if(!_previewFilms){
        _previewFilms = [[NSMutableArray alloc] init];
    }
    return _previewFilms;
}

-(instancetype) initWithAttributes:(NSDictionary *)attributes{
    self = [ super init];
    
    if (self){
        
        self.title = [attributes objectForKey:kTitle];
        self.imdbID =[attributes objectForKey:kImdbID];
        self.year =[attributes objectForKey:kYear];
        self.type =[attributes objectForKey:kType];
        self.rated =[attributes objectForKey:kRated];
        self.released =[attributes objectForKey:kReleased];
        self.runtime =[attributes objectForKey:kRuntime];
        self.director =[attributes objectForKey:kDirector];
        self.writer =[attributes objectForKey:kWriter];
        self.plot =[attributes objectForKey:kPlot];
        self.poster =[attributes objectForKey:kPoster];
        self.language =[attributes objectForKey:kLanguage];
        self.imdbVotes =[attributes objectForKey:kimdbVotes];
        self.genre =[attributes objectForKey:kGenre];
        self.starRating =[attributes objectForKey:kImdbRating];
    }
    return self;
}
@end
