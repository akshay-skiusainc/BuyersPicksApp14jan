//
//  CameraAudioVideoNote.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 13/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "CameraAudioVideoNote.h"
#import "CameraEngine.h"
#import "PhotoEditor.h"

@interface CameraAudioVideoNote ()
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end

@implementation CameraAudioVideoNote
<<<<<<< HEAD
@synthesize lView,pView,noteScroller,savedImage,AllNotes,mainActivityIndicator,navTagFromHome,deleteNoteIndex,noteScrollerLand,TAG,VENDORID;
@synthesize noteScroller,savedImage,AllNotes,mainActivityIndicator,navTagFromHome,deleteNoteIndex,TAG;
=======

@synthesize noteScroller,savedImage,AllNotes,mainActivityIndicator,navTagFromHome,deleteNoteIndex,TAG,VENDORID;



>>>>>>> 252138832889e98febfafec6dae0fc066b4d6eb6

//camera
@synthesize frontCamera,backCamera,cameraTag,cameraButton,device,imageArray,imageCaptureButton,viewForRecording,cameraToggleSwitch,input,thumbTintColor,bgImageForSwitch,switchCameraImage,switchVideoImage;
//@synthesize cameraToggleSwitchLand,cameraButtonLand,viewForRecordingLand,imageCaptureButtonLand,bgImageForSwitchLand;

//Audio
@synthesize stopButton, playButton, recordPauseButton,audioRecordView;
//@synthesize recordPauseButtonLand,stopButtonLand,playButtonLand,audioRecordViewLand;

//Video
@synthesize startVideo,stopVideo,videoRecordingView,videoPreviewTag,videoTime;
//@synthesize videoRecordingViewLand,startVideoLand,stopVideoLand,switchCameraImageLand,switchVideoImageLand,videoTimeLand;

//Text
@synthesize saveText,cancleText,textViewBgImage,placeHolderTitle,savedDescription,noteTextView;
//@synthesize noteTextViewLand,textViewBgImageLand,saveTextLand,cancleTextLand;

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
    
    [self DATABASECALLED];

     cameraTag=0; // for backCamera
    videoPreviewTag=0;
    deleteNoteIndex=0;
    [mainActivityIndicator startAnimating];
  
    audioRecordView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"recbg.jpg"]];
    imageArray = [[NSMutableArray alloc]init];
    
    UIImage *cameraImage = [UIImage imageNamed:@"cameraic.png"];
    navCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navCameraButton setImage:cameraImage forState:UIControlStateNormal];
    navCameraButton.frame = CGRectMake(0, 0, 44, 44);
    navCameraButton.tag=0;
    [navCameraButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemCamera = [[UIBarButtonItem alloc] initWithCustomView:navCameraButton];
    
    UIImage *videoImage = [UIImage imageNamed:@"videoic.png"];
    videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoButton setImage:videoImage forState:UIControlStateNormal];
    videoButton.frame = CGRectMake(0, 0, 44, 44);
     videoButton.tag=1;
    [videoButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemVideo = [[UIBarButtonItem alloc] initWithCustomView:videoButton];

    
    UIImage *audioImage = [UIImage imageNamed:@"micic.png"];
    audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [audioButton setImage:audioImage forState:UIControlStateNormal];
    audioButton.frame = CGRectMake(0, 0, 44, 44);
     audioButton.tag=2;
    [audioButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:audioButton];
    
    
    UIImage *noteImage = [UIImage imageNamed:@"noteic.png"];
    noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noteButton setImage:noteImage forState:UIControlStateNormal];
    noteButton.frame = CGRectMake(0, 0, 44, 44);
    noteButton.tag=3;
    [noteButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:noteButton];
    
    UIImage *deleteImage = [UIImage imageNamed:@"zone.png"];
    deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:deleteImage forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(0, 0, 44, 44);
    deleteButton.tag=4;
    [deleteButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemDelete = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemDelete,customBarItemNote ,customBarItemAudio,customBarItemVideo,customBarItemCamera, nil]];
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
        self.navigationItem.leftBarButtonItem = customBarItemDone;
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Vendor Name/Title";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = titleLabel;

  
    NSLog(@"navTagFromHome=%d",navTagFromHome);
    if (navTagFromHome == 0)
    {
        [[CameraEngine engine] startup];

        AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
       // [preview removeFromSuperlayer];
        preview.frame = self.viewForRecording.bounds;
        [self.viewForRecording.layer addSublayer:preview];

//        AVCaptureVideoPreviewLayer* previewLand = [[CameraEngine engine] getPreviewLayer];
//       // [previewLand removeFromSuperlayer];
//        previewLand.frame = self.viewForRecordingLand.bounds;
//        [self.viewForRecordingLand.layer addSublayer:previewLand];
        
//        UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
//        if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
//        {
//            preview.frame = self.viewForRecording.bounds;
//            [self.viewForRecording.layer addSublayer:preview];
//        }
//        
//        else if(ori == UIInterfaceOrientationPortrait ||ori ==UIInterfaceOrientationPortraitUpsideDown)
//        {
//
//        preview.frame = self.viewForRecording.bounds;
//        [self.viewForRecording.layer addSublayer:preview];
//        }
        
       
        
        
        switchVideoImage.image = [UIImage imageNamed:@"video_recic.png"];
        switchCameraImage.image = [UIImage imageNamed:@"photoimg.png"];
     
        
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic_on.jpg"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        
        
        videoTime.alpha = 0.0;
        audioRecordView.alpha = 0.0;
        noteTextView.alpha = 0.0;
        viewForRecording.alpha = 1.0;
        videoRecordingView.alpha = 0.0;
        saveText.alpha = 0.0;
        cancleText.alpha = 0.0;
        textViewBgImage.alpha = 0.0;
        bgImageForSwitch.alpha = 1.0;
        switchVideoImage.alpha = 1.0;
        switchCameraImage.alpha = 1.0;
        cameraToggleSwitch.alpha = 1.0;
        [self.view addSubview:imageCaptureButton];
        [self.view addSubview:cameraButton];
        cameraToggleSwitch.on = NO;
        
//        videoTimeLand.alpha = 0.0;
//        audioRecordViewLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        viewForRecordingLand.alpha = 1.0;
//        videoRecordingViewLand.alpha = 0.0;
//        saveTextLand.alpha = 0.0;
//        cancleTextLand.alpha = 0.0;
//        textViewBgImageLand.alpha = 0.0;
//        bgImageForSwitchLand.alpha = 1.0;
//        switchVideoImageLand.alpha = 1.0;
//        switchCameraImageLand.alpha = 1.0;
//        cameraToggleSwitchLand.alpha = 1.0;
//        [self.lView addSubview:imageCaptureButtonLand];
//        [self.lView addSubview:cameraButtonLand];
//        cameraToggleSwitchLand.on = NO;

        
    }
    
    if(navTagFromHome == 1)
    {
        switchVideoImage.image = [UIImage imageNamed:@"video_ic.png"];
        switchCameraImage.image = [UIImage imageNamed:@"recimg.png"];
//        switchVideoImageLand.image = [UIImage imageNamed:@"video_ic.png"];
//        switchCameraImageLand.image = [UIImage imageNamed:@"recimg.png"];
        
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic_on.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
       
        videoTime.alpha = 0.0;
        audioRecordView.alpha = 1.0;
        noteTextView.alpha = 0.0;
        viewForRecording.alpha = 0.0;
        videoRecordingView.alpha = 0.0;
        saveText.alpha = 0.0;
        cancleText.alpha = 0.0;
        textViewBgImage.alpha = 0.0;
        bgImageForSwitch.alpha = 0.0;
        switchVideoImage.alpha = 0.0;
        switchCameraImage.alpha = 0.0;
        cameraToggleSwitch.alpha = 0.0;
        
//        videoTimeLand.alpha = 0.0;
//        audioRecordViewLand.alpha = 1.0;
//        noteTextViewLand.alpha = 0.0;
//        viewForRecordingLand.alpha = 0.0;
//        videoRecordingViewLand.alpha = 0.0;
//        saveTextLand.alpha = 0.0;
//        cancleTextLand.alpha = 0.0;
//        textViewBgImageLand.alpha = 0.0;
//        bgImageForSwitchLand.alpha = 0.0;
//        switchVideoImageLand.alpha = 0.0;
//        switchCameraImageLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 0.0;

    }
    if(navTagFromHome == 2)
    {
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic_on.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        
        videoTime.alpha = 0.0;
        audioRecordView.alpha = 0.0;
        noteTextView.alpha = 1.0;
        viewForRecording.alpha = 0.0;
        videoRecordingView.alpha = 0.0;
        saveText.alpha = 1.0;
        cancleText.alpha = 1.0;
        textViewBgImage.alpha = 1.0;
        bgImageForSwitch.alpha = 0.0;
        switchVideoImage.alpha = 0.0;
        switchCameraImage.alpha = 0.0;
        cameraToggleSwitch.alpha = 0.0;
        
//        videoTimeLand.alpha = 0.0;
//        audioRecordViewLand.alpha = 0.0;
//        noteTextViewLand.alpha = 1.0;
//        viewForRecordingLand.alpha = 0.0;
//        videoRecordingViewLand.alpha = 0.0;
//        saveTextLand.alpha = 1.0;
//        cancleTextLand.alpha = 1.0;
//        textViewBgImageLand.alpha = 1.0;
//        bgImageForSwitchLand.alpha = 0.0;
//        switchVideoImageLand.alpha = 0.0;
//        switchCameraImageLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 0.0;
    }
    
    
     //[mainActivityIndicator stopAnimating];
    mainActivityIndicator.alpha = 0.0;
    
    placeHolderTitle = [[UILabel alloc] initWithFrame:CGRectMake(9.0, 0.0, noteTextView.frame.size.width - 20.0, 34.0)];
    [placeHolderTitle setText:@"Write your text here...."];
    // placeholderLabel is instance variable retained by view controller
    [placeHolderTitle setBackgroundColor:[UIColor clearColor]];
    [placeHolderTitle setTextColor:[UIColor darkGrayColor]];
    [placeHolderTitle setFont:[UIFont boldSystemFontOfSize:19.0]];
    [noteTextView addSubview:placeHolderTitle];
    
   // [noteTextViewLand addSubview:placeHolderTitle];

    [self setThumbTintColor:[UIColor yellowColor]];
    [cameraToggleSwitch setThumbTintColor:[self thumbTintColor]];
    cameraToggleSwitch.on = NO;
    
//    [cameraToggleSwitchLand setThumbTintColor:[self thumbTintColor]];
//    cameraToggleSwitchLand.on = NO;
}


-(void)displayScroller
{
    
    [[noteScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
   // [[noteScrollerLand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    [Scroller removeFromSuperview];
//    Scroller=nil;
    
//    NSString   *fetchdata = [NSString stringWithFormat:@"select id , path, type from ba_tbl_content"];
    NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor where id =%@",VENDORID];
    [self displayAll:insertquery1];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",VENDORID];

    [self displayContentData:fetchdata];
    
    
    
    int mX=0;
    int mY=0;
    
    int j =0;
    for (int i =0; i<TotalData; i++) {
        
        mX=180*(i%2);
        mY=182 * (i/2);
        
        frame[i] = [[UIImageView alloc] initWithFrame:CGRectMake(j,5 , 178,178)];
		frame[i].image = [UIImage imageNamed:@"note_rec.jpg"];
		frame[i].userInteractionEnabled=YES;
		[noteScroller addSubview:frame[i]];

        if ([datatype[i] isEqualToString:@"image"]) {
            frame[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 178, 178)];
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
            frame[i].image = [UIImage imageNamed:@"note.png"];
            
        }
        if(deleteNoteIndex==6)
        {
            crossButton[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            crossButton[i].frame = CGRectMake(178-50, 178-50, 50, 50);
            crossButton[i].userInteractionEnabled = YES;
            crossButton[i].tag = [dataid[i] intValue];
            [crossButton[i] setImage:[UIImage imageNamed:@"closeic.png"] forState:UIControlStateNormal];
            [ crossButton[i] addTarget:self action:@selector(deleteNote:) forControlEvents:UIControlEventTouchUpInside];
            [frame[i] addSubview:crossButton[i]];
            
        }
        
            
           // frameLand[i] = [[UIImageView alloc] initWithFrame:CGRectMake(mX,mY , 173,176)];
        
            j+=183;
            mX = mX+180;
            mY = mY+182;

    
    
    UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openclass:)];
    webViewTapped.numberOfTapsRequired = 1;
    frame[i].tag=i;
    webViewTapped.delegate = self;
    [frame[i] addGestureRecognizer:webViewTapped];
        
}
    
    noteScroller.contentSize = CGSizeMake(TotalData*183, 178);
//    if(TotalData%2==0)
//    {
//        noteScroller.contentSize = CGSizeMake(180, 182*TotalData/2);
//    }
//    else
//    {
//         noteScroller.contentSize = CGSizeMake(180, 182*TotalData/2+182);
//    }
 
}

-(void)deleteNote:(UIButton *)sender
{
    NSLog(@"Inside deleteNote tag = %d",sender.tag);
    
    NSString *delete = [NSString stringWithFormat:@"delete from ba_tbl_content where id = %d",sender.tag];
    [self saveData:delete];
    
    [self displayScroller];
}
-(void)openclass:(UITapGestureRecognizer *)sender
{

    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"tag121=%d",gesture.view.tag);
    if ([datatype[gesture.view.tag] isEqualToString:@"text"]) {
        
        [[CameraEngine engine] shutdown];
        [saveText setEnabled:NO];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic_on.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        
        textViewBgImage.alpha = 1.0;
        videoRecordingView.alpha = 0.0;
        noteTextView.alpha = 0.0;
        cameraToggleSwitch.alpha = 0.0;
        viewForRecording.alpha = 0.0;
        audioRecordView.alpha = 0.0;
        imageCaptureButton.alpha = 0.0;
        cameraButton.alpha = 0.0;
        startVideo.alpha = 0.0;
        stopVideo.alpha = 0.0;
        noteTextView.alpha = 1.0;
        saveText.alpha = 1.0;
        cancleText.alpha = 1.0;
        bgImageForSwitch.alpha = 0.0;
        switchVideoImage.alpha = 0.0;
        switchCameraImage.alpha = 0.0;
        
        [recorder stop];
        [player stop];
        [placeHolderTitle removeFromSuperview];

        [self.view addSubview:noteTextView];

        noteTextView.text= datapath[gesture.view.tag];
        
        
//        textViewBgImageLand.alpha = 1.0;
//        videoRecordingViewLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 0.0;
//        viewForRecordingLand.alpha = 0.0;
//        audioRecordViewLand.alpha = 0.0;
//        imageCaptureButtonLand.alpha = 0.0;
//        cameraButtonLand.alpha = 0.0;
//        startVideoLand.alpha = 0.0;
//        stopVideoLand.alpha = 0.0;
//        noteTextViewLand.alpha = 1.0;
//        saveTextLand.alpha = 1.0;
//        cancleTextLand.alpha = 1.0;
//        bgImageForSwitchLand.alpha = 0.0;
//        switchVideoImageLand.alpha = 0.0;
//        switchCameraImageLand.alpha = 0.0;
//        [self.lView addSubview:noteTextViewLand];
//        noteTextViewLand.text= datapath[gesture.view.tag];
    }
    else if ([datatype[gesture.view.tag] isEqualToString:@"image"])
    {
        PhotoEditor *photoEditor = [[PhotoEditor alloc]initWithNibName:@"PhotoEditor" bundle:nil];
        photoEditor.DATATYPE= datatype[gesture.view.tag];
        photoEditor.DATAPATH= datapath[gesture.view.tag];
        [self.navigationController pushViewController:photoEditor animated:YES];
    }
        
    else
    {
    OpenDetailNote *OpenDetailNoteClass = [[OpenDetailNote alloc]initWithNibName:@"OpenDetailNote" bundle:nil];
    OpenDetailNoteClass.DATATYPE= datatype[gesture.view.tag];
    OpenDetailNoteClass.DATAPATH= datapath[gesture.view.tag];
    [self.navigationController pushViewController:OpenDetailNoteClass animated:YES];
    }
}
-(void)done
{
    [recorder stop];
    [player stop];

    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)displayCamera
//{
//    
//    
//    cameraToggleSwitch.on = NO;
//    
//    session = [[AVCaptureSession alloc] init];
//    session.sessionPreset = AVCaptureSessionPresetMedium;
//    
//    CALayer *viewLayer = self.viewForRecording.layer;
//    NSLog(@"viewLayer = %@", viewLayer);
//    
//    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
//    captureVideoPreviewLayer.frame = self.viewForRecording.bounds;
//    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    [self.viewForRecording.layer addSublayer:captureVideoPreviewLayer];
//    
//    
//    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    
//    if(navTagFromHome==0)
//    {
//        [self.view addSubview:bgImageForSwitch];
//        [self.view addSubview:switchCameraImage];
//        [self.view addSubview:switchVideoImage];
//        [self.view addSubview:cameraToggleSwitch];
//        [self.view addSubview:imageCaptureButton];
//        [self.view addSubview:cameraButton];
//
//    }
//    
//    NSError *error = nil;
//    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
//    if (!input) {
//        // Handle the error appropriately.
//        NSLog(@"ERROR: trying to open camera: %@", error);
//    }
//    [session addInput:input];
//    
//    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
//    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
//    [stillImageOutput setOutputSettings:outputSettings];
//    [session addOutput:stillImageOutput];
//    
//    [session startRunning];
//
//}

-(void)cameraClicked:(UIButton *)sender
{

    [mainActivityIndicator startAnimating];
    mainActivityIndicator.alpha = 1.0;
    deleteNoteIndex=0;

    [self.view addSubview:mainActivityIndicator];
    NSLog(@"sender.tag = %d",sender.tag);
    if(sender.tag == 0)
    {
      //  [[CameraEngine engine] shutdown];
        cameraToggleSwitch.on = NO;

        [self.view addSubview:bgImageForSwitch];
        [self.view addSubview:switchCameraImage];
        [self.view addSubview:switchVideoImage];
        [self.view addSubview:cameraToggleSwitch];
        [self.view addSubview:imageCaptureButton];
        [self.view addSubview:cameraButton];
        switchVideoImage.image = [UIImage imageNamed:@"video_recic.png"];
        switchCameraImage.image = [UIImage imageNamed:@"photoimg.png"];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic_on.jpg"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        
        videoTime.alpha = 0.0;
        textViewBgImage.alpha = 0.0;
        saveText.alpha = 0.0;
        cancleText.alpha = 0.0;
        noteTextView.alpha = 0.0;
        videoRecordingView.alpha = 0.0;
        imageCaptureButton.alpha = 1.0;
        cameraButton.alpha = 1.0;
        [self.view addSubview:imageCaptureButton];
        [self.view addSubview:cameraButton];
        audioRecordView.alpha = 0.0;
        noteTextView.alpha = 0.0;
        cameraToggleSwitch.alpha = 1.0;
        viewForRecording.alpha = 1.0;
        startVideo.alpha = 0.0;
        stopVideo.alpha = 0.0;
        bgImageForSwitch.alpha = 1.0;
        switchVideoImage.alpha = 1.0;
        switchCameraImage.alpha = 1.0;
        
        
//        [self.lView addSubview:bgImageForSwitchLand];
//        [self.lView addSubview:switchCameraImageLand];
//        [self.lView addSubview:switchVideoImageLand];
//        [self.lView addSubview:cameraToggleSwitchLand];
//        [self.lView addSubview:imageCaptureButtonLand];
//        [self.lView addSubview:cameraButtonLand];
//        switchVideoImageLand.image = [UIImage imageNamed:@"video_recic.png"];
//        switchCameraImageLand.image = [UIImage imageNamed:@"photoimg.png"];
//        videoTimeLand.alpha = 0.0;
//        textViewBgImageLand.alpha = 0.0;
//        saveTextLand.alpha = 0.0;
//        cancleTextLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        videoRecordingViewLand.alpha = 0.0;
//        imageCaptureButtonLand.alpha = 1.0;
//        cameraButtonLand.alpha = 1.0;
//        [self.lView addSubview:imageCaptureButtonLand];
//        [self.lView addSubview:cameraButtonLand];
//        audioRecordViewLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 1.0;
//        viewForRecordingLand.alpha = 1.0;
//        startVideoLand.alpha = 0.0;
//        stopVideoLand.alpha = 0.0;
//        bgImageForSwitchLand.alpha = 1.0;
//        switchVideoImageLand.alpha = 1.0;
//        switchCameraImageLand.alpha = 1.0;

        
        
        [recorder stop];
        [player stop];
        
        [[CameraEngine engine] startup];
        
        AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
        [preview removeFromSuperlayer];
        preview.frame = self.viewForRecording.bounds;
        
        [self.viewForRecording.layer addSublayer:preview];
        
        
    }
    if(sender.tag == 1)
    {
        switchVideoImage.image = [UIImage imageNamed:@"video_ic.png"];
        switchCameraImage.image = [UIImage imageNamed:@"recimg.png"];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic_on.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        
        cameraToggleSwitch.on = YES;
        videoTime.alpha = 1.0;
        textViewBgImage.alpha = 0.0;
        saveText.alpha = 0.0;
        cancleText.alpha = 0.0;
        noteTextView.alpha = 0.0;
        videoRecordingView.alpha = 1.0;
        viewForRecording.alpha = 0.0;
        noteTextView.alpha = 0.0;
        cameraToggleSwitch.alpha = 1.0;
        audioRecordView.alpha = 0.0;
        imageCaptureButton.alpha = 0.0;
        cameraButton.alpha = 1.0;
        bgImageForSwitch.alpha = 1.0;
        switchVideoImage.alpha = 1.0;
        switchCameraImage.alpha = 1.0;
    
        [self.view addSubview:cameraButton];
        [self.view addSubview:startVideo];
        [self.view addSubview:bgImageForSwitch];
        [self.view addSubview:switchCameraImage];
        [self.view addSubview:switchVideoImage];
        [self.view addSubview:cameraToggleSwitch];
        [self.view addSubview:stopVideo];

        startVideo.alpha = 1.0;
        stopVideo.alpha = 1.0;
      
        
        [recorder stop];
        [player stop];

          [[CameraEngine engine] startup];
          
          AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
          [preview removeFromSuperlayer];
          preview.frame = self.videoRecordingView.bounds;
          
          [self.videoRecordingView.layer addSublayer:preview];
        
       
    }
    if(sender.tag == 2)
    {
        [[CameraEngine engine] shutdown];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic_on.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        videoTime.alpha = 0.0;
        textViewBgImage.alpha = 0.0;
        saveText.alpha = 0.0;
        cancleText.alpha = 0.0;
        videoRecordingView.alpha = 0.0;
        noteTextView.alpha = 0.0;
        audioRecordView.alpha = 1.0;
        noteTextView.alpha = 0.0;
        cameraToggleSwitch.alpha = 0.0;
        viewForRecording.alpha = 0.0;
        imageCaptureButton.alpha = 0.0;
        cameraButton.alpha = 0.0;
        startVideo.alpha = 0.0;
        stopVideo.alpha = 0.0;
        bgImageForSwitch.alpha = 0.0;
        switchVideoImage.alpha = 0.0;
        switchCameraImage.alpha = 0.0;

        [stopButton setEnabled:NO];
        [playButton setEnabled:NO];
        
        // Set the audio file
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                   @"MyAudioMemo.m4a",
                                   nil];
        NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        
        // Setup audio session
        AVAudioSession *ausioSession = [AVAudioSession sharedInstance];
        [ausioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        // Define the recorder setting
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        // Initiate and prepare the recorder
        recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:nil];
        recorder.delegate = self;
        recorder.meteringEnabled = YES;
        [recorder prepareToRecord];
        
        
//        videoTimeLand.alpha = 0.0;
//        textViewBgImageLand.alpha = 0.0;
//        saveTextLand.alpha = 0.0;
//        cancleTextLand.alpha = 0.0;
//        videoRecordingViewLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        audioRecordViewLand.alpha = 1.0;
//        noteTextViewLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 0.0;
//        viewForRecordingLand.alpha = 0.0;
//        imageCaptureButtonLand.alpha = 0.0;
//        cameraButtonLand.alpha = 0.0;
//        startVideoLand.alpha = 0.0;
//        stopVideoLand.alpha = 0.0;
//        bgImageForSwitchLand.alpha = 0.0;
//        switchVideoImageLand.alpha = 0.0;
//        switchCameraImageLand.alpha = 0.0;
//        
//        [stopButtonLand setEnabled:NO];
//        [playButtonLand setEnabled:NO];
      
    }
    if(sender.tag == 3)
    {
        
        [[CameraEngine engine] shutdown];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic_on.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        videoTime.alpha = 0.0;
        textViewBgImage.alpha = 1.0;
        videoRecordingView.alpha = 0.0;
        noteTextView.alpha = 0.0;
        cameraToggleSwitch.alpha = 0.0;
        viewForRecording.alpha = 0.0;
        audioRecordView.alpha = 0.0;
        imageCaptureButton.alpha = 0.0;
        cameraButton.alpha = 0.0;
        startVideo.alpha = 0.0;
        stopVideo.alpha = 0.0;
        noteTextView.alpha = 1.0;
        saveText.alpha = 1.0;
        cancleText.alpha = 1.0;
        bgImageForSwitch.alpha = 0.0;
        switchVideoImage.alpha = 0.0;
        switchCameraImage.alpha = 0.0;
        
        [recorder stop];
        [player stop];

        [self.view addSubview:noteTextView];
        noteTextView.text = @"";
        [noteTextView addSubview:placeHolderTitle];

        
//        videoTimeLand.alpha = 0.0;
//        textViewBgImageLand.alpha = 1.0;
//        videoRecordingViewLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 0.0;
//        viewForRecordingLand.alpha = 0.0;
//        audioRecordViewLand.alpha = 0.0;
//        imageCaptureButtonLand.alpha = 0.0;
//        cameraButtonLand.alpha = 0.0;
//        startVideoLand.alpha = 0.0;
//        stopVideoLand.alpha = 0.0;
//        noteTextViewLand.alpha = 1.0;
//        saveTextLand.alpha = 1.0;
//        cancleTextLand.alpha = 1.0;
//        bgImageForSwitchLand.alpha = 0.0;
//        switchVideoImageLand.alpha = 0.0;
//        switchCameraImageLand.alpha = 0.0;
//        [self.lView addSubview:noteTextViewLand];
//        noteTextViewLand.text = @"";
       //ashwini
        // [noteTextViewLand addSubview:placeHolderTitle];
    }
    if(sender.tag == 4)
    {
        [[CameraEngine engine] shutdown];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone_on.png"] forState:UIControlStateNormal];
//        videoTime.alpha = 0.0;
//        textViewBgImage.alpha = 0.0;
//        saveText.alpha = 0.0;
//        cancleText.alpha = 0.0;
//        videoRecordingView.alpha = 0.0;
//        cameraToggleSwitch.alpha = 0.0;
//        noteTextView.alpha = 0.0;
//        viewForRecording.alpha = 0.0;
//        audioRecordView.alpha = 0.0;
//        imageCaptureButton.alpha = 0.0;
//        cameraButton.alpha = 0.0;
//        startVideo.alpha = 0.0;
//        pauseVideo.alpha = 0.0;
//        resumeVideo.alpha = 0.0;
//        stopVideo.alpha = 0.0;
//        flipCameraForVideo.alpha = 0.0;
//        bgImageForSwitch.alpha = 0.0;
//        switchVideoImage.alpha = 0.0;
//        switchCameraImage.alpha = 0.0;
        deleteNoteIndex=6;
        
        [recorder stop];
        [player stop];
       
    }
    [mainActivityIndicator stopAnimating];
    mainActivityIndicator.alpha = 0.0;
     [self displayScroller];
}

#pragma mark - Video Methods

- (IBAction)startRecording:(id)sender
{
    deleteNoteIndex=0;
    [[CameraEngine engine] setVENDORID:VENDORID];

    cameraButton.alpha = 0.0;
  //   cameraButtonLand.alpha = 0.0;

    if(startVideo.tag == 0)
    {
        [startVideo setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
     //   [startVideoLand setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [[CameraEngine engine] startCapture];
        startVideo.tag =1;
    }
    else if(startVideo.tag==1)
    {
        [startVideo setBackgroundImage:[UIImage imageNamed:@"rec_btn.png"] forState:UIControlStateNormal];
      //  [startVideoLand setBackgroundImage:[UIImage imageNamed:@"rec_btn.png"] forState:UIControlStateNormal];
        [[CameraEngine engine] pauseCapture];
        startVideo.tag=2;
    }
    else if(startVideo.tag ==2)
    {
        [startVideo setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
      //  [startVideoLand setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [[CameraEngine engine] resumeCapture];
        startVideo.tag=1;
    }
}


- (IBAction)stopRecording:(id)sender
{
    deleteNoteIndex=0;
    [startVideo setBackgroundImage:[UIImage imageNamed:@"rec_btn.png"] forState:UIControlStateNormal];

    [[CameraEngine engine] stopCapture];
    startVideo.tag=0;
    cameraButton.alpha = 1.0;
    
  //  [startVideoLand setBackgroundImage:[UIImage imageNamed:@"rec_btn.png"] forState:UIControlStateNormal];
  //  cameraButtonLand.alpha = 1.0;
}


#pragma mark - Audio Methods
- (IBAction)recordPauseTapped:(id)sender {
    deleteNoteIndex=0;
    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
  //  if (!recorder.recording) {
        AVAudioSession *AudioSession = [AVAudioSession sharedInstance];
        [AudioSession setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        //[recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
         //[recordPauseButtonLand setTitle:@"Pause" forState:UIControlStateNormal];
        
   // }
        
        // Pause recording
    
       // [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
       // [recordPauseButtonLand setTitle:@"Record" forState:UIControlStateNormal];
   
    
    [stopButton setEnabled:YES];
    [playButton setEnabled:YES];
    
//    [stopButtonLand setEnabled:YES];
//    [playButtonLand setEnabled:NO];
}

- (IBAction)playTapped:(id)sender {
    deleteNoteIndex=0;
    //    if (!recorder.recording){
    //        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
    //        [player setDelegate:self];
    //        [player play];
    //    }
    [recorder pause];
    [stopButton setEnabled:YES];
   // [playButton setEnabled:YES];

}

- (IBAction)stopTapped:(id)sender {
    [recorder stop];
    deleteNoteIndex=0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy||HH:mm:SS"];
    NSDate *now = [[NSDate alloc] init];
    NSString*  theDate = [dateFormat stringFromDate:now];
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Photos"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    
    
    NSData  *AUDIODATA = [NSData dataWithContentsOfURL:recorder.url];
    NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-audio.mp3",documentsDirectory,theDate]];
    
    //                        NSString *videopath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/video.mp4",documentsDirectory]];
    
    
    BOOL success = [AUDIODATA writeToFile:imagepath atomically:NO];
    
    NSLog(@"Successs:::: %@", success ? @"YES" : @"NO");
    NSLog(@"Image path --> %@",imagepath);
    
    NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor"];
    [self displayAll:insertquery1];
    
    NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_content ( content_name , vendor_id , tags , title , content_size , description , website , created_date , update_date , is_deleted , delete_date, path,type) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", @"vendor1", VENDORID,@"photo1",@"picture",@"s",@"dsfsadsa",@"dfafaf",@"1",@"1",@"1",@"1",imagepath,@"audio"];
    
    //         NSLog(@"")
    
    
    
    
    
    [self saveData:insertquery];
    
    
/*
    
    NSURL *audiourl = [NSURL URLWithString:@"http://apps.medialabs24x7.com/buyerspick/uploadtest.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:audiourl];
    NSError*err;
    NSData *postData = [NSData dataWithContentsOfFile:imagepath options: 0 error:&err];
    [request addData:postData withFileName:@"BuyersPicksAppRecording.mp3" andContentType:@"audio/mp3" forKey:@"uploaded_file"];
    [request setDelegate:self];
    [request startAsynchronous];
*/
    
//    NSString   *fetchdata = [NSString stringWithFormat:@"select path, type  from ba_tbl_content"];
//    [self displayContentData:fetchdata];
    
//    [self displayScroller];

    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}



- (IBAction)pauseTapped:(id)sender {
}

//******** AVAudioRecorderDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{

    [stopButton setEnabled:NO];
    [playButton setEnabled:NO];
    
 
//    [stopButtonLand setEnabled:NO];
//    [playButtonLand setEnabled:NO];

}

//******** AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
                                                    message: @"Finish playing the recording!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark - Camera Methods



-(IBAction)FlipCamera:(id)sender
{
    deleteNoteIndex=0;
    // [[CameraEngine engine] shutdown];
    
     //   if ([device hasMediaType:AVMediaTypeVideo]) {
    
            
            if (cameraTag == 0) {
                
                NSLog(@"back cameratag = %d",cameraTag);
             
                cameraTag = 1;
                [[CameraEngine engine]  setCameraTag:cameraTag];

            }
            
           else if (cameraTag == 1){
                
                NSLog(@"front cameratag = %d",cameraTag);
               cameraTag=0;
               [[CameraEngine engine]  setCameraTag:cameraTag];

               
            }
    
    //    }
    if (cameraToggleSwitch.on) {
        cameraToggleSwitch.on = YES;
        
        switchVideoImage.image = [UIImage imageNamed:@"video_ic.png"];
        switchCameraImage.image = [UIImage imageNamed:@"recimg.png"];
        [navCameraButton setImage:[UIImage imageNamed:@"cameraic.png"] forState:UIControlStateNormal];
        [videoButton setImage:[UIImage imageNamed:@"videoic_on.png"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
        [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
        videoTime.alpha = 1.0;
        textViewBgImage.alpha = 0.0;
        saveText.alpha = 0.0;
        cancleText.alpha = 0.0;
        noteTextView.alpha = 0.0;
        videoRecordingView.alpha = 1.0;
        viewForRecording.alpha = 0.0;
        noteTextView.alpha = 0.0;
        cameraToggleSwitch.alpha = 1.0;
        audioRecordView.alpha = 0.0;
        imageCaptureButton.alpha = 0.0;
        cameraButton.alpha = 1.0;
        bgImageForSwitch.alpha = 1.0;
        switchVideoImage.alpha = 1.0;
        switchCameraImage.alpha = 1.0;
        
        [self.view addSubview:cameraButton];
        [self.view addSubview:startVideo];
        [self.view addSubview:stopVideo];
        [self.view addSubview:bgImageForSwitch];
        [self.view addSubview:switchCameraImage];
        [self.view addSubview:switchVideoImage];
        [self.view addSubview:cameraToggleSwitch];
        
        startVideo.alpha = 1.0;
        stopVideo.alpha = 1.0;
        
        
        [recorder stop];
        [player stop];
        
        [[CameraEngine engine] startup];
        
        AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
        [preview removeFromSuperlayer];
        preview.frame = self.videoRecordingView.bounds;
        
        [self.videoRecordingView.layer addSublayer:preview];
        
        
//        cameraToggleSwitchLand.on = YES;
//        
//        switchVideoImageLand.image = [UIImage imageNamed:@"video_ic.png"];
//        switchCameraImageLand.image = [UIImage imageNamed:@"recimg.png"];
//        videoTimeLand.alpha = 1.0;
//        textViewBgImageLand.alpha = 0.0;
//        saveTextLand.alpha = 0.0;
//        cancleTextLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        videoRecordingViewLand.alpha = 1.0;
//        viewForRecordingLand.alpha = 0.0;
//        noteTextViewLand.alpha = 0.0;
//        cameraToggleSwitchLand.alpha = 1.0;
//        audioRecordViewLand.alpha = 0.0;
//        imageCaptureButtonLand.alpha = 0.0;
//        cameraButtonLand.alpha = 1.0;
//        bgImageForSwitchLand.alpha = 1.0;
//        switchVideoImageLand.alpha = 1.0;
//        switchCameraImageLand.alpha = 1.0;
//        
//        [self.lView addSubview:cameraButtonLand];
//        [self.lView addSubview:startVideoLand];
//        [self.lView addSubview:stopVideoLand];
//        [self.lView addSubview:bgImageForSwitchLand];
//        [self.lView addSubview:switchCameraImageLand];
//        [self.lView addSubview:switchVideoImageLand];
//        [self.lView addSubview:cameraToggleSwitchLand];
//        
//        startVideoLand.alpha = 1.0;
//        stopVideoLand.alpha = 1.0;
      
        
//        AVCaptureVideoPreviewLayer* previewLand = [[CameraEngine engine] getPreviewLayer];
//        [previewLand removeFromSuperlayer];
//        previewLand.frame = self.videoRecordingViewLand.bounds;
//        
//        [self.videoRecordingViewLand.layer addSublayer:previewLand];

    }
   else
   {
       cameraToggleSwitch.on = NO;
       
       switchVideoImage.image = [UIImage imageNamed:@"video_recic.png"];
       switchCameraImage.image = [UIImage imageNamed:@"photoimg.png"];
       [navCameraButton setImage:[UIImage imageNamed:@"cameraic_on.jpg"] forState:UIControlStateNormal];
       [videoButton setImage:[UIImage imageNamed:@"videoic.png"] forState:UIControlStateNormal];
       [audioButton setImage:[UIImage imageNamed:@"micic.png"] forState:UIControlStateNormal];
       [noteButton setImage:[UIImage imageNamed:@"noteic.png"] forState:UIControlStateNormal];
       [deleteButton setImage:[UIImage imageNamed:@"zone.png"] forState:UIControlStateNormal];
       [self.view addSubview:bgImageForSwitch];
       [self.view addSubview:switchCameraImage];
       [self.view addSubview:switchVideoImage];
       [self.view addSubview:cameraToggleSwitch];
       [self.view addSubview:imageCaptureButton];
       [self.view addSubview:cameraButton];
       
       videoTime.alpha = 0.0;
       textViewBgImage.alpha = 0.0;
       saveText.alpha = 0.0;
       cancleText.alpha = 0.0;
       noteTextView.alpha = 0.0;
       videoRecordingView.alpha = 0.0;
       imageCaptureButton.alpha = 1.0;
       cameraButton.alpha = 1.0;
       [self.view addSubview:imageCaptureButton];
       [self.view addSubview:cameraButton];
       audioRecordView.alpha = 0.0;
       noteTextView.alpha = 0.0;
       cameraToggleSwitch.alpha = 1.0;
       viewForRecording.alpha = 1.0;
       startVideo.alpha = 0.0;
       stopVideo.alpha = 0.0;
       bgImageForSwitch.alpha = 1.0;
       switchVideoImage.alpha = 1.0;
       switchCameraImage.alpha = 1.0;
       

       
       [recorder stop];
       [player stop];
       
       [[CameraEngine engine] startup];
       
       AVCaptureVideoPreviewLayer* preview = [[CameraEngine engine] getPreviewLayer];
       [preview removeFromSuperlayer];
       preview.frame = self.viewForRecording.bounds;
       
       [self.viewForRecording.layer addSublayer:preview];
       
       
//       cameraToggleSwitchLand.on = NO;
//       
//       switchVideoImageLand.image = [UIImage imageNamed:@"video_recic.png"];
//       switchCameraImageLand.image = [UIImage imageNamed:@"photoimg.png"];
//       [self.lView addSubview:bgImageForSwitchLand];
//       [self.lView addSubview:switchCameraImageLand];
//       [self.lView addSubview:switchVideoImageLand];
//       [self.lView addSubview:cameraToggleSwitchLand];
//       [self.lView addSubview:imageCaptureButtonLand];
//       [self.lView addSubview:cameraButtonLand];
//       
//        videoTimeLand.alpha = 0.0;
//       textViewBgImageLand.alpha = 0.0;
//       saveTextLand.alpha = 0.0;
//       cancleTextLand.alpha = 0.0;
//       noteTextViewLand.alpha = 0.0;
//       videoRecordingViewLand.alpha = 0.0;
//       imageCaptureButtonLand.alpha = 1.0;
//       cameraButtonLand.alpha = 1.0;
//       [self.lView addSubview:imageCaptureButtonLand];
//       [self.lView addSubview:cameraButtonLand];
//       audioRecordViewLand.alpha = 0.0;
//       noteTextViewLand.alpha = 0.0;
//       cameraToggleSwitchLand.alpha = 1.0;
//       viewForRecordingLand.alpha = 1.0;
//       startVideoLand.alpha = 0.0;
//       stopVideoLand.alpha = 0.0;
//       bgImageForSwitchLand.alpha = 1.0;
//       switchVideoImageLand.alpha = 1.0;
//       switchCameraImageLand.alpha = 1.0;

       
//       AVCaptureVideoPreviewLayer* previewLand = [[CameraEngine engine] getPreviewLayer];
//       [previewLand removeFromSuperlayer];
//       previewLand.frame = self.viewForRecordingLand.bounds;
//       
//       [self.viewForRecordingLand.layer addSublayer:previewLand];

   }

}

/*-(IBAction)captureNow {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection)
        {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments)
         {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
         } else
         {
             NSLog(@"no attachments");
         }
         
         AllNotes = [[NSMutableDictionary alloc]init];
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
         
         [imageArray addObject:image];
          NSLog(@"imageArray addObject= %@",imageArray);
         
         saveImage = [[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 165, 157)];
         saveImage.image = image;
         [noteScroller addSubview:saveImage];
         UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
         
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectory = [paths objectAtIndex:0];
         
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
         [dateFormat setDateFormat:@"dd-MM-yyyy||HH:mm:SS"];
         NSDate *now = [[NSDate alloc] init];
         NSString*  theDate = [dateFormat stringFromDate:now];
         
         NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Photos"];
         
         if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
             [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
         
         NSString *imagepath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@-image.png",documentsDirectory,theDate]];
         
         
         BOOL success = [imageData writeToFile:imagepath atomically:NO];
         
         NSLog(@"Successs:::: %@", success ? @"YES" : @"NO");
         NSLog(@"Image path --> %@",imagepath);
         
         
         
         
         NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_content ( content_name , vendor_id , tags , title , content_size , description , website , created_date , update_date , is_deleted , delete_date, path,type) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", @"vendor1", @"1",@"photo1",@"picture",@"s",@"dsfsadsa",@"dfafaf",@"1",@"1",@"1",@"1",imagepath,@"image"];
         
            [self saveData:insertquery];
         
         
             NSString   *fetchdata = [NSString stringWithFormat:@"select path, type  from ba_tbl_content"];
         [self displayContentData:fetchdata];
         

     }];
    
    [AllNotes setObject:imageArray forKey:@"imageKey"];
    
    NSLog(@"AllNotes setObject = %@",AllNotes);
    

    [self displayImages];
}*/


-(IBAction)captureNow {
    deleteNoteIndex=0;
    [[CameraEngine engine] setVENDORID:VENDORID];
    [[CameraEngine engine] imageCapture];

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
}

- (IBAction) toggleEnabledTextForSwitch1onSomeLabel: (UISwitch *) sender {
    deleteNoteIndex=0;
    if (sender==cameraToggleSwitch) {
        
        if (cameraToggleSwitch.on)
        {
            
            NSLog(@"1");
            cameraToggleSwitch.tag = 1;
         //    cameraToggleSwitchLand.tag = 1;
            [self.view addSubview:cameraButton];
            [self.view addSubview:startVideo];
            [self.view addSubview:bgImageForSwitch];
            [self.view addSubview:switchCameraImage];
            [self.view addSubview:switchVideoImage];
            [self.view addSubview:cameraToggleSwitch];
            [self.view addSubview:stopVideo];

            videoTime.alpha = 0.0;
            startVideo.alpha = 1.0;
            stopVideo.alpha = 1.0;
            imageCaptureButton.alpha = 0.0;
            switchVideoImage.image = [UIImage imageNamed:@"video_ic.png"];
            switchCameraImage.image = [UIImage imageNamed:@"recimg.png"];
            
            
            
//            [self.lView addSubview:cameraButtonLand];
//            [self.lView addSubview:startVideoLand];
//            [self.lView addSubview:bgImageForSwitchLand];
//            [self.lView addSubview:switchCameraImageLand];
//            [self.lView addSubview:switchVideoImageLand];
//            [self.lView addSubview:cameraToggleSwitchLand];
//            [self.lView addSubview:stopVideoLand];
//            
//            videoTimeLand.alpha = 0.0;
//            startVideoLand.alpha = 1.0;
//            stopVideoLand.alpha = 1.0;
//            imageCaptureButtonLand.alpha = 0.0;
//            switchVideoImageLand.image = [UIImage imageNamed:@"video_ic.png"];
//            switchCameraImageLand.image = [UIImage imageNamed:@"recimg.png"];


        }
        else
        {
           // NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
           // [setUserDefaults setInteger:0 forKey:@"cameraToggleSwitch"];
            NSLog(@"0");
            cameraToggleSwitch.tag = 0;
           // cameraToggleSwitchLand.tag = 0;
        }
    }
    [cameraToggleSwitch addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventValueChanged];
    // [cameraToggleSwitchLand addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - TextView Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [saveText setEnabled:YES];
    [placeHolderTitle removeFromSuperview];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [saveText setEnabled:YES];
    if(![textView hasText])
    {
        [textView addSubview:placeHolderTitle];
    }
}


-(void)textViewDidChange:(UITextView *)textView
{
    
    if(![textView hasText])
    {
        [textView addSubview:placeHolderTitle];
        [saveText setEnabled:NO];
    }
    else if([[textView subviews]containsObject:placeHolderTitle])
    {
        [placeHolderTitle removeFromSuperview];
        [saveText setEnabled:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextView *)textView
{
       return YES;
    
}


//ashwini
- (IBAction)saveText:(id)sender
{
    deleteNoteIndex=0;
    if(noteTextView.hasText == YES)
    {
             savedDescription = [[NSString alloc]initWithString:noteTextView.text];
         NSLog(@"savedDescription = %@",savedDescription);
        
        
  //     NSInteger lastRowId = sqlite3_last_insert_rowid(yourdatabasename);
//        NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor"];
//        [self displayAll:insertquery1];
        
        NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_content ( content_name , vendor_id , tags , title , content_size , description , website , created_date , update_date , is_deleted , delete_date, path,type) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", @"vendor1", VENDORID,@"photo1",@"picture",@"s",@"dsfsadsa",@"dfafaf",@"1",@"1",@"1",@"1",savedDescription,@"text"];
        
        //         NSLog(@"")
        [self saveData:insertquery];
        
        
        
        //    NSString   *fetchdata = [NSString stringWithFormat:@"select path, type  from ba_tbl_content"];
        //    [self displayContentData:fetchdata];
        
        
        
        noteTextView.text = @"";
        [noteTextView addSubview:placeHolderTitle];
        
        [noteTextView resignFirstResponder];
        //ashwini
//        noteTextViewLand.text = @"";
//        [noteTextViewLand addSubview:placeHolderTitle];
//        
//        [noteTextViewLand resignFirstResponder];

    }
    else
    {
        UIAlertView *textAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter a text" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        textAlert.tag = 1;
        [textAlert show];

    }
   
    [self displayScroller];
    [saveText setEnabled:NO];

}

- (IBAction)cancleText:(id)sender
{
    deleteNoteIndex=0;
    noteTextView.text = @"";
    [noteTextView addSubview:placeHolderTitle];
    [noteTextView resignFirstResponder];
  //ashwini
//    noteTextViewLand.text = @"";
//    [noteTextViewLand addSubview:placeHolderTitle];
//    [noteTextViewLand resignFirstResponder];
    
    [self displayScroller];
}
#pragma mark Async Hit to Server

- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    NSLog(@"requestFinished=%@",receivedString);
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success Message" message:@"Data Uploaded" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    NSLog(@"requestFailed=%@",receivedString);
    
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Failed Message" message:@"Data Uploaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
}


#pragma mark - Orientation Methods
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[CameraEngine engine] shutdown];

    [progressUpdateTimer invalidate];
    progressUpdateTimer =nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(displayScroller) userInfo:nil repeats:YES];

    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];

    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
    }
    
    else if(ori == UIInterfaceOrientationPortrait ||ori ==UIInterfaceOrientationPortraitUpsideDown)
    {
      
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];


    }
    
    NSUInteger check = [[NSUserDefaults standardUserDefaults] integerForKey:@"cameraToggleSwitch"];
    if (check==1) {
        [cameraToggleSwitch setOn:YES];
     //    [cameraToggleSwitchLand setOn:YES];
    }
    else
    {
        [cameraToggleSwitch setOn:NO];
      //  [cameraToggleSwitchLand setOn:NO];
    }

//    cameraToggleSwitch.transform = CGAffineTransformMakeScale(2.0, 0.4);
    [[CameraEngine engine] startup];

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
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];

    }
    
}

- (UIColor *) colorWithHexString: (NSString *) hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
	
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
    if ([cString length] != 6) return  [UIColor grayColor];
	
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
