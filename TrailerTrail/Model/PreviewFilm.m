//
//  PreviewFilm.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "PreviewFilm.h"
#import "utilities.h"




static NSMutableArray *_bookmark;


@implementation PreviewFilm
@synthesize rated=_rated, released=_released, runtime=_runtime, director=_director, writer=_writer, plot=_plot, poster=_poster, language=_language, imdbVotes=_imdbVotes, genre=_genre, starRating =_starRating;

-(NSMutableArray *) previewFilms{
    if(!_previewFilms){
        _previewFilms = [[NSMutableArray alloc] init];
    }
    return _previewFilms;
}

-(NSMutableArray *)bookmarkedFilms{
    
    if (!_bookmarkedFilms) {
        _bookmarkedFilms = [[NSMutableArray alloc] init];
    }
    return _bookmarkedFilms;
}

-(instancetype) initWithAttributes:(NSDictionary *)attributes{
    self = [ super initWithAttributes:attributes];
    
    if (self){
        
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

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.rated = [aDecoder decodeObjectForKey:kRated];
        self.released = [aDecoder decodeObjectForKey:kReleased];
        self.runtime = [aDecoder decodeObjectForKey:kRuntime];
        self.director = [aDecoder decodeObjectForKey:kDirector];
        self.writer = [aDecoder decodeObjectForKey:kWriter];
        self.plot = [aDecoder decodeObjectForKey:kPlot];
        self.poster = [aDecoder decodeObjectForKey:kPoster];
        self.language = [aDecoder decodeObjectForKey:kLanguage];
        self.imdbVotes = [aDecoder decodeObjectForKey:kimdbVotes];
        self.genre = [aDecoder decodeObjectForKey:kGenre];
        self.starRating = [aDecoder decodeObjectForKey:kImdbRating];
        
	}
	
	return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_rated forKey:kRated];
	[aCoder encodeObject:_released forKey:kReleased];
	[aCoder encodeObject:_runtime forKey:kRuntime];
	[aCoder encodeObject:_director forKey:kDirector];
	[aCoder encodeObject:_writer forKey:kWriter];
	[aCoder encodeObject:_plot forKey:kPlot];
	[aCoder encodeObject:_poster forKey:kPoster];
	[aCoder encodeObject:_language forKey:kLanguage];
    [aCoder encodeObject:_imdbVotes forKey:kimdbVotes];
    [aCoder encodeObject:_genre forKey:kGenre];
    [aCoder encodeObject:_starRating forKey:kImdbRating];
}


+(NSMutableArray *)getAllBookmarkedFilms{
    if (_bookmark == nil) {
        _bookmark = [PreviewFilm unarchive];
    }
    
    if (_bookmark == nil) {
        _bookmark = [[NSMutableArray alloc] init];
    }
    
    return _bookmark;
}

-(BOOL)deleteStack:(PreviewFilm *)film{
    
    BOOL success = NO;
    
    if (_bookmarkedFilms != nil) {
        if ([_bookmarkedFilms indexOfObject:film] != NSNotFound) {
            [_bookmarkedFilms removeObject:film];
            success = YES;
        }
    }
    
    return success;
}


+(id) unarchive{
	NSString *filePath = [Utilities dataFilePathForFile:kBookMark];
	
	NSMutableArray *arrBookmarkedFilms = nil;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData* decodedData = [NSData dataWithContentsOfFile: [Utilities dataFilePathForFile:kBookMark]];
        if (decodedData) {
            PreviewFilm* filmData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
            return filmData;
        }

		
    }
	
	return arrBookmarkedFilms;
}




+(void) archive{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[archiver encodeObject:self forKey:kBookMark];
	[archiver finishEncoding];
	
	[data writeToFile:[Utilities dataFilePathForFile:kBookMark] atomically:YES];
	
}

+ (instancetype)sharedFilmData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}


+(instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [Utilities dataFilePathForFile:kBookMark]];
    if (decodedData) {
        PreviewFilm* filmData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return filmData;
    }
    
    return [[PreviewFilm alloc] init];
}

-(void)saveLocally
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self.bookmarkedFilms];
    [encodedData writeToFile:[Utilities dataFilePathForFile:kBookMark] atomically:YES];
}
@end
