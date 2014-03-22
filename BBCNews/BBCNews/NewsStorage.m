//
//  NewsStorage.m
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import "NewsStorage.h"
#import "AppDelegate.h"
#import "XMLDictionary.h"
#import "NewsItem.h"

@implementation NewsStorage

+ (NSArray *)news {
    NSDictionary *data = [NSDictionary dictionaryWithXMLFile:[AppDelegate newsFilePath]];
    //NSLog(@"data: %@", data);
    
    NSArray *rawData = data[@"channel"][@"item"];
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        rawData = @[rawData];
    }
    if (![rawData isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *newsArray = [NSMutableArray arrayWithCapacity:rawData.count];
    for (NSDictionary *rawItem in rawData) {
        NewsItem *item = [[NewsItem alloc] initWithDictionary:rawItem];
        [newsArray addObject:item];
    }
    [newsArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NewsItem *n1 = (NewsItem *)obj1;
        NewsItem *n2 = (NewsItem *)obj2;
        
        return [n1.date compare:n2.date];

    }];
    return newsArray;
}

@end
