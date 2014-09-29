//
//  FilmListViewController.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseViewController.h"

@interface FilmListViewController : BaseViewController

@property(nonatomic,weak)IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *masterFilmList;

@end
