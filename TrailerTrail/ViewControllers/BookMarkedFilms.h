//
//  BookMarkedFilms.h
//  TrailerTrail
//
//  Created by ilabadmin on 10/1/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BaseViewController.h"
#import "RatingView.h"
#import "PreviewFilm.h"
#import "Movie.h"

@interface BookMarkedFilms : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    RatingView *starView;
    
}

@property(nonatomic,weak)IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray *masterFilmList;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//core data
@property (nonatomic,strong)NSArray* fetchedRecordsArray;


-(void)ratingChanged:(float)newRating;

-(Movie *)objectInListAtIndex:(NSUInteger)theIndex;

@end
