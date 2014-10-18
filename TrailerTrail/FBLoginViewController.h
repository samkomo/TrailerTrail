//
//  FBViewController.h
//  TrailerTrail
//
//  Created by Sammy on 10/15/14.
//  Copyright (c) 2014 Maginnovate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FBLoginViewController : BaseViewController <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBLoginView *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

- (IBAction)launchApplication:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnProceed;
@end
