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
    
    FilmDataService *service = [[FilmDataService alloc] init];
    self.masterFilmList = [service selectFromJSon:@"s=True%20Grit&y=1969"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchData: (NSString *)menuItem{
    [self showActivityIndicator];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ArticleDataService  *service = [[ArticleDataService alloc] init];
        AdsDataService *ads_svc = [[AdsDataService alloc] init];
        self.stories = [service SelectFromJSon:menuItem.lowercaseString];
        self.adverts = [ads_svc SelectFromJSon:1];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self showProgressHUDCompleteMessage: (self.stories.count == 0) ? NSLocalizedString(@"Failed, Error in connection", @"Informing the user a process has failed") : nil];
            
            [self.myTableView reloadData];
            
        });
        
    });
    
}

@end
