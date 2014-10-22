//
//  TheMapViewController.m
//  AnimalGuide
//
//  Created by Apple on 6/21/13.
//  Copyright (c) 2013 Fahari Technologies - (Dev Karumba). All rights reserved.
//

#import "TheMapViewController.h"
#import "REVMapViewController.h"

@interface TheMapViewController ()
{
    //MapViewController *_mapViewController;

}
@end

@implementation TheMapViewController

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
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"-1.2833",@"latitude",@"36.8167",@"longitude",nil];
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:@"0.0510",@"latitude",@"40.3140",@"longitude",nil];
    
    NSDictionary *dic3=[NSDictionary dictionaryWithObjectsAndKeys:@"0.3667",@"latitude",@"36.0833",@"longitude",nil];
    
    NSDictionary *dic4=[NSDictionary dictionaryWithObjectsAndKeys:@"0.0500",@"latitude",@"37.6500",@"longitude",nil];
    
    NSDictionary *dic5=[NSDictionary dictionaryWithObjectsAndKeys:@"0.0600",@"latitude",@"37.6600",@"longitude",nil];

    NSArray *array = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    
    REVMapViewController *browser = [[REVMapViewController alloc] init];

    [self.view addSubview:browser.view];
    //[browser.view setFrame:self.view.bounds];
    [browser setAnnotionsWithList:array];

    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:nc animated:YES];
}

- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
