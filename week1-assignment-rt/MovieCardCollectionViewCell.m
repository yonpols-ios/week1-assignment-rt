//
//  MovieCardCollectionViewCell.m
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/24/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "MovieCardCollectionViewCell.h"
#import "UIImageView+FadeImage.h"

@implementation MovieCardCollectionViewCell

- (void) loadMovieFromData:(NSDictionary *)movieData {
    self.titleLabel.text = movieData[@"title"];
    NSURL *imageURL = [NSURL URLWithString:movieData[@"posters"][@"detailed"]];
    self.posterImage.image = nil;
    [self.posterImage setFadeInImageWithURL:imageURL];
}

@end
