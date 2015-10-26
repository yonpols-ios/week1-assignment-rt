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
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = 1;
    
    self.titleLabel.text = movieData[@"title"];
    self.mpaaRatingLabel.text = [NSString stringWithFormat:@" %@ ", movieData[@"mpaa_rating"]];
    self.mpaaRatingLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.mpaaRatingLabel.layer.borderWidth = 1;
    [self.mpaaRatingLabel sizeToFit];
    
    NSURL *imageURL = [NSURL URLWithString:movieData[@"posters"][@"detailed"]];
    
    self.criticsRatingText.text = [NSString stringWithFormat:@"%@%%", movieData[@"ratings"][@"critics_score"]];
    self.audienceRatingText.text = [NSString stringWithFormat:@"%@%%", movieData[@"ratings"][@"audience_score"]];
    
    if ([movieData[@"ratings"][@"audience_rating"]  isEqual: @"Upright"]) {
        self.audienceRatingImage.image = [UIImage imageNamed: @"popcorn.png"];
    } else {
        self.audienceRatingImage.image = [UIImage imageNamed: @"badpopcorn.png"];
    }
    
    if ([movieData[@"ratings"][@"critics_rating"]  isEqual: @"Certified Fresh"]) {
        self.criticsRatingImage.image = [UIImage imageNamed: @"certified.png"];
    } else if ([movieData[@"ratings"][@"critics_rating"]  isEqual: @"Fresh"]) {
            self.criticsRatingImage.image = [UIImage imageNamed: @"fresh.png"];
    } else {
        self.criticsRatingImage.image = [UIImage imageNamed: @"rotten.png"];
    }
    

    self.posterImage.image = nil;
    [self.posterImage setFadeInImageWithURL:imageURL];
}

@end
