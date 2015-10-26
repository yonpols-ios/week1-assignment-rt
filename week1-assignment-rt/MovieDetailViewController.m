//
//  MovieDetailViewController.m
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/25/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+FadeImage.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (strong, nonatomic) NSDictionary *movieData;
@property (strong, nonatomic) UIImage *lowResImage;
@property (weak, nonatomic) IBOutlet UIScrollView *movieInfoScroll;
@property (weak, nonatomic) IBOutlet UILabel *mpaaRatingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *criticsRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *criticsRatingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *audienceRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *audienceRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderMovieData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadMovieData:(NSDictionary *)movieData withLowResImage:(UIImage *)lowResImage {
    self.movieData = movieData;
    self.lowResImage = lowResImage;
}

- (void) renderMovieData {
    self.title =self.movieData[@"title"];
    self.titleLabel.text = self.movieData[@"title"];

    self.synopsisLabel.text = self.movieData[@"synopsis"];
    [self.synopsisLabel sizeToFit];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%ld min", [self.movieData[@"runtime"] integerValue]];

    self.mpaaRatingLabel.text = [NSString stringWithFormat:@" %@ ", self.movieData[@"mpaa_rating"]];
    self.mpaaRatingLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mpaaRatingLabel.layer.borderWidth = 1;
    
    self.criticsRatingLabel.text = [NSString stringWithFormat:@"%@%%", self.movieData[@"ratings"][@"critics_score"]];
    self.audienceRatingLabel.text = [NSString stringWithFormat:@"%@%%", self.movieData[@"ratings"][@"audience_score"]];
    
    if ([self.movieData[@"ratings"][@"audience_rating"]  isEqual: @"Upright"]) {
        self.audienceRatingImage.image = [UIImage imageNamed: @"popcorn.png"];
    } else {
        self.audienceRatingImage.image = [UIImage imageNamed: @"badpopcorn.png"];
    }
    
    if ([self.movieData[@"ratings"][@"critics_rating"]  isEqual: @"Certified Fresh"]) {
        self.criticsRatingImage.image = [UIImage imageNamed: @"certified.png"];
    } else if ([self.movieData[@"ratings"][@"critics_rating"]  isEqual: @"Fresh"]) {
        self.criticsRatingImage.image = [UIImage imageNamed: @"fresh.png"];
    } else {
        self.criticsRatingImage.image = [UIImage imageNamed: @"rotten.png"];
    }
    
    //Get hi res image url
    NSString *originalUrlString = self.movieData[@"posters"][@"detailed"];
    NSRange range = [originalUrlString rangeOfString:@".*cloudfront.net/"
                                             options:NSRegularExpressionSearch];
    NSString *newUrlString = [originalUrlString stringByReplacingCharactersInRange:range
                                                                        withString:@"https://content6.flixster.com/"];
    NSURL *url = [NSURL URLWithString:newUrlString];
    
    [self.posterImage setFadeInImageWithURL:url placeholderImage:self.lowResImage];
    
    NSInteger contentWidth = self.movieInfoScroll.bounds.size.width;
    NSInteger contentHeight = self.synopsisLabel.frame.origin.y + self.synopsisLabel.bounds.size.height + 20;
    
    self.movieInfoScroll.contentSize = CGSizeMake(contentWidth, contentHeight);
}

@end
