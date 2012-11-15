//
//  BoardListViewController.m
//  multiview1
//
//  Created by Yandong Liu on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoardListViewController.h"

@implementation BoardListViewController

@synthesize allEntries = _allEntries;
@synthesize allEntries_copy = _allEntries_copy;
//@synthesize boardItemsViewController = _boardItemsViewController;
@synthesize allVC = _allVC;
@synthesize searchBar = _searchBar;

- (void) dealloc {
    [self.allEntries release];
    [self.allEntries_copy release];
    [super dealloc];
}

- (void) add_download_request_withNSURL:(NSURL*) u {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:u];
    [request setDelegate:self.allVC.util_download_boardname];
    [[self.allVC.util_download_boardname queue] addOperation:request];
}

- (void) add_download_request_withNSString:(NSString*) u {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:u]];
    [request setDelegate:self.allVC.util_download_boardname];
    [[self.allVC.util_download_boardname queue] addOperation:request];
}

- (void)update_mitbbs_boardnames {
    //self.DOWNLOADING = DOWNLOADING_FRONTPAGE;
    NSLog(@"add download_board request");
    for(int i=0;i<=12;i++) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mitbbs.com/bbsboa/%d.html", i]];
        [self add_download_request_withNSURL:url];
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        [request setDelegate:self.allVC.util_download_boardname];
//        [[self.allVC.util_download_boardname queue] addOperation:request];
    }
    
    [self add_download_request_withNSString:@"http://www.mitbbs.com/mitbbs_bbsboa.php?group=2&yank=0&group2=337"];//usa
    
    [self add_download_request_withNSString:@"http://www.mitbbs.com/mitbbs_bbsboa.php?group=0&yank=0&group2=389"]; //overseanews
    
    [self add_download_request_withNSString:@"http://www.mitbbs.com/mitbbs_bbsboa.php?group=1&yank=0&group2=444"]; //immigrations
    
    [self add_download_request_withNSString:@"http://www.mitbbs.com/mitbbs_bbsboa.php?group=2&yank=0&group2=345"];//canada
   }

- (void) init_stuff {
    //self.allVC.util_download_boardnames = [[Util_download_boardname alloc] init_withBoardView:self];
    self.allEntries = [[NSMutableArray alloc] init];
    self.allEntries_copy = [[NSMutableArray alloc] init];
    [self.searchBar setDelegate:self];
    //self.navigationController.navigationBarHidden = TRUE;
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first 
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing");
    // only show the status bar’s cancel button while in edit mode
    //self.searchBar.showsCancelButton = YES;
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    //self.tableView.allowsSelection = NO;
    //self.tableView.scrollEnabled = NO;
    // flush the previous search content
    //[self.allEntries removeAllObjects];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
    self.searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
    //NSMutableArray* array = [NSMutableArray arrayWithArray:self.allEntries];
    [self.allEntries removeAllObjects];
    NSLog(@"array copy count:%d", [self.allEntries_copy count]);
    //[self.allEntries removeAllObjects];// remove all data that belongs to previous search
    if([searchText isEqualToString:@""] || searchText==nil){
        [self.tableView reloadData];
        return;
    }
    NSInteger counter = 0;
    for(MitbbsBoard *board in self.allEntries_copy)
    {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
        NSString* name = board.eng;
        //name rangeOfString:searchText options:NSString
        NSRange r = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(r.location != NSNotFound)
        {
            //if(r.location== 0)//that is we are checking only the start of the names.
            //{
                [self.allEntries addObject:board];
            //}
        }
        counter++;
        [pool release];
    }
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // if a valid search was entered but the user wanted to cancel, bring back the main list content
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    self.searchBar.text = @"";
    //self.tableView.allowsSelection = YES;
    //self.tableView.scrollEnabled = YES;
    
    [self.allEntries removeAllObjects];
    [self.allEntries  addObjectsFromArray:self.allEntries_copy];
    @try{
        [self.tableView reloadData];
    }
    @catch(NSException *e){
    }
    
}

// called when Search (in our case “Done”) button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Boards";
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers *)a
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Boards";
        self.allVC = a;
        self.tabBarItem.image = [UIImage imageNamed:@"104-index-cards.png"];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self init_stuff];
    [self update_mitbbs_boardnames];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //[util_download_boardname release];
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
    // Return the number of rows in the section.
    return [self.allEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    MitbbsBoard* board = [self.allEntries objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", board.chn, board.eng];
    
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
    MitbbsBoard* board = [_allEntries objectAtIndex:indexPath.row];
    
    //NSLog(@"selected url:%@", entry.eng);
    
    BoardItemsViewController* nextpage = [[[BoardItemsViewController alloc] initWithNibName:@"BoardItemsViewController" bundle:nil withAllVC:self.allVC] autorelease] ;
    //[self.navigationController pushViewController:nextpage animated:TRUE];
    //nextpage.title = self.title;
    //[nextpage update_mitbbs_boarditems_withBoardName:current_boardname fromPage:current_page+50];

    
    //[self.navigationController pushViewController:self.allVC.boardItemsViewController animated:TRUE];
    [self.navigationController pushViewController:nextpage animated:TRUE];
    //self.allVC.boardItemsViewController.title = board.chn;
    nextpage.title = board.chn;
    //[self.allVC.boardItemsViewController update_mitbbs_boarditems:board.eng];
    [nextpage update_mitbbs_boarditems:board.eng];
}

@end
