//
//  MapDataModel.m
//  AnimalGuide
//
//  Created by Apple on 6/23/13.
//  Copyright (c) 2013 Fahari Technologies - (Dev Karumba). All rights reserved.
//

#import "MapDataModel.h"

@implementation MapDataModel
@synthesize latitude,longitude,title,subTitle,mapID;

-(id)initWithPrimaryKey:(NSInteger)pk
{
    self=[super init];
    if (self)
    {
        mapID=pk;
        return self;
    }
    return nil;
    
}

-(id) initWithJsonData:(NSDictionary *)jsonData
{
    self = [super init];
    if  (self)
    {
        self.title = [jsonData objectForKey:@"title"];
        self.subTitle = [jsonData objectForKey:@"subTitle"];
        self.latitude = [jsonData objectForKey:@"latitude"];
        self.longitude = [jsonData objectForKey:@"longitude"];
        self.mapID = [[jsonData objectForKey:@"mapID"] integerValue];
        
    }
    
    return self;
}

@end
