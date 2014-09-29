//
//  ArticleDataService.h
//  StandardGroup
//
//  Created by Apple on 9/4/13.
//  Copyright (c) 2013 fahari. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"

@interface FilmDataService : NSObject
{
    AppDelegate *delegate;
    NSURLConnection *conn;
}

@property (nonatomic,retain) AppDelegate *delegate;

-(NSMutableArray *) selectFromJSon:(NSString*)title;
+(NSString *)baseAPIUrl;
-(NSString *) getJsonDataString: (NSString *)urlParam;
@end
