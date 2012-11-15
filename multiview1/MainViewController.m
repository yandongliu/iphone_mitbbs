//
//  view1.m
//  multiview1
//
//  Created by Yandong Liu on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "MitbbsFrontpageEntry.h"
//#import "ArticleContentViewController.h"
#import "ArticleContentViewControllerWebView.h"

#define REFRESH_HEADER_HEIGHT 52.0f

@implementation MainViewController

//@synthesize feeds = _feeds;

//@synthesize global_nc = _global_nc;
@synthesize reloading = _reloading;



@synthesize allEntries = _allEntries;
@synthesize allVC = _allVC;


@synthesize DOWNLOADING = _DOWNLOADING;
//@synthesize vc_web = _vc_web;
//@synthesize download_page_delegate = _download_page_delegate;
//@synthesize appDelegate = _appDelegate;


-(void)dealloc
{
    NSLog(@"view 1 dealloc");
    
    [self.allEntries release];
    [_refreshHeaderView release];
    
    //[_feeds release];
    //_feeds = nil;
    
    [super dealloc];
    
}




- (void)update_mitbbs_frontpage:(NSString*) delete {
    //self.DOWNLOADING = DOWNLOADING_FRONTPAGE;
    //NSLog(@"add download_frontpage request");
    NSURL* url = [NSURL URLWithString:@"http://www.mitbbs.com"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self.allVC.download_frontpage_delegate];
    [[self.allVC.download_frontpage_delegate queue] addOperation:request];
    request.userInfo = [NSDictionary dictionaryWithObject:delete  forKey:@"delete"];
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAppDelegate:(AppDelegate*) a
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title = @"items";
//        //self.appDelegate = a;
//    }
//    return self;
//}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withVCWeb:(ArticleContentViewControllerWebView*) v withDownloadDelegate:(Util_download_pages*) d
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title = @"items";
//        //self.vc_web = v;
//        //self.download_page_delegate = d;
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAllVC:(AllViewControllers *)a
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"items";
        self.allVC = a;
        self.tabBarItem.title=@"Main";
        self.tabBarItem.image = [UIImage imageNamed:@"148-doghouse.png"];

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

- (void) array_test {
    NSLog(@"array_test begins.");
    NSMutableArray* a = [NSMutableArray array];
    NSString* aa = @"aadd";
    [a addObject:@"hello"];
    [a addObject:aa];
    NSLog(@"joined:%@", [a componentsJoinedByString:@","]);
    [a removeAllObjects];
    NSLog(@"array_test finishes.");
}


- (void) init_stuff {
    //[self init_regex];
    //self.DOWNLOADING = DOWNLOADING_IDLE;

    //[download_page_delegate initWithView1:self];
    //download_frontpage_delegate = [[Util_download_frontpage alloc] initWithView1:self];
    //[download_frontpage_delegate initWithView1:self];
    
    //self.vc_web.global_nc = self.global_nc;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.allEntries = [[NSMutableArray alloc] init];
    //self.ma_msgs = [[NSMutableArray alloc] init];
    
    //[self array_test];
        
    if (_refreshHeaderView == nil) {
        
		//EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] 
                                           //initWithFrame:CGRectMake(0.0f, 
                                                                    //0.0f - self.tableView.bounds.size.height, 
                                                                    //self.view.frame.size.width, 
                                                                    //self.tableView.bounds.size.height)];
		//view.delegate = self;
		//[self.tableView addSubview:view];
		//_refreshHeaderView = view;
		//[view release];
        
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] 
                                           initWithFrame:CGRectMake(0.0f, 
                                                                    0.0f - self.tableView.bounds.size.height, 
                                                                    self.view.frame.size.width, 
                                                                    self.tableView.bounds.size.height)];
		_refreshHeaderView.delegate = self;
		[self.tableView addSubview:_refreshHeaderView];
	}
    
    [self init_stuff];
    
    //NSLog(@"system name:%@",[[UIDevice currentDevice] systemName]);
    //NSLog(@"system version:%@",[[UIDevice currentDevice] systemVersion]);
    
    //UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"UIStockImageUnderPageBackground.png"]];
    //self.tableView.backgroundView = imageView;
    //[imageView release];
    
    [self update_mitbbs_frontpage:@"no"];
    


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    NSLog(@"viewDidUnload");
    //[download_page_delegate release];
    //download_page_delegate = nil;
    //[download_frontpage_delegate release];
    //download_frontpage_delegate = nil;
    //[self.vc_web release];
    //self.vc_web = nil;
    //[_ma_msgs release];
    //_ma_msgs = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.global_nc setNavigationBarHidden:TRUE];
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

    return [_allEntries count];
}

- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //NSLog(@"tableVIew select: #entries:%d. current row:%d", [_allEntries count], indexPath.row);
    MitbbsFrontpageEntry *entry = [_allEntries objectAtIndex:indexPath.row];
    //NSLog(@"selected entry title:%@ url:%@", entry.title, entry.url);
    //3366CC
    
    //float r = (float)((0x000066 & 0xFF0000) >> 16)/255.0;
    //float g = (float)((0x000066 & 0xFF00) >> 8)/255.0 ;
    //float b = (float)(0x000066 & 0xFF)/255.0;
    //r=0.22;g=0.33;b=0.53;
    //UIColor* color_myblue = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    //cell.textLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16.0];
    //cell.textLabel.textColor = color_myblue; //each is between 0 and 1
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = entry.title;        
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",entry.category];
    
    //cell.textLabel.text = [_allEntries objectAtIndex:indexPath.row];        
    //cell.detailTextLabel.text = @"detail";
    
    return cell;
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
    //ArticleContentViewController* vc = [[ArticleContentViewController alloc] initWithNibName:@"ArticleContentViewController" bundle:nil];
    
   //vc_web = [[ArticleContentViewControllerWebView alloc] initWithNibName:@"ArticleContentViewControllerWebView" bundle:nil];vc_web = [[ArticleContentViewControllerWebView alloc] initWithNibName:@"ArticleContentViewControllerWebView" bundle:nil];
    
//    if (_vc_web == nil) {
//        _vc_web = [[ArticleContentViewControllerWebView alloc] initWithNibName:@"ArticleContentViewControllerWebView" bundle:nil];
//    }
    
    MitbbsFrontpageEntry *entry = [_allEntries objectAtIndex:indexPath.row];
    
    //NSLog(@"selected url:%@", entry.url);
    
    [self.navigationController pushViewController:self.allVC.vc_web animated:TRUE];
    //[self.tabBarController.navigationController pushViewController:self.vc_web animated:TRUE];
    [self.allVC.vc_web.webview setDelegate:self.allVC.download_page_delegate];
    self.allVC.vc_web.posturl = [NSString stringWithFormat:@"http://www.mitbbs.com/article_t/%@", entry.url];
    self.allVC.vc_web.postdesc=nil;
    //NSLog(@"webview is shown");
    [self.allVC.download_page_delegate parse_mitbbs_one_article_all_pages_with_baseurl:entry.url Title:entry.title ];
    //self.allVC.[self.global_nc setNavigationBarHidden:FALSE];
    //[self.vc_web print_init_content];
    //[vc release];
    
}


- (void)doneLoadingTableViewData{
    //NSLog(@"doneLoadingTableViewData");
	//  model should call this when its done loading
	_reloading = NO;
    //NSLog(@"self.tableView:%@", self.tableView);
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)reloadTableViewDataSource{
    
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    
    [self update_mitbbs_frontpage:@"yes"];
    
    //[self tableView] reloadData];
    
    //[self doneLoadingTableViewData];
	
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
    
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    NSLog(@"egoRefreshTableHeaderDidTriggerRefresh");
	//[self performSelectorOnMainThread:@selector(reloadTableViewDataSource) withObject:nil waitUntilDone:NO];
    [self update_mitbbs_frontpage:@"yes"];
    //[self doneLoadingTableViewData];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    //NSLog(@"egoRefreshTableHeaderDataSourceIsLoading");
	return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    //NSLog(@"egoRefreshTableHeaderDataSourceLastUpdated");
	return [NSDate date]; // should return date data source was last changed
    
}

@end
