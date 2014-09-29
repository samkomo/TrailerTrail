//
//  FilmListViewController.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "FilmListViewController.h"
#import "FilmDataService.h"

@implementation FilmListViewController

-(NSMutableArray *)masterFilmList{
    if (!_masterFilmList) {
        _masterFilmList = [[NSMutableArray alloc] init];
        
    }
    return _masterFilmList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self showActivityIndicator];
    
    
    [self fetchData:@"s=True%20Grit"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)fetchData: (NSString *)parameters{
    [self showActivityIndicator];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FilmDataService  *service = [[FilmDataService alloc] init];
        self.masterFilmList = [service selectFromJSon:parameters];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self showProgressHUDCompleteMessage: (self.masterFilmList.count == 0) ? NSLocalizedString(@"No Internet connection", @"Informing the user a process has failed") : nil];
            
            [self.myTableView reloadData];
            
        });
        
    });
    
}

@end
