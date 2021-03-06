//
//  MoviePosterCollectionViewCell.h
//  PWEPMovieTime
//
//  Created by Lisa Lee on 4/29/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MoviePosterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@end
