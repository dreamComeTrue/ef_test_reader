//
//  NewsItem.m
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

- (instancetype)initWithDictionary:(NSDictionary *)newsDictionary {
    self = [super init];
    if (self) {
        _newsDictionary = newsDictionary;
    }
    return self;
}

- (NSString *)title {
    return _newsDictionary[@"title"];
}

- (NSString *)shortDescription {
    return _newsDictionary[@"description"];
}

@end
