//
//  NewsCell.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *shortDescription;

@end
