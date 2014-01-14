//
//  NoteTableViewController.m
//  Buyer's_Pick_App
//
//  Created by Anish on 1/9/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "NoteTableViewController.h"
#import "noteTableCell.h"

@interface NoteTableViewController ()

@end

@implementation NoteTableViewController
@synthesize tableView = _tableView;
@synthesize searchBar,isFiltered,addedTableView,addedTags,addingTagslable;

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
    dataFwdObj=[DataFwdClass getInstance];
    // Do any additional setup after loading the view from its nib.
    searchedNames = [[NSMutableArray alloc] init];
    addedTags = [[NSMutableArray alloc] initWithArray:dataFwdObj.noteTagsArray];
    NSLog(@"dataFwdObj.noteTagsArray2 %@",dataFwdObj.noteTagsArray);
    names = [[NSMutableArray alloc]initWithObjects:@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar",@"Akshay Jain",@"Anish",@"Ashwini",@"Akshay",@"Anish Pandey",@"Ashwini Pawar",@"Akshay Jain", nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 44, 477, 609) style:UITableViewStylePlain];
    
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.hidden = YES;
    [self.addingTagslable addSubview:_tableView];

//    _tableView.layer.cornerRadius = 15.0;
//    _tableView.clipsToBounds = YES;
//    addedTableView.layer.cornerRadius = 15.0;
//    addedTableView.clipsToBounds = YES;

    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,477,44)];
    searchBar.placeholder=@"Search by Customer Name";
    searchBar.delegate = (id)self;
    [self.addingTagslable addSubview:searchBar];

    UIImage *doneImage = [UIImage imageNamed:@"done.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 3, 64, 37);
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.leftBarButtonItem = customBarItemDone;


}

#pragma mark -
#pragma mark Table view data source

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//	
//    //	if(self.isFiltered)
//    if (tableView == addedTableView) {
//        return @"Current Tags";
//    }
//    
//    return @"Tag List";
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 477, 50)];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 250, 18)];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    if (tableView==addedTableView)
    {
         label.text= @"Current Tags";
    }
    else
    {
       label.text= @"Tag List";
    }
       [view addSubview:label];
    
    [view setBackgroundColor:[self colorWithHexString:@"154049"]];
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (tableView==addedTableView)
    {
        return 1;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"total=%d",[names count]);
	int rowCount;
    if (tableView==addedTableView) {
        rowCount=[addedTags count];
    }
    else
    {
	if(self.isFiltered)
		rowCount = searchedNames.count;
	else
		rowCount = names.count;
    }
	
	return rowCount;
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
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        static NSString *CellIdentifier = @"sorting by date";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
	NSString    *name;
    
    if (tableView==addedTableView)
    {
        cell.textLabel.text=[addedTags objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    else{
	if(isFiltered){
		name = [searchedNames objectAtIndex:indexPath.row];
            }
	else{
		name = [names objectAtIndex:indexPath.row];
       
    }
    
    cell.textLabel.text=name;
    }
    	return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchBar.text=[names objectAtIndex:indexPath.row];
    [self.searchBar resignFirstResponder];

}
-(IBAction)AddTagPressed
{
    if (searchBar.text.length==0) {
        NSLog(@"Baba ji ka Thullu");
    }
    else
    {
    NSString *Tag= searchBar.text;
    [addedTags addObject:Tag];
    [names addObject:Tag];
    addedTableView.hidden=NO;
    _tableView.hidden=YES;
    [self.searchBar resignFirstResponder];
    searchBar.text=nil;

    [addedTableView reloadData];
    }
}


#pragma mark Search Functions
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	NSLog(@"hi");
    addedTableView.hidden=YES;
    _tableView.hidden=NO;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    addedTableView.hidden=NO;
    _tableView.hidden=YES;
    [self.searchBar resignFirstResponder];
}


-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
	if(text.length == 0)
	{
		isFiltered = FALSE;
	}
	else
	{
		isFiltered = true;
		searchedNames = [[NSMutableArray alloc] init];
		
		for (NSString* food in names)
		{
			NSRange nameRange = [food rangeOfString:text options:NSCaseInsensitiveSearch];
			NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
			if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
			{
				[searchedNames addObject:food];
			}
		}
	}
	
	[_tableView reloadData];
}

-(IBAction)BackBtnPressed
{
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray = [[NSMutableArray alloc] initWithArray:addedTags];
    NSLog(@"Back Btn dataFwdObj.noteTagsArray: %@", dataFwdObj.noteTagsArray);


    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
