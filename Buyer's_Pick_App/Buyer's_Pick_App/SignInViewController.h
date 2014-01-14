//
//  SignInViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"

@interface SignInViewController : DatabaseClass
{
    bool			stricterFilter;

}
@property (strong, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UIView *signUpbgView;
- (IBAction)signInButton:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)resendActivationEmail:(id)sender;
@end
