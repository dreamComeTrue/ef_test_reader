//
//  AppDelegate.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

void (^loadNews)();

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
