//
//  BookMarkedFilms.m
//  TrailerTrail
//
//  Created by ilabadmin on 10/1/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "BookMarkedFilms.h"
#import "BodyViewCell.h"
#import "PreviewFilm.h"
#import "FilmDetailViewController.h"

#import "AppDelegate.h"
#import "Movie.h"

@implementation BookMarkedFilms
@synthesize managedObjectContext = _managedObjectContext;

-(NSMutableArray *)masterFilmList{
    if (!_masterFilmList) {
        _masterFilmList = [[NSMutableArray alloc] init];
        
    }
    return _masterFilmList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"BookMarked Films";
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //  1
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    //fetch data
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.masterFilmList = [[appDelegate getAllPhoneBookRecords] mutableCopy];
    [self.myTableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.masterFilmList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    BodyViewCell *cell = nil;
    
    if (cell==nil) {
        cell = [[BodyViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Movie *movie = self.masterFilmList[indexPath.row];
    
    
    cell.backgroundColor = [UIColor clearColor];
    // set default user image while image is being downloaded
    [cell imgTopStory].image = [UIImage imageNamed:@"noImageAvailable.png"];
    
    
    // download the image asynchronously
    if (![movie.poster  isEqual: @"N/A"]) {
        [self downloadImageWithURL:[NSURL URLWithString:movie.poster] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                [cell imgTopStory].image = image;
                
            }
        }];
    }
    
    [[cell titleLabel] setText:movie.title];
    [[cell languageLabel] setText:movie.language];
    [[cell typeLabel] setText:movie.year];
    
    [[cell starView] setImagesDeselected:@"0.png" partlySelected:@"Red_star" fullSelected:@"Red_star" andDelegate:self];
	[[cell starView] displayRating:([movie.starRating intValue]%5)];
    
    
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.myTableView.separatorColor = [UIColor whiteColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    static NSString *CellIdentifier = @"cell";
    
    
    return 110;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self performSegueWithIdentifier:@"showBookmark" sender:self];
    
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        [self showActivityIndicator];
//        
//        //delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//        [self.managedObjectContext deleteObject:[self.masterFilmList objectAtIndex:indexPath.row]];
//        NSError *error;
//        if (![self.managedObjectContext save:&error]) {
//            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//        }
//        
//        
//        PreviewFilm *film1 = [[PreviewFilm alloc] init];
//        film1.bookmarkedFilms = [[NSMutableArray alloc] init];
//        
//        [film1.bookmarkedFilms addObject:self.masterFilmList];
//        [film1 saveLocally];
//        
//        [self showProgressHUDWithSuccess:@"Deleted Successfully!"];
//
//        
//        
//    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //    1
        [tableView beginUpdates];
        // Delete the row from the data source
        
        //    2
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //    3
        [self.managedObjectContext deleteObject:[self.masterFilmList objectAtIndex:indexPath.row]];
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        //    4
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        self.masterFilmList = [[appDelegate getAllPhoneBookRecords]mutableCopy];
        //    5
        [tableView endUpdates];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showBookmark"]){
        
        [(FilmDetailViewController *)segue.destinationViewController setFilm:[self objectInListAtIndex:[self.myTableView indexPathForSelectedRow].row]];
        
    }
}



-(PreviewFilm *)objectInListAtIndex:(NSUInteger)theIndex
{
    return [self.masterFilmList objectAtIndex:theIndex];
}





-(void)ratingChanged:(float)newRating {
    //	ratingLabel.text = [NSString stringWithFormat:@"Rating is: %1.1f", newRating];
}


@end
