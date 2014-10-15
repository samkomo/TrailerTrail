//
//  AppDelegate.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableData *_responseData;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

+ (NSURLConnection*)initiateURLConnection:(NSURL*)jsonUrl;

-(NSArray*)getAllPhoneBookRecords;

@end

