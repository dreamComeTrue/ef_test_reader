//
//  ImageCache.h
//  BBCNews
//
//  Created by Pavel Yakimenko on 3/22/14.
//  Copyright (c) 2014 Pavel Yakimenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject {
    NSMutableArray *_images;
}

+ (UIImage *)imageWithUrl:(NSString *)url;

@end
