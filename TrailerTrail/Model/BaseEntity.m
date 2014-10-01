//
//  BaseEntity.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseEntity.h"
#import "Utilities.h"

@implementation BaseEntity


#pragma mark Utility functions

-(NSUInteger)extracIntegerValue:(NSString *)value{
    
    NSInteger integerValue = -1;
    
    if (value != nil && ![value isEqual:[NSNull null]]) {
        integerValue = [value integerValue];
    }
    
    return integerValue;
    
}


-(BOOL)extractBooleanValue:(NSString *)value{
    
    BOOL boolValue = NO;
    
    if (value != nil && ![value isEqual:[NSNull null]]) {
        boolValue = [value boolValue];
    }
    
    return boolValue;
    
}



-(NSDictionary *)serialize{
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

-(id)getValue:(id)value{
    
    if (value == nil) {
        return [NSNull null];
    }
    else{
        return value;
    }
}

-(void)saveLocally{}

@end
