//
//  NewsItemViewController.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsItemViewController : UITableViewController

@property (nonatomic, strong) NewsItem *item;

@end
