//
//  MoviesCollectionViewController.m
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/24/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "MoviesCollectionViewController.h"
#import "MovieCardCollectionViewCell.h"
#import "MovieDetailViewController.h"

#import "SpotifyProgressHUD.h"

@interface MoviesCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollection;
@property (weak, nonatomic) IBOutlet UISearchBar *movieSearchBar;

@property (strong, nonatomic) SpotifyProgressHUD *progressHUD;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;

@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSArray *filteredMovies;

@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moviesCollection.delegate = self;
    self.moviesCollection.dataSource = self;
    self.movieSearchBar.delegate = self;

    self.progressHUD = [[SpotifyProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 150, 150) withPointDiameter:12 withInterval:0.15];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefreshPull) forControlEvents:UIControlEventValueChanged];
    [self.moviesCollection insertSubview:self.refreshControl atIndex:0];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    MovieCardCollectionViewCell *cell = [self.moviesCollection dequeueReusableCellWithReuseIdentifier:@"movieCard" forIndexPath:indexPath];

    [cell loadMovieFromData:self.filteredMovies[indexPath.row]];
    
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.filteredMovies = self.movies;
    [self.moviesCollection reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search: %@", searchText);
    
    if (searchText.length == 0) {
        self.filteredMovies = self.movies;
    } else {
        self.filteredMovies = [self.movies objectsAtIndexes:[self.movies indexesOfObjectsPassingTest:^BOOL(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            NSRange range = [obj[@"title"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }]];
    }
    
    [self.moviesCollection reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCardCollectionViewCell *cell = sender;
    MovieDetailViewController *movieDetailsViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.moviesCollection indexPathForCell:cell];
    NSDictionary *movieData = self.filteredMovies[indexPath.row];
    [movieDetailsViewController loadMovieData:movieData];
}

- (void) onRefreshPull {
    [self loadData:NO withBlock:^(NSError * _Nullable error) { [self.refreshControl endRefreshing]; }] ;
}


- (void) loadData:(BOOL)showProgress withBlock:(void (^)(NSError * _Nullable error))block  {
    NSString *urlString = @"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    self.movies = responseDictionary[@"movies"];
                                                    self.filteredMovies = self.movies;
                                                    [self.moviesCollection reloadData];
                                                } else {
                                                    self.networkErrorView.hidden = NO;
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                                
                                                [self.progressHUD removeFromSuperview];
                                                block(error);
                                            }];
    
    if (showProgress) {
        self.progressHUD.center = self.view.center;
        [self.view addSubview:self.progressHUD];
    }
    
    [task resume];
}

-(void) loadData {
    [self loadData:YES withBlock:^(NSError * _Nullable error) {}];
}

@end
