//
//  Film.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "Film.h"


//tags to retrieve contents from the api items
#define kTitle @"Title"
#define kImdbID @"imdbID"
#define kType @"Type"
#define kYear @"Year"


@implementation Film
@synthesize title = _title,year=_year, imdbID=_imdbID, type=_type;

-(NSMutableArray *)films{
    if (!_films){
        _films = [[NSMutableArray alloc] init];
    }
    return _films;
}

-(instancetype) initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    
    if (self){
        self.title = [attributes objectForKey:kTitle];
        self.imdbID =[attributes objectForKey:kImdbID];
        self.year =[attributes objectForKey:kYear];
        self.type =[attributes objectForKey:kType];
    }
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.title = [aDecoder decodeObjectForKey:kTitle];
        self.imdbID = [aDecoder decodeObjectForKey:kImdbID];
        self.year = [aDecoder decodeObjectForKey:kYear];
        self.type = [aDecoder decodeObjectForKey:kType];
        
	}
	
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_title forKey:kTitle];
    [aCoder encodeObject:_imdbID forKey:kImdbID];
    [aCoder encodeObject:_year forKey:kYear];
    [aCoder encodeObject:_type forKey:kType];
    
}


@end
