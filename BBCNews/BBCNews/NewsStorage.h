//
//  NewsStorage.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsStorage : NSObject {
    BOOL _isLoading;
}

+ (BOOL)isLoading;
+ (NSString *)newsFilePath;
+ (NSString *)channelName;
+ (void)refreshNews;
+ (NSArray *)news;

@end
