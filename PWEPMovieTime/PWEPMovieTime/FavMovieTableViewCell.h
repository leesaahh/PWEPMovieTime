
//
//  FavMovieTableViewCell.h
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/20/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavMovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *starringLabel;

@end
