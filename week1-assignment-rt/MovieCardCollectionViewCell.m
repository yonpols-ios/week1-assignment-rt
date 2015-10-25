//
//  MovieCardCollectionViewCell.m
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/24/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "MovieCardCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCardCollectionViewCell

- (void) loadMovieFromData:(NSDictionary *)movieData {
    self.titleLabel.text = movieData[@"title"];
    
    NSString *originalUrlString = movieData[@"posters"][@"detailed"];
    NSRange range = [originalUrlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *newUrlString = [originalUrlString stringByReplacingCharactersInRange:range
                                                                        withString:@"https://content6.flixster.com/"];
    NSURL *imageuURL = [NSURL URLWithString:newUrlString];
    [self.posterImage setImageWithURL:imageuURL];
}

@end
