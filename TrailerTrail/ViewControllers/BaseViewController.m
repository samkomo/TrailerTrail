//
//  FilmListViewController.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface BaseViewController ()


@end

@implementation BaseViewController



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    //add gesture recognizer to hide keyboard when tapping outside a textfield
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.view addGestureRecognizer:gestureRecognizer];
    
    
    self.view.backgroundColor = [self loadBackgroundColor];
    
    
}



#pragma mark custom functions



//viewcontrollers that need to hide the keyboard when tapping outside a textfield should override this method
-(void)hideKeyboard{}





//disable rotation

//iOS 6
-(BOOL)shouldAutorotate{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

//iOS 5
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return NO;
}




-(UIColor *)loadBackgroundColor{
    
    UIImage *imgBg = nil;
    
    imgBg = [UIImage imageNamed:@"gradientBg.png"];
    
    return [UIColor colorWithPatternImage:imgBg];
}


//Utility Functions

-(void) addDropShadowForView:(UIView *)aView{
    
    //add drop shadow
    aView.layer.shadowColor = [[UIColor blackColor] CGColor];
    aView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    aView.layer.shadowRadius = 2.0f;
    aView.layer.shadowOpacity = 0.25f;
}



#pragma mark - MBProgressHUD

- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.minSize = CGSizeMake(120, 120);
        _progressHUD.minShowTime = 1;
        // The sample image is based on the
        // work by: http://www.pixelpressicons.com
        // licence: http://creativecommons.org/licenses/by/2.5/ca/
        self.progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)showProgressHUDWithSuccess:(NSString *)message  {
    self.progressHUD.labelText = message;
    self.progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    [self.progressHUD show:YES];
    [self.progressHUD hide:YES afterDelay:1.5];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)showProgressHUDWithMessage:(NSString *)message {
    self.progressHUD.labelText = message;
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.progressHUD show:YES];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)hideProgressHUD:(BOOL)animated {
    [self.progressHUD hide:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void)showProgressHUDCompleteMessage:(NSString *)message {
    if (message) {
        if (self.progressHUD.isHidden) [self.progressHUD show:YES];
        self.progressHUD.labelText = message;
        self.progressHUD.mode = MBProgressHUDModeCustomView;
        [self.progressHUD hide:YES afterDelay:1.5];
    } else {
        [self.progressHUD hide:YES];
    }
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

-(void)showActivityIndicator{
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self showProgressHUDWithMessage:[NSString stringWithFormat:@"%@\u2026" , NSLocalizedString(@"Retreiving films", @"Displayed with ellipsis as 'retrieve...' when an item is in the process of being retrieved")]];
    
}

-(void)hideActivityIndicator{
    
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self showProgressHUDCompleteMessage:NSLocalizedString(@"Finished", @"Informing the user a process has finished")];
    //    [self hideProgressHUD:NO];
    
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if ( !error ){
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

@end
