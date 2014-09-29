//
//  ViewController.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "ViewController.h"
#import "FilmDataService.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSMutableArray *)masterFilmList{
    if (!_masterFilmList) {
        _masterFilmList = [[NSMutableArray alloc] init];
        
    }
    return _masterFilmList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
<<<<<<< HEAD
    FilmDataService *service = [[FilmDataService alloc] init];
    self.masterFilmList = [service selectFromJSon:@"s=True%20Grit&y=1969"];
=======
    [self showActivityIndicator];

    
    [self fetchData:@"t=True%20Grit"];
>>>>>>> FETCH_HEAD
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD
-(void)fetchData: (NSString *)menuItem{
    [self showActivityIndicator];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ArticleDataService  *service = [[ArticleDataService alloc] init];
        AdsDataService *ads_svc = [[AdsDataService alloc] init];
        self.stories = [service SelectFromJSon:menuItem.lowercaseString];
        self.adverts = [ads_svc SelectFromJSon:1];
=======

-(void)fetchData: (NSString *)parameters{
    [self showActivityIndicator];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FilmDataService  *service = [[FilmDataService alloc] init];
        self.masterFilmList = [service selectFromJSon:parameters];
>>>>>>> FETCH_HEAD
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
<<<<<<< HEAD
            [self showProgressHUDCompleteMessage: (self.stories.count == 0) ? NSLocalizedString(@"Failed, Error in connection", @"Informing the user a process has failed") : nil];
=======
            [self showProgressHUDCompleteMessage: (self.masterFilmList.count == 0) ? NSLocalizedString(@"No Internet connection", @"Informing the user a process has failed") : nil];
>>>>>>> FETCH_HEAD
            
            [self.myTableView reloadData];
            
        });
        
    });
    
}

@end
