//
//  FilmListViewController.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseViewController.h"
#import "RatingView.h"
#import "PreviewFilm.h"

@interface FilmListViewController : BaseViewController
{
    RatingView *starView;
    NSString *noResultText;
    NSString *tryGoogle;
    NSString *imgGoogleName;
    BOOL isSearching;

}
@property(nonatomic,weak)IBOutlet UITableView *myTableView;
@property (weak , nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *masterFilmList;

-(void)ratingChanged:(float)newRating;

-(PreviewFilm *)objectInListAtIndex:(NSUInteger)theIndex;
@end
