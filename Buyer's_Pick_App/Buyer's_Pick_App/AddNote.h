//
//  AddNote.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 24/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyLocation.h"
#import "annotation1.h"
#import "DatabaseClass.h"
#define METERS_PER_MILE 1609.344
#import "DatabaseClass.h"
#import "DataFwdClass.h"

@interface AddNote : DatabaseClass<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIWebViewDelegate>
{
    UIImageView *frame[1000];
    UITextField *tagField[1000];
    BOOL _doneInitialZoom;
    CLLocationCoordinate2D theCoordinate;
    CLLocationManager *currentLocation;
    NSString                *CurrentLatitude;
    NSString                *CurrentLongitude;
    NSString *locationString;
    
    float CurrentLatitudeValue;
    float CurrentLongitudeValue;
    NSMutableArray              *Map_Annotaions;
    NSMutableArray *ContactsArray;
    NSString* vendorTitle;
     NSString* vendorName;
    NSString* vendorDesciption;
    NSString* vendorWebsite;
    DataFwdClass *dataFwdObj;

    int check;
}

@property (nonatomic, retain) NSMutableArray              *ContactsArray;
@property (nonatomic, retain) NSMutableArray              *EmailIDArray;
@property (nonatomic, retain) NSMutableArray              *AddressArray;
@property (nonatomic, retain) NSMutableArray              *WebsiteArray;
@property (nonatomic,strong)NSString* TAG;
@property (nonatomic,strong)NSString* vendorTitle;
@property (nonatomic,strong)NSString* vendorDesciption;
@property (nonatomic,strong)NSString* vendorWebsite;
@property (nonatomic,strong)NSString* vendorid;
@property (nonatomic,strong)NSString* vendorName;

@property (strong, nonatomic) IBOutlet UIScrollView *contactNoScrollView;



@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray              *Map_Annotaions;
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScroller;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *selectIndustryLabel;
@property (strong, nonatomic) IBOutlet UITableView *industryTableView;
@property (strong, nonatomic) IBOutlet UITextView *tagTextView;
@property (strong, nonatomic) IBOutlet UITextView *websiteTextView;
@property (strong, nonatomic) IBOutlet UITextView *emailIdTextView;
@property (strong, nonatomic) IBOutlet UITextView *contactNoTextView;
@property (strong, nonatomic) IBOutlet UITextView *addressTextView;
@property (strong, nonatomic) IBOutlet UITextView *currentLocationTextView;
@property (strong, nonatomic) NSMutableArray *noteArray;
@property (strong, nonatomic) IBOutlet UIButton *goToCamera;
@property (strong, nonatomic) IBOutlet UIScrollView *noteScroller;

@property (strong, nonatomic) IBOutlet UIImageView *titleBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *selectIndusBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *tagBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *websiteBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *addressBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *currntLocBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *contactBgImage;
@property (strong, nonatomic) IBOutlet UIImageView *emailBgImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) IBOutlet UILabel *websiteLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentLocLabel;
@property (strong, nonatomic) IBOutlet UIButton *tagButton;
@property (strong, nonatomic) IBOutlet UIButton *addWebsiteBtn;
@property (strong, nonatomic) IBOutlet UIButton *addEmailBtn;
@property (strong, nonatomic) IBOutlet UIButton *addContactBtn;
@property (strong, nonatomic) IBOutlet UIButton *addAddressbtn;
//@property (strong, nonatomic) IBOutlet UIImageView *mapImage;



- (IBAction)addWebsite:(id)sender;
- (IBAction)addAddress:(id)sender;
- (IBAction)addContactNo:(id)sender;
- (IBAction)addEmail:(id)sender;
- (IBAction)goToCamera:(id)sender;
- (IBAction)tagButton:(id)sender;

@end
