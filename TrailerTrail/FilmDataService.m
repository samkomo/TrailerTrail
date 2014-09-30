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
#import "Film.h"
#import "PreviewFilm.h"

#define kBaseAPIUrl @"BaseAPIUrl"


@implementation FilmDataService
@synthesize delegate=_degate;

//retrieve search data from API
-(NSMutableArray *) selectFromJSon:(NSString*)title
{
    NSMutableArray *masterList= [[NSMutableArray alloc] init];
    
    NSString *s_json = [self getJsonDataString:title];
    NSError *error = nil;
    
    if ([self getSimpleJSON:s_json]) {
        NSDictionary *s_dict = [NSJSONSerialization JSONObjectWithData:[self getSimpleJSON:s_json] options:kNilOptions error:&error];
        
        NSArray *searchResult = [s_dict objectForKeyedSubscript:@"Search"];
        
        
        if ([searchResult count])
        {
            
            for (NSDictionary *movie in searchResult) {
                if (movie) {
                    Film * newDataModel = [[Film alloc] initWithAttributes:movie];
                    
                    NSString *i_json = [self getJsonDataString:[NSString stringWithFormat:@"i=%@",newDataModel.imdbID]];
                    if ([self getSimpleJSON:i_json]) {
                        NSDictionary *i_Dict = [NSJSONSerialization JSONObjectWithData:[self getSimpleJSON:i_json] options:kNilOptions error:&error];
                        
                        PreviewFilm *i_film = [[PreviewFilm alloc] initWithAttributes:i_Dict];
                        
                        [masterList addObject:i_film];
                    }
                    
                    
                    
                    
                }
                
            }
            
            
        }

    }
    
    return masterList;
    
}

-(NSString *)getJsonDataString:(NSString *)urlParam{
    NSString *jsonString = @"";
    
    NSString *url = [FilmDataService baseAPIUrl];
    
    url = [url stringByAppendingString:urlParam];
    
    NSURL *jsonUrl = [NSURL URLWithString:url];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (conn == nil) {
        conn = [AppDelegate initiateURLConnection:jsonUrl];
    }
    
    NSError *error = nil;
    jsonString= [NSString stringWithContentsOfURL:jsonUrl encoding:NSUTF8StringEncoding error:&error];
    
    
    return jsonString;
    
}

+(NSString *)baseAPIUrl{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:kBaseAPIUrl];
    
}

- (NSData*) getSimpleJSON: (NSString *) jsonString{
    
    return  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
