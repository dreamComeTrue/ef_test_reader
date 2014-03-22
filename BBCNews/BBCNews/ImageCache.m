//
//  ImageCache.m
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import "ImageCache.h"

@implementation ImageCache

+ (NSString *)imagesFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"images.xml"];
}

+ (NSString *)imagePath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fileName];
}

ImageCache *imagesInstance = nil;

+ (instancetype)instance {
    if (!imagesInstance) {
        imagesInstance = [ImageCache new];
    }
    return imagesInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _images = [NSMutableArray arrayWithContentsOfFile:[ImageCache imagesFilePath]];
        if (!_images) {
            _images = [NSMutableArray new];
            [_images writeToFile:[ImageCache imagesFilePath] atomically:YES];
        }
    }
    return self;
}

+ (UIImage *)imageWithUrl:(NSString *)url {
    for (NSDictionary *imgDict in [ImageCache instance]->_images) {
        if ([url isEqual:imgDict[@"url"]]) {
            NSData *imgData = [NSData dataWithContentsOfFile:[ImageCache imagePath:imgDict[@"fileName"]]];
            UIImage *img = [UIImage imageWithData:imgData];
            if (!img)
                break;
            return img;
        }
    }
    
    NSMutableDictionary *imgDict = [NSMutableDictionary new];
    imgDict[@"url"] = url;
    imgDict[@"fileName"] = [[NSUUID UUID] UUIDString];
    [[ImageCache instance]->_images addObject:imgDict];
    [[ImageCache instance]->_images writeToFile:[ImageCache imagesFilePath] atomically:YES];

    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    [imgData writeToFile:[ImageCache imagePath:imgDict[@"fileName"]] atomically:YES];
    UIImage *img = [UIImage imageWithData:imgData];
    return img;
}

@end
