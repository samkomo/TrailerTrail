//
//  Utilities.m
//  7assoun
//
//  Created by Rami Arafat on 11/11/12.
//  Copyright (c) 2012 Rami Arafat. All rights reserved.
//

#import "Utilities.h"
#import <QuartzCore/QuartzCore.h>

#define kBaseAPIUrl @"BaseAPIUrl"
#define kBaseUploadUrl @"BaseUploadUrl"
#define kAudioFileMaxDuration @"AudioFileMaxDuration"
#define kAccessToken @"AccessToken"


@implementation Utilities

+(NSString *)tempFilesPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    NSString *draftsDirectoryPath = [documentsDirectoryPath stringByAppendingPathComponent:@"Temps"];
    
    
    //double check that directory exists. If not, create it.
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:draftsDirectoryPath]) {
        
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:draftsDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"Could not create directory: %@", [error localizedDescription]);
        }
    }
    
    return draftsDirectoryPath;
}




+(NSString *)baseAPIUrl{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:kBaseAPIUrl];
    
}


+(NSString *)baseUploadUrl{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:kBaseUploadUrl];
    
}




+(NSString *)generateUUID{
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    
    CFRelease(uuid);
    
    return uuidStr;
}




+ (NSString *)dataFilePathForFile:(NSString *)file {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	return [documentsDirectory stringByAppendingPathComponent:file];
}





+(NSInteger)AudioFileMaxDuration{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [[infoDictionary objectForKey:kAudioFileMaxDuration] integerValue];

}




+(void)saveSessionId:(NSString *)sessionId{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sessionId forKey:kAccessToken];
}


+(NSString *)sessionId{
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //return [defaults objectForKey:kAccessToken];
    
    
    //TODO: use saved token
    return @"YYsSGtXsFBYTQABLc3o7pN1TZRjuqjHP2O5eJysdcV0mYsDz9cpm6GAkl1Y796NH";
}

@end
