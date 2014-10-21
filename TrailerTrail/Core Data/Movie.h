//
//  Movie.h
//  TrailerTrail
//
//  Created by Sammy on 10/19/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * imdbID;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * poster;
@property (nonatomic, retain) NSString * starRating;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * runtime;
@property (nonatomic, retain) NSString * attribute;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * plot;
@property (nonatomic, retain) NSString * released;

@end
