//
//  PreviewFilm.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "Film.h"

@interface PreviewFilm : Film <NSCoding>

@property (strong, nonatomic) NSString *rated;
@property (strong, nonatomic) NSString *released;
@property (strong, nonatomic) NSString *runtime;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *writer;
@property (strong, nonatomic) NSString *plot;
@property (strong, nonatomic) NSString *poster;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *imdbVotes;
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) NSString *starRating;

@property (strong, nonatomic) NSMutableArray *previewFilms;
@property (strong, nonatomic) NSMutableArray *bookmarkedFilms;

+(NSMutableArray *) getAllBookmarkedFilms;
-(void) archive;
+(id) unarchive;

+ (instancetype)sharedFilmData;
@end
