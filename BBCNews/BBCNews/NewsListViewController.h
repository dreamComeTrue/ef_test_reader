//
//  NewsListViewController.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface NewsListViewController : UITableViewController {
    NSArray *_news;
    Reachability *_reachability;
}

@end
