//
//  UtilWeiboSharing.m
//  multiview1
//
//  Created by Mac User on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UtilWeiboSharing.h"


@implementation UtilWeiboSharing

@synthesize weiBoEngine;

- (void) init_weibo {
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:myAppKey appSecret:myAppSecret];
    //[engine setRootViewController:vc];
    [engine setDelegate:self];
    [engine setRedirectURI:@"http://"];
    [engine setIsUserExclusive:NO];
    self.weiBoEngine = engine;
    [engine release];
    
}

- (void)onLogInXAuthButtonPressed
{
    WBLogInAlertView *logInView = [[WBLogInAlertView alloc] init];
    [logInView setDelegate:self];
    [logInView show];
    [logInView release];
}

- (void)onLogInOAuthButtonPressed
{
    [weiBoEngine logIn];
}

- (void)onLogOutButtonPressed
{
    [weiBoEngine logOut];
}

- (void)presentTimelineViewController:(BOOL)animated
{
    NSLog(@"presentTimelineViewController");
}

- (void)presentTimelineViewControllerWithoutAnimation
{
    [self presentTimelineViewController:NO];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kWBAlertViewLogInTag)
    {
        [self presentTimelineViewController:YES];
    }
    else if (alertView.tag == kWBAlertViewLogOutTag)
    {
        [self dismissTimelineViewController];
    }
}

- (void)dismissTimelineViewController
{
    //[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - WBLogInAlertViewDelegate Methods

- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
{
    [weiBoEngine logInUsingUserID:userID password:password];
    
    [indicatorView startAnimating];
}

#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    [indicatorView stopAnimating];
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                           message:@"Please log out first" 
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    [indicatorView stopAnimating];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"Successfully logged in. Now you can share." 
													  delegate:self
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogInTag];
	[alertView show];
	[alertView release];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    [indicatorView stopAnimating];
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"Failed to login！" 
													  delegate:nil
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"You are logged out." 
													  delegate:self
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogOutTag];
	[alertView show];
	[alertView release];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"Please login again" 
													  delegate:nil
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark - WBEngineDelegate Methods

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
    [indicatorView stopAnimating];
    NSLog(@"requestDidSucceedWithResult: %@", result);
    if ([result isKindOfClass:[NSDictionary class]])
    {
        //NSDictionary *dict = (NSDictionary *)result;
        //[timeLine addObjectsFromArray:[dict objectForKey:@"statuses"]];
        //[timeLineTableView reloadData];
    }
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
{
    [indicatorView stopAnimating];
    NSLog(@"requestDidFailWithError: %@", error);
}

#pragma mark - WBSendViewDelegate Methods

- (void)sendViewDidFinishSending:(WBSendView *)view
{
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"微博发送成功！" 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"微博发送失败！" 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendViewNotAuthorized:(WBSendView *)view
{
    [view hide:YES];
    
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)sendViewAuthorizeExpired:(WBSendView *)view
{
    [view hide:YES];
    
    //[self dismissModalViewControllerAnimated:YES];
}


- (void)showSharingDialogWithName:(NSString*) name andLink:(NSString*) link
{
    if (![weiBoEngine isLoggedIn] || [weiBoEngine isAuthorizeExpired])
    {
        [weiBoEngine logIn]; 
    }
    
    if ([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired])
    {
        
        WBSendView *sendView = [[WBSendView alloc] initWithAppKey:myAppKey appSecret:myAppSecret text:[NSString stringWithFormat:@"%@ -MitbbsXViewer for iPhone %@", name,link] image:nil];
        [sendView setDelegate:self];
        
        [sendView show:YES];
        [sendView release];
    }
}

- (id)initWithView:(UIView*) view1
{
    //[super viewDidLoad];
    self=[super init];
    if(self) {
	// Do any additional setup after loading the view, typically from a nib.
    [self init_weibo];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 240)];
    [view1 addSubview:indicatorView];
    }
    
//    if ([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired])
//    {
//        [self performSelector:@selector(presentTimelineViewControllerWithoutAnimation) withObject:nil afterDelay:0.0];
//    }
    
//    UIButton* logInBtnOAuth = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [logInBtnOAuth setFrame:CGRectMake(85, 160, 150, 40)];
//    [logInBtnOAuth setTitle:@"Log Out" forState:UIControlStateNormal];
//    [logInBtnOAuth addTarget:self action:@selector(onLogOutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:logInBtnOAuth];
//    
//    UIButton* logInBtnXAuth = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [logInBtnXAuth setFrame:CGRectMake(85, 280, 150, 40)];
//    [logInBtnXAuth setTitle:@"Log In" forState:UIControlStateNormal];
//    [logInBtnXAuth addTarget:self action:@selector(onLogInOAuthButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:logInBtnXAuth];
//    
//    UIButton* btnShare = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btnShare setFrame:CGRectMake(85, 400, 150, 40)];
//    [btnShare setTitle:@"Share" forState:UIControlStateNormal];
//    [btnShare addTarget:self action:@selector(onSendButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btnShare];
    return self;
    
}

@end
