//
//  NewsItemViewController.m
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import "NewsItemViewController.h"
#import "NewsItem.h"

@interface NewsItemViewController ()

@end

@implementation NewsItemViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(openAction:)];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:strNoteNewsDidLoad object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openAction:(id)sender {
    [[UIApplication sharedApplication] openURL:self.item.url];
}

- (void)reloadData:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case 0: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
            UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imgData = [NSData dataWithContentsOfURL:self.item.imageBigUrl];
                UIImage *img = [UIImage imageWithData:imgData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = img;
                });
            });
            break;
        }
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            UILabel *label = (UILabel *)[cell viewWithTag:1];
            label.text = self.item.title;
            break;
        }
        case 2: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
            UITextView *textView = (UITextView *)[cell viewWithTag:1];
            textView.text = self.item.shortDescription;
            break;
        }
        default:
            break;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 179;
        case 1: {
            CGRect frm = [self.item.title boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]} context:nil];
            return frm.size.height;
        }
        case 2: {
            CGRect frm = [self.item.shortDescription boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
            return frm.size.height;
        }
        default:
            return 0;
    }
}

@end
