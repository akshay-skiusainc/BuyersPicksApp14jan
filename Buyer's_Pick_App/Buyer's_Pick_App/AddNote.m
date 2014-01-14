//
//  AddNote.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 24/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "AddNote.h"
#import "CameraAudioVideoNote.h"
#import "MyLocation.h"
#define kGeoCodingString @"http://maps.google.com/maps/geo?q=%f,%f&output=csv"
#import "NoteTableViewController.h"

@interface AddNote ()

@end

@implementation AddNote
@synthesize pView,titleTextField,nameTextField,descriptionTextField,selectIndustryLabel,industryTableView,tagTextView,websiteTextView,emailIdTextView,contactNoTextView,addressTextView,currentLocationTextView,noteArray,noteScroller,goToCamera;
@synthesize mapView;
@synthesize titleBgImage,selectIndusBgImage,websiteBgImage,addressBgImage,currntLocBgImage,contactBgImage,emailBgImage,titleLabel,nameLabel,descLabel,tagLabel,tagBgImage,websiteLabel,addressLabel,emailLabel,contactLabel,currentLocLabel,tagButton,addWebsiteBtn,addEmailBtn,addAddressbtn,addContactBtn,mainScroller,mainView,TAG,vendorDesciption,vendorTitle,vendorWebsite,vendorid;

@synthesize WebsiteArray,EmailIDArray,AddressArray,ContactsArray;

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
    titleTextField.text=vendorTitle;
    descriptionTextField.text=vendorDesciption;
    websiteTextView.text=vendorWebsite;
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray  = [[NSMutableArray alloc] init];
    
    industryTableView.hidden = YES;
    
    noteArray = [[NSMutableArray alloc]init];
    [noteArray addObject:[UIImage imageNamed:@"camera_rec.jpg"]];
    
    UIImage *cardScannerImage = [UIImage imageNamed:@"cardscanner-black.png"];
    UIButton *cardScannerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cardScannerButton setImage:cardScannerImage forState:UIControlStateNormal];
    cardScannerButton.frame = CGRectMake(0, 5, cardScannerImage.size.width, cardScannerImage.size.height);
    cardScannerButton.tag = 1;
    [cardScannerButton addTarget:self action:@selector(cardScannerClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:cardScannerButton];
    
    
    UIImage *barcodeReaderImage = [UIImage imageNamed:@"barcodereader.png"];
    UIButton *barcodeReaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barcodeReaderButton setImage:barcodeReaderImage forState:UIControlStateNormal];
    barcodeReaderButton.frame = CGRectMake(0, 5, barcodeReaderImage.size.width, barcodeReaderImage.size.height);
    barcodeReaderButton.tag = 2;
    [barcodeReaderButton addTarget:self action:@selector(barcodeReaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:barcodeReaderButton];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,nil]];
    
    if([TAG isEqualToString:@"fromSplitView"])
    {
        
    }
    else
    {
        UIImage *doneImage = [UIImage imageNamed:@"done.png"];
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneButton setImage:doneImage forState:UIControlStateNormal];
        doneButton.frame = CGRectMake(0, 3, 64, 37);
        [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
        
        UIImage *nextImage = [UIImage imageNamed:@"next.png"];
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:nextImage forState:UIControlStateNormal];
        nextButton.frame = CGRectMake(0, 3, 64, 37);
        [nextButton addTarget:self action:@selector(goToCamera:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarItemNext = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
       
         [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:customBarItemDone, customBarItemNext,nil]];
    }


    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.text = @"Create New Vendor";
    navTitleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    navTitleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    navTitleLabel.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = navTitleLabel;
    
    
    
    // For map & Geo Tagging
    currentLocation = [[CLLocationManager alloc]init];
	currentLocation.desiredAccuracy = kCLLocationAccuracyBest;
	currentLocation.delegate = self;
	[currentLocation startUpdatingLocation];
    //    mapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
    //    mapView.showsUserLocation=TRUE;
    //mapView.mapType=MKMapTypeStandard;
    
    mapView.delegate=self;

//    ContactsArray = [[NSMutableArray alloc]initWithObjects:@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar",@"Akshay Jain",@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar",@"Akshay Jain", nil];
//
    
   ContactsArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar", nil];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];
    NSLog(@"In view will Appear");
    
//    dataFwdObj=[DataFwdClass getInstance];
//    ContactsArray = dataFwdObj.noteTagsArray;
    // For displaying Names on Contact Field
    if (ContactsArray.count > 0) {
        
        int yAxis= 10;

//    NSMutableString *names=[[NSMutableString alloc]initWithFormat:@"%@",[ContactsArray objectAtIndex:0] ];
//        int yAxis= 10;
//        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, yAxis, 100, 20)];
//        lbl.backgroundColor=[UIColor lightGrayColor];
//        lbl.text=names;
//        [self.contactNoScrollView addSubview:lbl];
    
    for(int i = 0; i<[ContactsArray count];i++)
    {
        yAxis=yAxis+22;
        NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[ContactsArray objectAtIndex:i]];
       // [names appendString:names1 ];
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10, yAxis, 215, 20)];
        lbl1.backgroundColor=[UIColor lightGrayColor];
        lbl1.text=names1;
       
        [self.contactNoScrollView addSubview:lbl1];
    }
     self.contactNoScrollView.contentSize=CGSizeMake(235, 20*([ContactsArray count]+1));
    //contactNoTextView.text=names;
    }
    
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        NSLog(@"In view will Appear landscape");
        mainScroller.frame = CGRectMake(0, 0, 1024, 704);
        mainView.frame = CGRectMake(0, 0, 1020, 940);
        titleBgImage.frame = CGRectMake(20, 3, 592, 128);
        selectIndusBgImage.frame = CGRectMake(20, 127, 592, 44);
        tagBgImage.frame = CGRectMake(20, 171, 513, 69);
        websiteBgImage.frame = CGRectMake(20, 239, 592, 74);
        addressBgImage.frame = CGRectMake(20, 388, 592, 103);
        contactBgImage.frame = CGRectMake(20, 489, 592, 103);
        emailBgImage.frame = CGRectMake(20, 313, 592, 74);
        titleLabel.frame = CGRectMake(32, 17, 42, 21);
        nameLabel.frame = CGRectMake(32, 58, 55, 21);
        descLabel.frame = CGRectMake(30, 92, 97, 32);
        titleTextField.frame = CGRectMake(143, 14, 456, 30);
        nameTextField.frame = CGRectMake(143, 54, 456, 30);
        descriptionTextField.frame = CGRectMake(143, 91, 456, 30);
        tagLabel.frame = CGRectMake(32, 186, 44, 39);
        selectIndustryLabel.frame = CGRectMake(30, 129, 569, 36);
        tagTextView.frame = CGRectMake(77, 176, 450, 54);
        tagButton.frame = CGRectMake(535, 171, 77, 70);
        websiteLabel.frame = CGRectMake(30, 253, 65, 39);
        websiteTextView.frame = CGRectMake(95, 243, 411, 66);
        addWebsiteBtn.frame = CGRectMake(498, 285, 106, 23);
        addAddressbtn.frame = CGRectMake(498, 459, 106, 23);
        addContactBtn.frame = CGRectMake(498, 558, 106, 23);
        addEmailBtn.frame = CGRectMake(498, 361, 106, 23);
        addressLabel.frame = CGRectMake(29, 416, 65, 39);
        addressTextView.frame = CGRectMake(94, 394, 407, 87);
        contactLabel.frame = CGRectMake(29, 512, 82, 39);
        contactNoTextView.frame = CGRectMake(119, 491, 382, 92);
        emailLabel.frame = CGRectMake(30, 328, 65, 39);
        emailIdTextView.frame = CGRectMake(97, 317, 404, 63);
        noteScroller.frame = CGRectMake(10, 668, 1004, 183);
        goToCamera.frame = CGRectMake(14, 663, 152, 190);
        currntLocBgImage.frame = CGRectMake(20, 591, 592, 74);
        currentLocLabel.frame = CGRectMake(30, 608, 117, 39);
        currentLocationTextView.frame = CGRectMake(155, 600, 438, 55);
        industryTableView.frame = CGRectMake(23, 167, 581, 125);
        
        mainScroller.contentSize = CGSizeMake(1024, 1000);
        
        mapView.frame = CGRectMake(620, 2, 400, 658);
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        mainScroller.frame = CGRectMake(13, 20, 742, 940);
        mainView.frame = CGRectMake(0, 0, 742, 940);
        titleBgImage.frame = CGRectMake(20, 12, 702, 128);
        selectIndusBgImage.frame = CGRectMake(20, 149, 702, 44);
        tagBgImage.frame = CGRectMake(20, 196, 613, 69);
        websiteBgImage.frame = CGRectMake(20, 269, 362, 74);
        addressBgImage.frame = CGRectMake(20, 345, 362, 103);
        contactBgImage.frame = CGRectMake(383, 346, 339, 103);
        emailBgImage.frame = CGRectMake(383, 269, 339, 74);
        titleLabel.frame = CGRectMake(32, 26, 42, 21);
        nameLabel.frame = CGRectMake(32, 67, 55, 21);
        descLabel.frame = CGRectMake(30, 101, 97, 32);
        titleTextField.frame = CGRectMake(143, 23, 544, 30);
        nameTextField.frame = CGRectMake(143, 63, 544, 30);
        descriptionTextField.frame = CGRectMake(143, 102, 544, 30);
        tagLabel.frame = CGRectMake(32, 211, 44, 39);
        selectIndustryLabel.frame = CGRectMake(30, 151, 629, 36);
        tagTextView.frame = CGRectMake(77, 201, 549, 54);
        tagButton.frame = CGRectMake(645, 195, 77, 70);
        websiteLabel.frame = CGRectMake(30, 274, 65, 39);
        websiteTextView.frame = CGRectMake(95, 273, 280, 40);
        addWebsiteBtn.frame = CGRectMake(269, 312, 106, 23);
        addAddressbtn.frame = CGRectMake(269, 418, 106, 23);
        addContactBtn.frame = CGRectMake(611, 419, 106, 23);
        addEmailBtn.frame = CGRectMake(611, 312, 106, 23);
        addressLabel.frame = CGRectMake(29, 371, 65, 39);
        addressTextView.frame = CGRectMake(94, 394, 255, 68);
        contactLabel.frame = CGRectMake(392, 372, 82, 39);
        contactNoTextView.frame = CGRectMake(482, 351, 235, 67);
        emailLabel.frame = CGRectMake(391, 274, 65, 39);
        emailIdTextView.frame = CGRectMake(460, 273, 255, 40);
        noteScroller.frame = CGRectMake(0, 757, 742, 183);
        goToCamera.frame = CGRectMake(7, 752, 152, 190);
        currntLocBgImage.frame = CGRectMake(20, 451, 702, 74);
        currentLocLabel.frame = CGRectMake(30, 469, 117, 39);
        currentLocationTextView.frame = CGRectMake(155, 463, 553, 52);
        industryTableView.frame = CGRectMake(24, 188, 698, 125);
        
        mainScroller.contentSize = CGSizeMake(742, 1000);
        
        mapView.frame = CGRectMake(23, 526, 698, 227);
    }
    
    [self displayScroller];
    
}


// Map & Geo-Tagging
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"GGG");
    
	[currentLocation stopUpdatingLocation];
    
    
	theCoordinate.latitude = newLocation.coordinate.latitude;
	theCoordinate.longitude = newLocation.coordinate.longitude;
    CurrentLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    CurrentLongitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] ;
    
    
    
    NSLog(@"currloc= %f",theCoordinate.longitude);
    
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    MKReverseGeocoder *geoCoder=[[MKReverseGeocoder alloc]
                                 initWithCoordinate:newLocation.coordinate];
    geoCoder.delegate=self;
    
    [geoCoder start];
	[self showCurrentLoc];
    [self getAddressFromLatLon:theCoordinate.latitude withLongitude:theCoordinate.longitude];
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark

{
	NSLog(@"Retrive: %@", placemark);
    NSString *locations=[NSString stringWithFormat:@"%@ \n",placemark];
    currentLocationTextView.text=locations;
   NSLog(@"locations: %@", locations);
    
	[geocoder cancel];
    
}
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"%@",error);
	[geocoder cancel];
}

- (void)showCurrentLoc
{
   	{
        
        MKCoordinateRegion region;
        region.center = theCoordinate;
        MKCoordinateSpan span;
        mapView.delegate=self;
        span.latitudeDelta = 0.10;
        span.longitudeDelta = 0.10;
        region.span=span;
        [mapView setRegion:region animated:TRUE];
        //        theCoordinate.latitude = theater_lat;
        //        theCoordinate.longitude = theater_lng;
        
		
		annotation1 *annotation = [[annotation1 alloc] initWithCoordinate:theCoordinate andID:0];
        
        
		annotation.title = @"Your Location";
		annotation.subtitle =locationString;
        
		
		[Map_Annotaions insertObject:annotation atIndex:0];
        //  [mapView addAnnotation:[Map_Annotaions objectAtIndex:0]];
        
        
	}
}

-(void)displayallannotations
{
    for (int i = 1; i<9; i++) {
        
        
        [mapView addAnnotation:[Map_Annotaions objectAtIndex:i]];
    }
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    NSLog(@"OKOKOKOKOKOK");
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[annotation1 class]]) // for Golden Gate Bridge
    {
        // try to dequeue an existing pin view first
        static NSString* BridgeAnnotationIdentifier = @"annotation1Identifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] ;
            customPinView.pinColor = MKPinAnnotationColorGreen;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            
            
            
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}



-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    NSString *urlString = [NSString stringWithFormat:kGeoCodingString,pdblLatitude, pdblLongitude];
    NSLog(@"str=%@",urlString);
    NSError* error;
    locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
    
    //   ArrayForLocation= [NSMutableArray initWithCapacity:20];
    
    
    locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    // locationString = [locationString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"loc=%@",locationString);
    return [locationString substringFromIndex:6];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	[currentLocation stopUpdatingLocation];
}





-(void)cardScannerClicked:(UIButton *)sender
{
    
}

-(void)barcodeReaderClicked:(UIButton *)sender
{
    
}

-(void)displayScroller
{
    
    [[noteScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    [Scroller removeFromSuperview];
    //    Scroller=nil;
    
     NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",vendorid];
    [self displayContentData:fetchdata];
    NSLog(@"total data = %d",TotalData);
     NSLog(@"fetchdata= %@",fetchdata);
    int j =0;
    for (int i =0; i<TotalData; i++) {
        
        
        frame[i] = [[UIImageView alloc] initWithFrame:CGRectMake(j,0 , 140,150)];
		frame[i].image = [UIImage imageNamed:@"note_rec.jpg"];
		frame[i].userInteractionEnabled=YES;
		[noteScroller addSubview:frame[i]];
        
        if ([datatype[i] isEqualToString:@"image"]) {
            frame[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140 ,150)];
            blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
            [frame[i] addSubview:blackPhotoImage];

        }
        
        
        
        if ([datatype[i] isEqualToString:@"video"]) {
            frame[i].image = [UIImage imageNamed:@"video_rec.jpg"];
            
        }
        
        
        if ([datatype[i] isEqualToString:@"audio"]) {
            frame[i].image = [UIImage imageNamed:@"voice_rec.jpg"];
            
        }
        
        
        
        if ([datatype[i] isEqualToString:@"text"]) {
            frame[i].image = [UIImage imageNamed:@"tag-img.png"];
            
        }
        
        
        tagField[i] = [[UITextField alloc] initWithFrame:CGRectMake(j, 153, 140, 24)];
        tagField[i].borderStyle = UITextBorderStyleRoundedRect;
        tagField[i].textColor = [UIColor blackColor];
        tagField[i].font = [UIFont systemFontOfSize:14.0];
        tagField[i].placeholder = @"ADD TAG HERE";
        tagField[i].backgroundColor = [UIColor clearColor];
        tagField[i].autocorrectionType = UITextAutocorrectionTypeYes;
        tagField[i].keyboardType = UIKeyboardTypeDefault;
        tagField[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        tagField[i].delegate = self;
        
        [noteScroller addSubview:tagField[i]];
        
        j+=145;
        
       
    }
    
    noteScroller.contentSize = CGSizeMake(TotalData*145, 177);
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
//    [UIView setAnimationDuration:.3];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
//    
//    if(ori == UIInterfaceOrientationLandscapeRight |ori == UIInterfaceOrientationLandscapeLeft)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     -290,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//    }
//    else if(ori == UIInterfaceOrientationPortrait |ori == UIInterfaceOrientationPortraitUpsideDown)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     -260,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//    }
//    
//    [UIView commitAnimations];
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
//    [UIView setAnimationDuration:.3];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"currSysVer = %@",currSysVer);
//    
//    int currSysVerInInt = [currSysVer intValue];
//    NSLog(@"currSysVerInInt = %d",currSysVerInInt);
//    
//    if(currSysVerInInt >= 7)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     64,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//    }
//    else if(currSysVerInInt < 7)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     0,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//        
//    }
//
//    
//    
//    [UIView commitAnimations];
//    
//    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
	return YES;
}

-(void)done
{
    if (check==1) {
    }
    
    else{
        if(nameTextField.text.length >0)
        {
            NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor ( vendor_name , user_id , tags , alias , description , website , path , created_date , security_pin , old_security_pin , last_modified_security_pin , geo_latitude , geo_longitude , last_modified_date , is_deleted , delete_date ) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", titleTextField.text, @"1", tagTextView.text, @"", descriptionTextField.text, websiteTextView.text, @"path", @"created_date", @"securepin", @"oldpin", @"last_modified_security_pin",@"geolat",@"geolng", @"lastmodified" , @"YES",@"Deletedate"];
            
            [self saveData:insertquery];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *CellIdentifier = @"sorting by date";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
     return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    
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
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
       
        mainScroller.frame = CGRectMake(0, 0, 1024, 704);
        mainView.frame = CGRectMake(0, 0, 1020, 940);
        titleBgImage.frame = CGRectMake(20, 3, 592, 128);
        selectIndusBgImage.frame = CGRectMake(20, 127, 592, 44);
        tagBgImage.frame = CGRectMake(20, 171, 513, 69);
        websiteBgImage.frame = CGRectMake(20, 239, 592, 74);
        addressBgImage.frame = CGRectMake(20, 388, 592, 103);
        contactBgImage.frame = CGRectMake(20, 489, 592, 103);
        emailBgImage.frame = CGRectMake(20, 313, 592, 74);
        titleLabel.frame = CGRectMake(32, 17, 42, 21);
        nameLabel.frame = CGRectMake(32, 58, 55, 21);
        descLabel.frame = CGRectMake(30, 92, 97, 32);
        titleTextField.frame = CGRectMake(143, 14, 456, 30);
         nameTextField.frame = CGRectMake(143, 54, 456, 30);
         descriptionTextField.frame = CGRectMake(143, 91, 456, 30);
         tagLabel.frame = CGRectMake(32, 186, 44, 39);
         selectIndustryLabel.frame = CGRectMake(30, 129, 569, 36);
         tagTextView.frame = CGRectMake(77, 176, 450, 54);
         tagButton.frame = CGRectMake(535, 171, 77, 70);
         websiteLabel.frame = CGRectMake(30, 253, 65, 39);
         websiteTextView.frame = CGRectMake(95, 243, 411, 66);
         addWebsiteBtn.frame = CGRectMake(498, 285, 106, 23);
         addAddressbtn.frame = CGRectMake(498, 459, 106, 23);
         addContactBtn.frame = CGRectMake(498, 558, 106, 23);
         addEmailBtn.frame = CGRectMake(498, 361, 106, 23);
         addressLabel.frame = CGRectMake(29, 416, 65, 39);
         addressTextView.frame = CGRectMake(94, 394, 407, 87);
         contactLabel.frame = CGRectMake(29, 512, 82, 39);
         contactNoTextView.frame = CGRectMake(119, 491, 382, 92);
         emailLabel.frame = CGRectMake(30, 328, 65, 39);
         emailIdTextView.frame = CGRectMake(97, 317, 404, 63);
         noteScroller.frame = CGRectMake(10, 668,1004, 183);
         goToCamera.frame = CGRectMake(14, 663, 152, 190);
         currntLocBgImage.frame = CGRectMake(20, 591, 592, 74);
         currentLocLabel.frame = CGRectMake(30, 608, 117, 39);
         currentLocationTextView.frame = CGRectMake(155, 600, 438, 55);
         industryTableView.frame = CGRectMake(23, 167, 581, 125);
        
        mainScroller.contentSize = CGSizeMake(1024, 1000);
        mapView.frame = CGRectMake(620, 2, 400, 658);
       
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
         self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        mainScroller.frame = CGRectMake(13, 20, 742, 940);
        mainView.frame = CGRectMake(0, 0, 742, 940);
        titleBgImage.frame = CGRectMake(20, 12, 702, 128);
        selectIndusBgImage.frame = CGRectMake(20, 149, 702, 44);
        tagBgImage.frame = CGRectMake(20, 196, 613, 69);
        websiteBgImage.frame = CGRectMake(20, 269, 362, 74);
        addressBgImage.frame = CGRectMake(20, 345, 362, 103);
        contactBgImage.frame = CGRectMake(383, 346, 339, 103);
        emailBgImage.frame = CGRectMake(383, 269, 339, 74);
        titleLabel.frame = CGRectMake(32, 26, 42, 21);
        nameLabel.frame = CGRectMake(32, 67, 55, 21);
        descLabel.frame = CGRectMake(30, 101, 97, 32);
        titleTextField.frame = CGRectMake(143, 23, 544, 30);
        nameTextField.frame = CGRectMake(143, 63, 544, 30);
        descriptionTextField.frame = CGRectMake(143, 102, 544, 30);
        tagLabel.frame = CGRectMake(32, 211, 44, 39);
        selectIndustryLabel.frame = CGRectMake(30, 151, 629, 36);
        tagTextView.frame = CGRectMake(77, 201, 549, 54);
        tagButton.frame = CGRectMake(645, 195, 77, 70);
        websiteLabel.frame = CGRectMake(30, 274, 65, 39);
        websiteTextView.frame = CGRectMake(95, 273, 280, 40);
        addWebsiteBtn.frame = CGRectMake(269, 312, 106, 23);
        addAddressbtn.frame = CGRectMake(269, 418, 106, 23);
        addContactBtn.frame = CGRectMake(611, 419, 106, 23);
        addEmailBtn.frame = CGRectMake(611, 312, 106, 23);
        addressLabel.frame = CGRectMake(29, 371, 65, 39);
        addressTextView.frame = CGRectMake(94, 394, 255, 68);
        contactLabel.frame = CGRectMake(392, 372, 82, 39);
        contactNoTextView.frame = CGRectMake(482, 351, 235, 67);
        emailLabel.frame = CGRectMake(391, 274, 65, 39);
        emailIdTextView.frame = CGRectMake(460, 273, 255, 40);
        noteScroller.frame = CGRectMake(0, 757, 742, 183);
        goToCamera.frame = CGRectMake(7, 752, 152, 190);
        currntLocBgImage.frame = CGRectMake(20, 451, 702, 74);
        currentLocLabel.frame = CGRectMake(30, 469, 117, 39);
        currentLocationTextView.frame = CGRectMake(155, 463, 553, 52);
        industryTableView.frame = CGRectMake(24, 188, 698, 125);
        
        mainScroller.contentSize = CGSizeMake(742, 1000);
         mapView.frame = CGRectMake(23, 526, 698, 227);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addWebsite:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray  = [[NSMutableArray alloc] init];
    dataFwdObj.noteTagsArray= ContactsArray;
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    //    [self.navigationController pushViewController:testVC animated:YES];
    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:testVC animated:YES completion:nil];
}

- (IBAction)addAddress:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray= ContactsArray;
    dataFwdObj.fieldCalled=@"addAddress";
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    //    [self.navigationController pushViewController:testVC animated:YES];
    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    dataFwdObj.noteTagsArray=[[NSMutableArray alloc]initWithArray:ContactsArray];
    [self presentViewController:testVC animated:YES completion:nil];
}
- (IBAction)addContactNo:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray= ContactsArray;
    dataFwdObj.fieldCalled=@"addContactNo";
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:testVC animated:YES completion:nil];
    
//    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:testVC animated:YES completion:nil];
    
    
}
- (IBAction)addEmail:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray= ContactsArray;
    dataFwdObj.fieldCalled=@"addEmail";
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    //    [self.navigationController pushViewController:testVC animated:YES];
    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:testVC animated:YES completion:nil];
}

- (void)goToCamera:(id)sender
{
    check=1;
    
    NSString *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor ( vendor_name , user_id , tags , alias , description , website , path , created_date , security_pin , old_security_pin , last_modified_security_pin , geo_latitude , geo_longitude , last_modified_date , is_deleted , delete_date ) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", titleTextField.text, @"1", tagTextView.text, @"", descriptionTextField.text, websiteTextView.text, @"path", @"created_date", @"securepin", @"oldpin", @"last_modified_security_pin",@"geolat",@"geolng", @"lastmodified" , @"YES",@"Deletedate"];
    
    [self saveData:insertquery];
    CameraAudioVideoNote *goToCameraView = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
    [self.navigationController pushViewController:goToCameraView animated:YES];
}

- (IBAction)tagButton:(id)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray= ContactsArray;
    dataFwdObj.fieldCalled=@"tagButton";
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    //    [self.navigationController pushViewController:testVC animated:YES];
    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:testVC animated:YES completion:nil];
}


@end
