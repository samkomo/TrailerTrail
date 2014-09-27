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
        self.year =[[attributes objectForKey:kImdbID] integerValue];
//        self.year =[self extracIntegerValue:[attributes objectForKey:kYear]];
        self.type =[attributes objectForKey:kType];
    }
    
    return self;
    
}
@end
