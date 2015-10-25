//
//  MovieDetailViewController.m
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/25/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (strong, nonatomic) NSDictionary *movieData;
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

- (void) loadMovieData:(NSDictionary *)movieData {
    self.movieData = movieData;
    
}

- (void) renderMovieData {
    self.titleLabel.text = self.movieData[@"title"];
    self.synopsisLabel.text = self.movieData[@"synopsis"];
    self.titleLabel.text = self.movieData[@"title"];
    [self.synopsisLabel sizeToFit];
    
    NSInteger contentWidth = self.movieInfoScroll.bounds.size.width;
    NSInteger contentHeight = self.synopsisLabel.frame.origin.y + self.synopsisLabel.bounds.size.height + 20;
    
    self.movieInfoScroll.contentSize = CGSizeMake(contentWidth, contentHeight);
}

@end
