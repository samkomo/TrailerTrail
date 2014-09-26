//
//  BaseEntity.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface BaseEntity : NSObject

-(NSUInteger)extracIntegerValue:(NSString *)value;
-(BOOL)extractBooleanValue:(NSString *)value;

-(NSDictionary *)serialize;
-(id)getValue:(id)value;

@end
