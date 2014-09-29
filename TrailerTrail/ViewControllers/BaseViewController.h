//
//  BaseViewController.h
//  TrailerTrail
//
//  Created by Rami Arafat on 12/26/12.
//  Copyright (c) 2012 Tanasuk - Rami Arafat. All rights reserved.
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




@end
