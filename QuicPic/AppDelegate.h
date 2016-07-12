//
//  AppDelegate.h
//  QuicPic
//
//  Created by Andrew Dulle on 6/22/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Firebase;

#import <GoogleSignIn/GoogleSignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@end


