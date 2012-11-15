//
//  BoardItemsViewController.m
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardItemsViewController.h"

@implementation BoardItemsViewController

@synthesize allEntries = _allEntries;
//@synthesize vc_web = _vc_web;
//@synthesize download_page_delegate = _download_page_delegate;
@synthesize allVC = _allVC;

- (void) dealloc {
    [self.allEntries release];
    [super dealloc];
}

- (void)update_mitbbs_boarditems:(NSString*)boardname {
    //self.DOWNLOADING = DOWNLOADING_FRONTPAGE;
    NSLog(@"add download_board request:%@", boardname);
    current_page = 1;
    //current_boardname = [[NSString alloc] initWithString:boardname];
    current_boardname = [NSString stringWithString:boardname];
    NSURL * u = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mitbbs.com/bbsdoc/%@.html", boardname]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:u];
    [request setDelegate:self.allVC.util_download_boarditems];
    [[self.allVC.util_download_boarditems queue] addOperation:request];

    
}

- (void)update_mitbbs_boarditems_withBoardName:(NSString*) boardname fromPage:(int)page withTitle:(NSString*) title {
    //self.DOWNLOADING = DOWNLOADING_FRONTPAGE;
    
    //current_page = page;
    //self.navigationItem.leftBarButtonItem.title=@"Last Page";
    //self.navigationItem.backBarButtonItem.title=@"Last Page1";
    //self.navigationItem.title = @"Last page";
    self.title = title;
    current_boardname = [NSString stringWithString:boardname];
    current_page = page;
    NSURL * u = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mitbbs.com/bbsdoc1/%@_%d_0.html", boardname, page]];
    NSLog(@"add download_board request:%@,%@", boardname, u );
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:u];
    [request setDelegate:self.allVC.util_download_boarditems];
    [[self.allVC.util_download_boarditems queue] addOperation:request];
    
}

- (void) init_stuff {
    
    self.allEntries = [[NSMutableArray alloc] init];

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Items";
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers *)a
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"items";
        self.allVC = a;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) push_nextpage {
    NSLog(@"push next page");
    BoardItemsViewController* nextpage = [[BoardItemsViewController alloc] initWithNibName:@"BoardItemsViewController" bundle:nil withAllVC:self.allVC];
    [self.navigationController pushViewController:nextpage animated:TRUE];
    nextpage.title = self.title;
    [nextpage update_mitbbs_boarditems_withBoardName:current_boardname fromPage:current_page+100 withTitle:self.title];
    NSLog(@"self.title;%@", self.title);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self init_stuff];
    //[self update_mitbbs_boarditems:@""];
    UIBarButtonItem* right_btn = [[UIBarButtonItem alloc]  initWithTitle:@"Next Page" style:UIBarButtonItemStylePlain target:self action:@selector(push_nextpage)];
    self.navigationItem.rightBarButtonItem = right_btn;
    
    [right_btn release];
    
    self.allVC.currentBoardItemsViewController = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    MitbbsItem* item = [self.allEntries objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = item.title;
    
    return cell;
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
    MitbbsItem* item = [self.allEntries objectAtIndex:indexPath.row];
    NSLog(@"Loading %@",item.url);
    
    [self.navigationController pushViewController:self.allVC.vc_web animated:TRUE];
    //[self.tabBarController.navigationController pushViewController:self.vc_web animated:TRUE];
    [self.allVC.vc_web.webview setDelegate:self.allVC.download_page_delegate];
    NSLog(@"webview is shown");
    [self.allVC.download_page_delegate parse_mitbbs_one_article_all_pages_with_baseurl:item.url Title:item.title];

    //[self.navigationController pushViewController:<#(UIViewController *)#> animated:TRUE];
}

@end
