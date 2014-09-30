//
//  FilmListViewController.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseViewController.h"
#import "RatingView.h"

@interface FilmListViewController : BaseViewController
{
    RatingView *starView;

}
@property(nonatomic,weak)IBOutlet UITableView *myTableView;
@property (weak , nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *masterFilmList;

-(void)ratingChanged:(float)newRating; -(void) createSearchBar;

@end
