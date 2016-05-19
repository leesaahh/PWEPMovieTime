//
//  MovieDetailsViewController.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/3/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "Movie.h"
#import "omdbAPIclient.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UITextView *plotTextView;

@property (weak, nonatomic) IBOutlet UILabel *releasedLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *starringLabel;

@property (weak, nonatomic) IBOutlet UILabel *IMDbRatingLabel
;
@property (weak, nonatomic) IBOutlet UILabel *metascoreLabel;



@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [omdbAPIclient getMoviesforIMDbID:self.IMDbID withCompletion:^(Movie *movie) {

        NSLog(@"Details for: %@", movie.title);
        self.navigationItem.title = movie.title;
        
        [self setMoviePosterWithURL: movie.posterURL];
        //self.plotTextView.text = movie.shortPlot;
        
        self.releasedLabel.text = [NSString stringWithFormat:@"RELEASED: %@", movie.year];
        self.directorLabel.text = [NSString stringWithFormat:@"DIRECTOR: %@", movie.director];
        self.writerLabel.text = [NSString stringWithFormat:@"WRITER: %@", movie.writer];
        self.starringLabel.text = [NSString stringWithFormat:@"STARRING: %@", movie.starring];
        
        self.IMDbRatingLabel.text = [NSString stringWithFormat:@"IMDb Rating: %@", movie.imdbRating];
        self.metascoreLabel.text = [NSString stringWithFormat:@"Metascore: %@", movie.metascore];
        

        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.view reloadInputViews];
        }];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMoviePosterWithURL:(NSURL *)posterURL {
    
    NSString *posterUrlString = [NSString stringWithFormat:@"%@", posterURL];
    
    if ([posterUrlString isEqualToString:@"N/A"]) {
        
        self.posterImage.image = [UIImage imageNamed:@"sadPopcorn"];
        
    }
    else {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperationWithBlock:^{
            // you are now on background thread
            // write statements to get the image
            
            NSData *posterData = [NSData dataWithContentsOfURL: posterURL];
            
            UIImage *posterImage = [UIImage imageWithData:posterData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                // you are now on the main thread
                self.posterImage.image = posterImage;
                
            }];
        }];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
