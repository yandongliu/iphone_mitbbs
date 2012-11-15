//
//  UtilSharing.m
//  multiview1
//
//  Created by Mac User on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UtilFBSharing.h"

@implementation UtilFBSharing
@synthesize facebook=_facebook;
@synthesize messageLabel;
@synthesize messageView;

- (id) init {
    NSLog(@"UtilSharing init");
    
    self = [super init];
    if(self) {
        
    
    
    self.facebook = [[Facebook alloc] initWithAppId:APP_ID andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        NSLog(@"facebook.accessToken:%@", self.facebook.accessToken);
    } else {
        NSLog(@"new login2.");
    }
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"user_likes", 
                            @"read_stream",
                            @"publish_stream",
                            nil];
    
    if (![self.facebook isSessionValid]) {
        //[facebook authorize:nil];
        NSLog(@"facebook authorize2");
        [self.facebook authorize:permissions];
        
    }
    [permissions release];
        
    }
    
    return self;
    
}

- (void) fbDidLogout {
    NSLog(@"fbDidLogout");
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}
- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"fbDidNotLogin.%c", cancelled);
}

- (void)fbDidLogin {
    NSLog(@" fbDidLogin");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self.facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[self.facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"handleOpenURL:%@",url);
    return [self.facebook handleOpenURL:url]; 
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"openURL:%@",url);
    return [self.facebook handleOpenURL:url]; 
}

- (void)showShareDialogWithName:(NSString*) name Link:(NSString*)link Caption:(NSString*) caption Description:(NSString*) desc {
    NSLog(@"showDialog.name:%@ link:%@ caption %@ desc:%@", name,link,caption,desc);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   APP_ID, @"app_id",
                                   link, @"link",
                                   @"http://hyppen.com/mitbbsapp/main@2x.png", @"picture",
                                   name, @"name",
                                   link, @"caption",
                                   desc, @"description",
                                   @"message",  @"message",
                                   nil];
    
    
    [self.facebook dialog:@"feed" andParams:params andDelegate:self];
}

/**
 * Helper method to parse URL query parameters
 */
- (NSDictionary *)parseURLParams:(NSString *)query {
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
	for (NSString *pair in pairs) {
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
		[params setObject:val forKey:[kv objectAtIndex:0]];
	}
    return params;
}

/*
 * This method is used to display API confirmation and
 * error messages to the user.
 */
- (void)showMessage:(NSString *)message {
    CGRect labelFrame = messageView.frame;
    labelFrame.origin.y = [UIScreen mainScreen].bounds.size.height - 20 - 20;
    messageView.frame = labelFrame;
    messageLabel.text = message;
    messageView.hidden = NO;
    
    // Use animation to show the message from the bottom then
    // hide it.
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect labelFrame = messageView.frame;
                         labelFrame.origin.y -= labelFrame.size.height;
                         messageView.frame = labelFrame;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [UIView animateWithDuration:0.5
                                                   delay:3.0
                                                 options: UIViewAnimationCurveEaseOut
                                              animations:^{
                                                  CGRect labelFrame = messageView.frame;
                                                  labelFrame.origin.y += messageView.frame.size.height;
                                                  messageView.frame = labelFrame;
                                              }
                                              completion:^(BOOL finished){
                                                  if (finished) {
                                                      messageView.hidden = YES;
                                                      messageLabel.text = @"";
                                                  }
                                              }];
                         }
                     }];
}

/**
 * Called when a UIServer Dialog successfully return. Using this callback
 * instead of dialogDidComplete: to properly handle successful shares/sends
 * that return ID data back.
 */
- (void)dialogCompleteWithUrl:(NSURL *)url {
    NSLog(@"dialogCompleteWithUrl:%@",url);
    if (![url query]) {
        NSLog(@"User canceled dialog or there was an error");
        return;
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Facebook Sharing" message:@"Posted." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    NSDictionary *params = [self parseURLParams:[url query]];
    
}

- (void)dialogDidComplete:(FBDialog *)dialog {
    NSLog(@" dialogDidComplete.");

}

- (void)dialogDidNotComplete:(FBDialog *)dialog {
    NSLog(@"Dialog dismissed.");
}
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url {
    NSLog(@" dialogDidNotCompleteWithUrl.");
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error {
    NSLog(@"Error message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    [self showMessage:@"Oops, something went haywire."];
}

- (BOOL)dialog:(FBDialog*)dialog shouldOpenURLInExternalBrowser:(NSURL *)url {
    NSLog(@" shouldOpenURLInExternalBrowser.");
    
    return TRUE;
}

- (void) dealloc 
{
    [super dealloc];
}


@end
