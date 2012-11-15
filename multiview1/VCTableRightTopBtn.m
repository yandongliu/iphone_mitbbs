//
//  VCTableRightTopBtn.m
//  multiview1
//
//  Created by Mac User on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VCTableRightTopBtn.h"

@implementation VCTableRightTopBtn

@synthesize name;
@synthesize link;
@synthesize caption;
@synthesize desc;
@synthesize content;


- (id)_initWithStyle:(UITableViewStyle)style withWebView:(ArticleContentViewControllerWebView*) a
{
    self = [super initWithStyle:style];
    if (self) {
        array_btns = [[NSArray alloc] initWithObjects:@"Top",@"Bottom",@"Share To FB", nil];
        self.contentSizeForViewInPopover = CGSizeMake(100, array_btns.count * 30+5);
        self.tableView.scrollEnabled = FALSE;
        web_view =a;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style withAllVC:(AllViewControllers*) a
{
    self = [super initWithStyle:style];
    if (self) {
        array_btns = [[NSArray alloc] initWithObjects:@"Scroll to Top",@"Scroll to Bottom",@"Share To Facebook",@"Share to Weibo", @"Add to Bookmark",nil];
        self.contentSizeForViewInPopover = CGSizeMake(135, array_btns.count * 30-1);
        self.tableView.scrollEnabled = FALSE;
        allVC =a;
    }
    return self;
}

- (void) dealloc {
    [array_btns release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [array_btns release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return [indexPath row] * 4+25;
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array_btns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [array_btns objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath  {
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)popoverButtonPressed {
    NSLog(@"Popover Button pressed");
    UIAlertView* alert =  [[UIAlertView alloc] initWithTitle:@"title" message:@"msg" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    switch( indexPath.row) {
        case 0:
            [allVC.vc_web btn_top_touched];
            [allVC.vc_web dismissPopOver];
            break;
        case 1:
            [allVC.vc_web btn_bottom_touched];
            [allVC.vc_web dismissPopOver];
            break;
        case 2:
            if(allVC.util_fbsharing == nil) {
                allVC.util_fbsharing = [[UtilFBSharing alloc]init];
            }
            [allVC.util_fbsharing showShareDialogWithName:self.name Link:self.link Caption:self.caption Description:self.desc];
            [allVC.vc_web dismissPopOver];

            break;
        case 3:
            if(allVC.util_wbsharing == nil) {
                allVC.util_wbsharing = [[UtilWeiboSharing alloc] initWithView:self.view];
            }
            [allVC.util_wbsharing showSharingDialogWithName:name andLink:link];
             //showShareDialogWithName:self.name Link:self.link Caption:self.caption Description:self.desc];
            [allVC.vc_web dismissPopOver];
            
            break;
        case 4:
            [allVC.util_bookmark addBookmark:name andLink:link andContent:content];
            [allVC.vc_web dismissPopOver];
        //case 2:
            //[web_view btn_bottom_touched];
            //[web_view dismissPopOver];
            break;
        default:
            NSLog(@"nothing");
    }
    //[self popoverButtonPressed];
}

@end
