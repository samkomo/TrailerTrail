//
//  StoresMapViewController.m
//  TrailerTrail
//
//  Created by ilabadmin on 10/22/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "StoresMapViewController.h"

@interface StoresMapViewController ()

@end

@implementation StoresMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    mapViewer = [[REVMapViewController alloc] init];
    
//    self.view.array = array;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"-1.2833",@"latitude",@"36.8167",@"longitude",nil];
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:@"0.0510",@"latitude",@"40.3140",@"longitude",nil];
    
    NSDictionary *dic3=[NSDictionary dictionaryWithObjectsAndKeys:@"0.3667",@"latitude",@"36.0833",@"longitude",nil];
    
    NSDictionary *dic4=[NSDictionary dictionaryWithObjectsAndKeys:@"0.0500",@"latitude",@"37.6501",@"longitude",nil];
    
    NSDictionary *dic5=[NSDictionary dictionaryWithObjectsAndKeys:@"0.1500",@"latitude",@"37.6500",@"longitude",nil];
    
    NSArray *array1 = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4, dic5, nil];
    
    [self setAnnotionsWithList:array1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
