//
//  MapDataModel.h
//  AnimalGuide
//
//  Created by Apple on 6/23/13.
//  Copyright (c) 2013 Fahari Technologies - (Dev Karumba). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapDataModel : NSObject
{
    NSInteger mapID;
    NSNumber *latitude;
    NSNumber *longitude;
    NSString *title;
    NSString *subTitle;
}

@property (assign, nonatomic, readwrite) NSInteger mapID;
@property (copy, nonatomic, readwrite) NSNumber *latitude;
@property (copy, nonatomic, readwrite) NSNumber *longitude;
@property (retain, nonatomic, readwrite) NSString *title;
@property (retain, nonatomic, readwrite) NSString *subTitle;

-(id)initWithPrimaryKey:(NSInteger)pk;
@end
