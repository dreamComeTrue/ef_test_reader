//
//  NewsListViewController.m
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsStorage.h"
#import "NewsItem.h"
#import "NewsCell.h"
#import "NewsItemViewController.h"
#import "AppDelegate.h"
#import "ImageCache.h"
#import "Reachability.h"

@interface NewsListViewController ()

@end

@implementation NewsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshDataAction:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:strNoteNewsDidLoad object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    _reachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    [_reachability startNotifier];

    _news = [NewsStorage news];
    //NSLog(@"news: %@", _news);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshDataAction:(id)sender {
    [NewsStorage refreshNews];
}

- (void)reloadData:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)reachabilityChanged:(NSNotification *)notification {
    if([_reachability currentReachabilityStatus] == NotReachable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Offline" style:UIBarButtonItemStylePlain target:nil action:nil];
        });
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshDataAction:)];
        });
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _news.count > 0 ? _news.count : 1;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_news.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyListCell"];
        UILabel *label = (UILabel *)[cell viewWithTag:1];
        
        label.text = [NewsStorage isLoading] ? @"Loading feed" : @"Feed is empty";
        return cell;
    }
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NewsItem *item = _news[indexPath.row];
    
    cell.imageView.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = [ImageCache imageWithUrl:item.imageSmallUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = img;
            [cell setNeedsLayout];
        });
    });

    cell.title.text = item.title;
    cell.shortDescription.text = item.shortDescription;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsItemViewController *nivc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsItemViewController"];
    nivc.item = _news[indexPath.row];
    [self.navigationController pushViewController:nivc animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
