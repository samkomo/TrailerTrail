//
//  Utilities.h
//  7assoun
//
//  Created by Rami Arafat on 11/11/12.
//  Copyright (c) 2012 Rami Arafat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSString *)tempFilesPath;
+(NSInteger)AudioFileMaxDuration;

+(NSString *)generateUUID;

+ (NSString *)dataFilePathForFile:(NSString *)file;

+(NSString *)baseAPIUrl;
+(NSString *)baseUploadUrl;


+(void)saveSessionId:(NSString *)sessionId;
+(NSString *)sessionId;


@end
