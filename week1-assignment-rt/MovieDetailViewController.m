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
    self.titleLabel.text = self.movieData[@"title"];
    self.synopsisLabel.text = self.movieData[@"synopsis"];
    self.titleLabel.text = self.movieData[@"title"];
    [self.synopsisLabel sizeToFit];
    
    NSInteger contentWidth = self.movieInfoScroll.bounds.size.width;
    NSInteger contentHeight = self.synopsisLabel.frame.origin.y + self.synopsisLabel.bounds.size.height + 20;
    
    //Get hi res image url
    NSString *originalUrlString = self.movieData[@"posters"][@"detailed"];
    NSRange range = [originalUrlString rangeOfString:@".*cloudfront.net/"
                                             options:NSRegularExpressionSearch];
    NSString *newUrlString = [originalUrlString stringByReplacingCharactersInRange:range
                                                                        withString:@"https://content6.flixster.com/"];
    NSURL *url = [NSURL URLWithString:newUrlString];
    
    [self.posterImage setFadeInImageWithURL:url placeholderImage:self.lowResImage];
    self.movieInfoScroll.contentSize = CGSizeMake(contentWidth, contentHeight);
}

@end
