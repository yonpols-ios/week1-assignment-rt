//
//  MovieCardCollectionViewCell.h
//  week1-assignment-rt
//
//  Created by Juan Pablo Marzetti on 10/24/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *mpaaRatingLabel;

@property (weak, nonatomic) IBOutlet UIImageView *criticsRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *criticsRatingText;

@property (weak, nonatomic) IBOutlet UIImageView *audienceRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *audienceRatingText;

- (void) loadMovieFromData:(NSDictionary *)movieData;
@end
