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

NewsStorage *instance = nil;

+ (instancetype)instance {
    if (!instance) {
        instance = [NewsStorage new];
    }
    return instance;
}

+ (BOOL)isLoading {
    return [NewsStorage instance]->_isLoading;
}

+ (NSString *)newsFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"news.xml"];
}

+ (NSString *)channelName {
    NSDictionary *data = [NSDictionary dictionaryWithXMLFile:[self newsFilePath]];
    NSString *name = data[@"channel"][@"title"];
    return name;
}

+ (NSArray *)news {
    NSDictionary *data = [NSDictionary dictionaryWithXMLFile:[self newsFilePath]];
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

+ (void)refreshNews {
    void (^loadNews)() = ^(){
        [NewsStorage instance]->_isLoading = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        });
        NSURL *url = [NSURL URLWithString:NEWS_URL];
        NSError *error = nil;
        NSString *newsString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            [newsString writeToFile:[self newsFilePath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (!error) {
                //NSLog(@"news:\n%@", newsString);
                [[NSNotificationCenter defaultCenter] postNotificationName:strNoteNewsDidLoad object:nil userInfo:nil];
            }
        }
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loading error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [alert show];
            });
            [[NSNotificationCenter defaultCenter] postNotificationName:strNoteNewsDidLoadFailed object:nil userInfo:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        [NewsStorage instance]->_isLoading = NO;
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), loadNews);
}

@end
