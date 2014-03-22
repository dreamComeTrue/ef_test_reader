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

@interface NewsListViewController ()

@end

@implementation NewsListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshDataAction:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:strNoteNewsDidLoad object:nil];

    _news = [NewsStorage news];
    //NSLog(@"news: %@", _news);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshDataAction:(id)sender {
    [AppDelegate refreshNews];
}

- (void)reloadData:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NewsItem *item = _news[indexPath.row];
    
#warning Cache image
    cell.imageView.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:item.imageSmallUrl];
        UIImage *img = [UIImage imageWithData:imgData];
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
