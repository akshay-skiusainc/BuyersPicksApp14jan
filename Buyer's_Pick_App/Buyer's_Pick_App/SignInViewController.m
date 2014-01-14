//
//  SignInViewController.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize emailIdTextField,passwordTextField,signInButton,signUpbgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_v.jpg"]];
        
        signUpbgView.frame = CGRectMake(279, 348, 455, 339);
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
      
        signUpbgView.frame = CGRectMake(152, 505, 455, 339);
    }
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate  // iOS 6 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [emailIdTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
   
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_v.jpg"]];
         signUpbgView.frame = CGRectMake(279, 348, 455, 339);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
        signUpbgView.frame = CGRectMake(152, 505, 455, 339);
        
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    
    if(ori == UIInterfaceOrientationLandscapeRight |ori == UIInterfaceOrientationLandscapeLeft)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -290,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    else if(ori == UIInterfaceOrientationPortrait |ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -150,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSLog(@"currSysVer = %@",currSysVer);
    
    int currSysVerInInt = [currSysVer intValue];
    NSLog(@"currSysVerInInt = %d",currSysVerInInt);
    
    if(currSysVerInInt >= 7)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     64,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    else if(currSysVerInInt < 7)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     0,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        
    }
    
    
    
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
	return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInButton:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self validateEmailWithString:emailIdTextField.text];
    
    if (stricterFilter) {
        
        
        if (passwordTextField.text.length >0 && emailIdTextField.text.length>0) {
            
        
        NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&active=%@",emailIdTextField.text,passwordTextField.text,@"0"];
        NSLog(@"post=%@",post);
        
            NSString *insertSQL11 = [NSString stringWithFormat:@"select active from ba_tbl_user where id = 1"];
            
            [self displayAll:insertSQL11];
            
            
            
            
            if ([MobileNo isEqualToString:@"0"])
            {
                
                [self ValidateLogin:post];

                
            }
            else 
            {

                [self DataPresentValidateLogin:post];
                
            }
        
            
            
        }

        
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password cannot be blank" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
        }

        
    }
    
    else if (!stricterFilter) {
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
		[alert show];
    }
}

-(void)ValidateLogin:(NSString *)post
{
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"null",@"null"];
	
    
	
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"1234567890",@"rohan.k@skiusainc.com"];
	NSLog(@"POST=%@",post);
	
    //	dispatch_async(dispatch_get_main_queue()	, ^{
	
    
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/userstatus"]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
	[request setHTTPBody:postData];
	
	NSURLResponse *response;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
	NSLog(@"response1=%@",stringResponse);
	
	
	NSError* error;
	NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:urlData //1
                                                                 options:kNilOptions
                                                                   error:&error];
    
    
//    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type ) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",@"1", emailId.text, password.text, firstName.text, @"device",@"last_login",@"0",@"created_date",@"verification_key",@"active_date", @"old_password", @"last_modified" , @"created_by" , @"subscribtion_type" , @"individual"];
//    NSLog(@"query=%@",insertSQL);
    

    	for (NSDictionary *actoAgent in responseDict){
            
    		NSString  *response1 =[actoAgent objectForKey:@"active"];
  
    		NSLog(@"responseD=%@",response1);
           
            if (response1!=nil) {
          
        if ([response1 isEqualToString:@"1"])
            {
         
            NSString *insertSQL = [NSString stringWithFormat:@"update ba_tbl_user set active = %@ where id = 1",@"1"];
            [self saveData:insertSQL];
                
                NSString *insertSQL1 = [NSString stringWithFormat:@"select password from ba_tbl_user where id = 1"];
                
                [self displayAll:insertSQL1];
                
                
                if ([MobileNo isEqualToString:passwordTextField.text]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password Incorrect" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                    [alert show];
                    
                }


            }
            
            else
            {
                NSLog(@"no entry");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please verify your account" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
                [alert show];
            }

    	}
            
        }
    
   
}


-(void)DataPresentValidateLogin:(NSString *)post
{
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"null",@"null"];
	
    
	
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"1234567890",@"rohan.k@skiusainc.com"];
	NSLog(@"POST=%@",post);
	
    //	dispatch_async(dispatch_get_main_queue()	, ^{
	
    
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/senduserdata"]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
	[request setHTTPBody:postData];
	
	NSURLResponse *response;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
	NSLog(@"response1=%@",stringResponse);
	
	
	NSError* error;
	NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:urlData //1
                                                                 options:kNilOptions
                                                                   error:&error];
    
    
    //    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type ) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",@"1", emailId.text, password.text, firstName.text, @"device",@"last_login",@"0",@"created_date",@"verification_key",@"active_date", @"old_password", @"last_modified" , @"created_by" , @"subscribtion_type" , @"individual"];
    //    NSLog(@"query=%@",insertSQL);
    
    
    for (NSDictionary *actoAgent in responseDict){
        
        NSString  *response1 =[actoAgent objectForKey:@"active"];
        
        NSLog(@"responseD=%@",response1);
        
//        if (response1!=nil) {
//            
//            if ([response1 isEqualToString:@"1"])
//            {
//                
//                NSString *insertSQL = [NSString stringWithFormat:@"update ba_tbl_user set active = %@ where id = 1",@"1"];
//                [self saveData:insertSQL];
//                
//            }
//            
//            else
//            {
//                NSLog(@"no entry");
//            }
//            
//    	}
        
        
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , f_name,l_name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type, security_pin, password_mod) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",@"1", [actoAgent objectForKey:@"email"], [actoAgent objectForKey:@"password"], [actoAgent objectForKey:@"f_name"],[actoAgent objectForKey:@"l_name"], @"device",@"last_login",[actoAgent objectForKey:@"active"],[actoAgent objectForKey:@"created_date"],[actoAgent objectForKey:@"verification_key"],[actoAgent objectForKey:@"active_date"], [actoAgent objectForKey:@"old_password"], [actoAgent objectForKey:@"last_modified"] , [actoAgent objectForKey:@"created_by"] , [actoAgent objectForKey:@"subscription_type"] , [actoAgent objectForKey:@"user_type"], [actoAgent objectForKey:@"security_pin"], [actoAgent objectForKey:@"password_mod"]];
        
        NSLog(@"query=%@",insertSQL);
        
        [self saveData:insertSQL];

    }
    
    
    NSString *insertSQL1 = [NSString stringWithFormat:@"select password from ba_tbl_user where id = 1"];
    
    [self displayAll:insertSQL1];
    
    
    if ([MobileNo isEqualToString:passwordTextField.text]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password Incorrect" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
        [alert show];
        
    }

}




- (BOOL)validateEmailWithString:(NSString*)email
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	if( [emailTest evaluateWithObject:email] == YES){
		stricterFilter = TRUE;
		NSLog(@"Match!");
	} else {
		stricterFilter = FALSE;
		NSLog(@"No match!");
		
	}
    
}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)resendActivationEmail:(id)sender {
}

@end
