//
//  ViewController.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/26/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseViewController.h"

@interface ViewController : BaseViewController

@property(nonatomic,weak)IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *masterFilmList;

@end

