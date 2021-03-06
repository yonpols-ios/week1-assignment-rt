//
//  UIImageView+FadeImage.m
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/25/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "UIImageView+FadeImage.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView(FadeImage)

- (void) setFadeInImageWithURL:(NSURL *)url {
    [self setFadeInImageWithURL:url placeholderImage:nil];
}

- (void) setFadeInImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:1000];
    
    if (self.image == nil && placeholderImage == nil) {
        self.alpha = 0.0;
    }

    __weak UIImageView *imageView = self;
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        imageView.image = image;
        if (response == nil) {
            imageView.alpha = 1;
        } else {
            [UIView animateWithDuration:0.5 animations:^{ imageView.alpha = 1; }];
        }
    } failure:nil];
}

@end
