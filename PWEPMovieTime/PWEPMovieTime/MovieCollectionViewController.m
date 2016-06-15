//
//  MovieCollectionViewController.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 4/29/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "MoviePosterCollectionViewCell.h"
#import "MovieDetailsViewController.h"
#import "HeaderCollectionReusableView.h"
#import "omdbAPIclient.h"
#import "Movie.h"

@interface MovieCollectionViewController () <UISearchBarDelegate, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *mMovies;
@property (strong, nonatomic) NSMutableArray *mFavorites;

@property (strong, nonatomic) NSMutableString *mErrorMsg;
@property (strong, nonatomic) NSString *mIMDbID;

@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger totalPages;

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"posterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init & add search bar in navbar
    UISearchBar *search = [[UISearchBar alloc] initWithFrame: CGRectMake(5 ,5, 300,45)];
    search.delegate = self;
    search.showsBookmarkButton = YES;
    search.placeholder = @"Type here to start searching";
    
    self.navigationItem.titleView = search;
    
    self.currentPage = 1;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes <EVIL?>
  // [self.collectionView registerClass:[MoviePosterCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    self.currentPage = 1;
    
    NSMutableString *searchTextNoWhitespaces = (NSMutableString *)[searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    self.searchBarText = searchTextNoWhitespaces;
    NSLog(@"searching: %@", self.searchBarText);
    
    [omdbAPIclient getMoviesforSearch:self.searchBarText forPage:self.currentPage withCompletion:^(NSArray *movies, NSString *errorMsg, NSInteger totalResults) {
        
        // pass value of movies to local mutable array
        self.mMovies = (NSMutableArray *) movies;
        
        // pass error msg of search to header label
        self.mErrorMsg = (NSMutableString *) errorMsg;
        NSLog(@"error message: %@", errorMsg);
        
        self.totalPages = (totalResults+9)/10;
        // totalPages = ceil(totalResults/10) = (totalResults+10-1)/10
        
        // jump on main thread to reload data of collection view
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
        
    }];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieDetailsViewController *detailsVC = segue.destinationViewController;
    
    detailsVC.IMDbID = self.mIMDbID;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Movie *movie = self.mMovies[indexPath.item];
    
    self.mIMDbID = movie.imbdID;
    
    [self performSegueWithIdentifier:@"fromCollectionSegue" sender:self];
    
    NSLog(@"you selected: %@", movie.title);
    
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.mMovies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    Movie *movie = self.mMovies[indexPath.item];
    
    NSString *posterUrlString = [NSString stringWithFormat:@"%@",movie.posterURL];
    
    if ([posterUrlString isEqualToString:@"N/A"]) {
        
        cell.posterImage.image = [UIImage imageNamed:@"sadPopcorn"];
        
        cell.movieTitleLabel.alpha = 1;
        
        cell.movieTitleLabel.text = [NSString stringWithFormat:@"%@ - %@",movie.title, movie.year];
        
        
    }
    else {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperationWithBlock:^{
        // you are now on background thread
        // write statements to get the image
        
            NSData *posterData = [NSData dataWithContentsOfURL: movie.posterURL];
      
            UIImage *posterImage = [UIImage imageWithData:posterData];
        
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            // you are now on the main thread
                cell.movieTitleLabel.alpha = 0;
                cell.posterImage.image = posterImage;
            
        }];
    }];
    
    }
    
    return cell;
}

#pragma mark - Footer/Header

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    HeaderCollectionReusableView *headerView = nil;
        
        if (kind == UICollectionElementKindSectionFooter) {
            
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"seeMoreFooter" forIndexPath:indexPath];
            
            // if currentPage < totalPages, show footer, currentPage++
            // if currentPage = totalPages, hide footer
            
            // weird, was playing around, not sure why this works...but it does...
            if (self.currentPage < self.totalPages) {
                reusableView.alpha = 1;
                
            }else if (self.currentPage  >= self.totalPages)
            {
                reusableView.alpha = 0;
            }
            
        }
    
    if (kind == UICollectionElementKindSectionHeader) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"startHeader" forIndexPath:indexPath];
        
        headerView.headerLabel.text = self.mErrorMsg;
        
        if ([self.mErrorMsg isEqualToString:@""]) {
            headerView.headerLabel.text = @"Here are your movie results:";
        }
        
        return headerView;
    }
    
    return reusableView;
}

- (IBAction)seeMoreTapped:(id)sender {
    NSLog(@"See More button tapped");
    
    self.currentPage++;
    NSLog(@"current Page: %li", self.currentPage);
    
    [omdbAPIclient getMoviesforSearch:self.searchBarText forPage:self.currentPage withCompletion:^(NSArray *movies, NSString *errorMsg, NSInteger totalResults) {
        
        NSLog(@"next page movie array count: %li", movies.count);
        
        self.mMovies = (NSMutableArray *)[self.mMovies arrayByAddingObjectsFromArray:movies];
        
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:0];
        
        NSLog(@"mMovies count: %li",self.mMovies.count);
        
        
        // if currentPage < totalPages, show footer, currentPage++
        // if currentPage = totalPages, hide footer

        NSLog(@"total pages: %li, current page: %li", self.totalPages, self.currentPage);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self.collectionView reloadSections: section];
            [self.collectionView reloadData];
            [self.collectionView reloadInputViews];
        
        }];
        
    }];
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
