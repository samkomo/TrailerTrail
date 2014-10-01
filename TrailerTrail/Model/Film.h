//
//  Film.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseEntity.h"

@interface Film : BaseEntity <NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSMutableArray *films;

-(instancetype) initWithAttributes: (NSDictionary *)attributes;
@end
