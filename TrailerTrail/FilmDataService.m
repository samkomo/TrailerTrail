//
//  ArticleDataService.m
//  StandardGroup
//
//  Created by Apple on 9/4/13.
//  Copyright (c) 2013 fahari. All rights reserved.
//

#import "FilmDataService.h"
#import "JSONKit.h" 
//#import "AppDelegate.h"
#import "PreviewFilm.h"

#define kBaseAPIUrl @"BaseAPIUrl"


@implementation FilmDataService
@synthesize delegate=_degate;

//retrieve search data from API
-(NSMutableArray *) selectFromJSon:(NSString*)title
{
    NSMutableArray *masterList= [[NSMutableArray alloc] init];
    
    
//    NSURL *jsonUrl = [NSURL URLWithString:[LOCAL_SERVER_URL stringByAppendingString:category]];

    NSString *url = [FilmDataService baseAPIUrl];
    
//    url = [url stringByReplacingOccurrencesOfString:@"kenya" withString:category];
    url = [url stringByAppendingString:title];

    NSURL *jsonUrl = [NSURL URLWithString:url];

    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    if (conn == nil) {
        conn = [AppDelegate initiateURLConnection:jsonUrl];
    }
    NSError *error = nil;

    NSString *json = [NSString stringWithContentsOfURL:jsonUrl encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *dict = nil;
    if (json) {
        dict = [NSJSONSerialization JSONObjectWithData:[self getSimpleJSON:json] options:kNilOptions error:&error];
    }
    
    
    if (dict) {
        
        for (int i = 0; i<[dict count]; i++) {
            PreviewFilm * newDataModel = [[PreviewFilm alloc] initWithAttributes:dict];
            [masterList addObject:newDataModel];
        }
        
    }

    return masterList;
    
}

+(NSString *)baseAPIUrl{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:kBaseAPIUrl];
    
}

- (NSData*) getSimpleJSON: (NSString *) jsonString{
    
    return  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
