//
//  FilmListViewController.m
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import "FilmListViewController.h"
#import "FilmDataService.h"
#import "BodyViewCell.h"
#import "PreviewFilm.h"
#import "FilmDetailViewController.h"

@implementation FilmListViewController
@synthesize searchBar = _searchBar;

-(NSMutableArray *)masterFilmList{
    if (!_masterFilmList) {
        _masterFilmList = [[NSMutableArray alloc] init];
        
    }
    return _masterFilmList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Latest Films";
    
    [self showActivityIndicator];
    
    
    [self fetchData:@"s=True%20Grit"];
    
    //create a tapgesture to release keyboard on tap
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.myTableView addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    [tap setDelaysTouchesEnded:NO];
    
//    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchBar methods

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar  {
	NSString *text=self.searchBar.text;
    
    //prepare string for searching
	text = [text lowercaseString];
	text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self fetchData:[NSString stringWithFormat:@"s=%@",text]];
    
    [self.searchBar resignFirstResponder];
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
    
    PreviewFilm *movie = ((PreviewFilm * )self.masterFilmList[indexPath.row]);
    
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
    [[cell timeLabel] setText:movie.type];
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
    
    [self performSegueWithIdentifier:@"showDetails" sender:self];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showDetails"]){
        
        
        [(FilmDetailViewController *)segue.destinationViewController setFilm:[self objectInListAtIndex:[self.myTableView indexPathForSelectedRow].row]];
        
        NSLog(@"%d",[self.myTableView indexPathForSelectedRow].row);
        
    }
}

-(void)fetchData: (NSString *)parameters{
    [self showActivityIndicator];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FilmDataService  *service = [[FilmDataService alloc] init];
        self.masterFilmList = [service selectFromJSon:parameters];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self showProgressHUDCompleteMessage: (self.masterFilmList.count == 0) ? NSLocalizedString(@"No films found!", @"Informing the user a process has failed") : nil];
            
//            [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//            noResultText = NSLocalizedString(@"No results for:", "No results for:");
//            noResultText = [noResultText stringByAppendingString:@" "];
//            noResultText = [noResultText stringByAppendingString:searchBar.text];
//            tryGoogle= NSLocalizedString(@"Try searching with Google (online).", "Try searching with Google (online).");
//            imgGoogleName=@"iPhoneIconGoogleLogo.png";
//            isSearching=true;
//            [self.myTableView reloadData];
//            rowHeight = NO;
            
            [self.myTableView reloadData];
            
        });
        
    });
    
}

-(PreviewFilm *)objectInListAtIndex:(NSUInteger)theIndex
{
    return [self.masterFilmList objectAtIndex:theIndex];
}




-(void)hideKeyboard{
    [self.searchBar resignFirstResponder];
}

@end
