//
//  FilmListViewController.h
//  TrailerTrail
//
//  Created by ilabadmin on 9/29/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController
{
    
    MBProgressHUD *_progressHUD;
}


-(void)hideKeyboard;
-(void) addDropShadowForView:(UIView *)aView;

-(void)showActivityIndicator;
-(void)hideActivityIndicator;

-(void)hideProgressHUD:(BOOL)animated;
-(void)showProgressHUDCompleteMessage:(NSString *)message;
-(void)showProgressHUDWithMessage:(NSString *)message;
- (void)showProgressHUDWithSuccess:(NSString *)message;

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;


//banner methods
- (void)createBannerView;
- (void)showBanner;
- (void)hideBanner;
- (void)releaseBanner;
@end
