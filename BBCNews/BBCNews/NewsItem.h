//
//  NewsItem.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject  {
    NSDictionary *_newsDictionary;
}

- (instancetype)initWithDictionary:(NSDictionary *)newsDictionary;

- (NSString *)title;
- (NSString *)shortDescription;
- (NSURL *)url;
- (NSDate *)date;
- (NSURL *)imageSmallUrl;
- (NSURL *)imageBigUrl;

@end