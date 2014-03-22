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

- (NSURL *)url {
    return [NSURL URLWithString:_newsDictionary[@"link"]];
}

- (NSDate *)date {
    NSString *pubDate = _newsDictionary[@"pubDate"];
    
    NSDateFormatter *df = [NSDateFormatter new];
    //    pubDate = "Sat, 22 Mar 2014 12:59:07 GMT";
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss ZZZ";
    //NSLog(@"'%@' - '%@'", pubDate, [df dateFromString:pubDate]);
    return [df dateFromString:pubDate];
}

@end
