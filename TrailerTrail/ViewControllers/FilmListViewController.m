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
@synthesize searchBar = _searchBar, bannerView;

-(NSMutableArray *)masterFilmList{
    if (!_masterFilmList) {
        _masterFilmList = [[NSMutableArray alloc] init];
        
    }
    return _masterFilmList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Films";
    
    [self showActivityIndicator];
    
    
    [self fetchData:@"s=tom and jerry"];
    
    //create a tapgesture to release keyboard on tap
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.myTableView addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    [tap setDelaysTouchesEnded:NO];
    

    self.searchBar.tintColor = [UIColor redColor];
    
    [self createBannerView];
    [self.view bringSubviewToFront:bannerView];
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
    NSString *text = @"";
    text = self.searchBar.text;
    
    if ([self.masterFilmList count] == 0 && ![self.searchBar.text  isEqual: @""]) {
        return 1; // a single cell to report no data
    }
    return [self.masterFilmList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //text to show if no search result
    NSString *text = @"";
    text = self.searchBar.text;
    static NSString *CellIdentifier = @"cell";
    
    BodyViewCell *cell = nil;

    
    if (cell==nil) {
        cell = [[BodyViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([self.masterFilmList count] == 0 && ![self.searchBar.text  isEqual: @""]) {
        
        // Configure the cell...
        
        UILabel *imageView1;
        UILabel *lblTemp2;
        UIButton *buttonView3;
        
        //if(cell == nil)
        //{
        cell = [self getCellResultLView:CellIdentifier: tryGoogle];
        
		imageView1 = (UILabel *)[cell viewWithTag:1];
		lblTemp2 = (UILabel *)[cell viewWithTag:2];
		buttonView3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		buttonView3 =  (UIButton *)[cell viewWithTag:3];
        //}
        
        
        imageView1.text=noResultText;
        lblTemp2.text = tryGoogle;
        
        
        
        
        [buttonView3 setImage:[UIImage imageNamed:imgGoogleName] forState:UIControlStateNormal];
        [buttonView3 setTag:3];
        [buttonView3 addTarget:self action:@selector(searchGoogle:) forControlEvents:UIControlEventTouchUpInside];
        buttonView3.adjustsImageWhenHighlighted = YES;
        
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor clearColor];
        
        //whatever else to configure your one cell you're going to return
        return cell;
        
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
    
    [self performSegueWithIdentifier:@"showDetails" sender:self];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showDetails"]){
        
        
        [(FilmDetailViewController *)segue.destinationViewController setFilm:[self objectInListAtIndex:[self.myTableView indexPathForSelectedRow].row]];
        
        
    }
}

-(void)fetchData: (NSString *)parameters{
    [self showActivityIndicator];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FilmDataService  *service = [[FilmDataService alloc] init];
        self.masterFilmList = [service selectFromJSon:parameters];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self showProgressHUDCompleteMessage: (self.masterFilmList.count == 0) ? NSLocalizedString(@"No films found!", @"Informing the user a process has failed") : nil];
            
            [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            noResultText = NSLocalizedString(@"No results for:", "No results for:");
            noResultText = [noResultText stringByAppendingString:@" "];
            noResultText = [noResultText stringByAppendingString:self.searchBar.text];
            tryGoogle= NSLocalizedString(@"Try searching (online) with ", "Try searching (online) with ");
            imgGoogleName=@"iPhoneIconGoogleLogo.png";
            isSearching=true;
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

-(void)ratingChanged:(float)newRating {
//	ratingLabel.text = [NSString stringWithFormat:@"Rating is: %1.1f", newRating];
}

- (void) searchGoogle:(id)sender  {
	NSString *url = @"http://www.google.com/m/search?hl=en&q=";
	url = [url stringByAppendingString:self.searchBar.text];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


// creates a new table cell with image and label placeholders
- (UITableViewCell *) getCellResultLView:(NSString *)cellIdentifier :(NSString *) wText {
	
	CGRect CellFrame = CGRectMake(0.0, 0.0, 320.0, 45.0);
	
	
	CGSize constSize = {270 };
	CGSize wTextSize = [wText sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constSize lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect ImageFrame = CGRectMake(10.0, 30.0, wTextSize.width+5, 25.0);
	CGRect LabelFrame = CGRectMake(10.0, 80,wTextSize.width+5, 25.0);
	
	UILabel *lblTemp;
	UILabel *imgTemp;
	UIButton *buttonTemp;
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame];
	
	//Initialize Image with tag 1.
	imgTemp = [[UILabel alloc] initWithFrame:ImageFrame];
    [imgTemp setBackgroundColor:[UIColor clearColor]];
	imgTemp.tag = 1;
	[cell.contentView addSubview:imgTemp];
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:LabelFrame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont systemFontOfSize:15];
    [lblTemp setBackgroundColor:[UIColor clearColor]];
	[cell.contentView addSubview:lblTemp];
    
	//Initialize Label with tag 3.
	buttonTemp = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonTemp.frame = CGRectMake(200.0, 77.0, 60.0, 40.0);
	buttonTemp.tag = 3;
	[cell.contentView addSubview:buttonTemp];
	[cell.contentView setBackgroundColor:[UIColor clearColor]];
	return cell;
}


#pragma mark -
#pragma mark === Banner View Methods ===
#pragma mark -


- (void)createBannerView {
	
	Class cls = NSClassFromString(@"ADBannerView");
	if (cls) {
        
		ADBannerView *adView = [[cls alloc] initWithFrame:CGRectZero];
		adView.delegate = self;
		
		adView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
		
		// Set intital frame to be offscreen
		CGRect bannerFrame =adView.frame;
		bannerFrame.origin.y = - bannerFrame.size.height;
		adView.frame = bannerFrame;
		
		self.bannerView = adView;
		[self.view addSubview:adView];
	}
}



- (void)showBanner {
	
	CGFloat fullViewHeight = self.view.frame.size.height;
	CGRect tableFrame = self.myTableView.frame;
	CGRect bannerFrame = self.bannerView.frame;
    CGRect searchBarFrame = self.searchBar.frame;
	
	// Shrink the tableview to create space for banner
    
    tableFrame.size.height = fullViewHeight - (bannerFrame.size.height + searchBarFrame.size.height);
    searchBarFrame.origin.y = bannerFrame.size.height;
	tableFrame.origin.y = bannerFrame.size.height + searchBarFrame.size.height;
	
	// Move banner onscreen
	bannerFrame.origin.y = 0;
	
	[UIView beginAnimations:@"showBanner" context:NULL];
	self.bannerView.frame = bannerFrame;
    self.searchBar.frame = searchBarFrame;
    self.myTableView.frame = tableFrame;
    
	[UIView commitAnimations];
}

- (void)hideBanner {
	
	// Grow the tableview to occupy space left by banner
	CGFloat fullViewHeight = self.view.frame.size.height;
	CGRect tableFrame = self.myTableView.frame;
    CGRect searchBarFrame = self.searchBar.frame;
    
    tableFrame.size.height = fullViewHeight - searchBarFrame.size.height;
    searchBarFrame.origin.y = 0;
	tableFrame.origin.y = searchBarFrame.size.height;
	
	// Move the banner view offscreen
	CGRect bannerFrame = self.bannerView.frame;
	bannerFrame.origin.y = - bannerFrame.size.height;
	
	self.myTableView.frame = tableFrame;
	self.bannerView.frame = bannerFrame;
    self.searchBar.frame = searchBarFrame;
    
}

- (void)releaseBanner {
    
	if (self.bannerView) {
		bannerView.delegate = nil;
		self.bannerView = nil;
	}
}

- (void)changeBannerOrientation:(UIInterfaceOrientation)toOrientation {
	
	if (UIInterfaceOrientationIsLandscape(toOrientation)) {
		self.bannerView.currentContentSizeIdentifier =
		ADBannerContentSizeIdentifierPortrait;
	}
	else {
		self.bannerView.currentContentSizeIdentifier =
		ADBannerContentSizeIdentifierPortrait;
	}
}

#pragma mark -
#pragma mark === ADBannerViewDelegate Methods ===
#pragma mark -

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
	
	[self showBanner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
	
	[self hideBanner];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setSearchBar:nil];
    self.myTableView = nil;
    [self releaseBanner];
    
}

@end
