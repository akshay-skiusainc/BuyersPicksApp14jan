//
//  MyAccount.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 06/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "MyAccount.h"
#import "CameraAudioVideoNote.h"
#import "MyProfile.h"
#import "TermsAndConditions.h"

@interface MyAccount ()

@end

@implementation MyAccount
@synthesize placeHolderTitle,lView,pView,TAG;

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
    UIImage *cameraImage = [UIImage imageNamed:@"camera_icon.png"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0, 5, cameraImage.size.width, cameraImage.size.height);
    cameraButton.tag = 0;
    [cameraButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemCamera = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    UIImage *audioImage = [UIImage imageNamed:@"recording_icon.png"];
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [audioButton setImage:audioImage forState:UIControlStateNormal];
    audioButton.frame = CGRectMake(0, 5, audioImage.size.width, audioImage.size.height);
    audioButton.tag = 1;
    [audioButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:audioButton];
    
    
    UIImage *noteImage = [UIImage imageNamed:@"note_icon.png"];
    UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noteButton setImage:noteImage forState:UIControlStateNormal];
    noteButton.frame = CGRectMake(0, 5, noteImage.size.width, noteImage.size.height);
    noteButton.tag = 2;
    [noteButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:noteButton];
    
    
    UIImage *searchBarImage = [UIImage imageNamed:@"searchbox.png"];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 130, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    [textField setBackground:searchBarImage];
    textField.backgroundColor = [UIColor clearColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    
    placeHolderTitle = [[UILabel alloc] initWithFrame:CGRectMake(9.0, 0.0, textField.frame.size.width - 20.0, 34.0)];
    [placeHolderTitle setText:@"SEARCH BY TAG"];
    [placeHolderTitle setBackgroundColor:[UIColor clearColor]];
    [placeHolderTitle setTextColor:[UIColor whiteColor]];
    [placeHolderTitle setFont:[UIFont boldSystemFontOfSize:10.0]];
    [textField addSubview:placeHolderTitle];
    
    UIBarButtonItem *customBarItemSearch = [[UIBarButtonItem alloc] initWithCustomView:textField];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,customBarItemCamera,customBarItemSearch,nil]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"MY ACCOUNT";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

}
-(void)cameraClicked:(UIButton *)sender
{
    if(sender.tag == 2)
    {
        
    }
    else
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = sender.tag;
        [self.navigationController pushViewController:openCamera animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
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
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myProfile:(id)sender
{
    MyProfile *myProfile = [[MyProfile alloc]initWithNibName:@"MyProfile" bundle:nil];
    [self.navigationController pushViewController:myProfile animated:YES];
}

- (IBAction)myBilling:(id)sender {
}

- (IBAction)planAndPricing:(id)sender {
}

- (IBAction)sync:(id)sender {
}

- (IBAction)securePin:(id)sender {
}

- (IBAction)geoTagging:(id)sender {
}

- (IBAction)Faq:(id)sender {
}

- (IBAction)termsAndConditions:(id)sender
{
    TermsAndConditions *terms= [[TermsAndConditions alloc]initWithNibName:@"TermsAndConditions" bundle:nil];
    [self.navigationController pushViewController:terms animated:YES];
}

- (IBAction)reportProb:(id)sender {
}

- (IBAction)shared:(id)sender {
}

- (IBAction)myTag:(id)sender {
}

- (IBAction)myIndustries:(id)sender {
}
@end
