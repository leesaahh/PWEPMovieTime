//
//  MovieCollectionViewController.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 4/29/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "MoviePosterCollectionViewCell.h"
#import "omdbAPIclient.h"
#import "Movie.h"

@interface MovieCollectionViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *mMovies;

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"posterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init & add search bar in navbar
    UISearchBar *search = [[UISearchBar alloc] initWithFrame: CGRectMake(5 ,5, 300,45)];
    search.delegate = self;
    search.showsBookmarkButton = YES;
    search.placeholder = @"Search for a Movie Title";
    
    self.navigationItem.titleView = search;
    

    
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
- (IBAction)seeMoreTapped:(id)sender {
    NSLog(@"See More button tapped");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSMutableString *searchTextNoWhitespaces = (NSMutableString *)[searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    self.searchBarText = searchTextNoWhitespaces;
    NSLog(@"you searched: %@", self.searchBarText);
    
    [omdbAPIclient getMoviesforSearch:self.searchBarText withCompletion:^(NSArray *movies) {
        
        // pass value of movies to local mutable array
        self.mMovies = (NSMutableArray *) movies;
        
        for (Movie *movie in self.mMovies) {
            NSLog(@"Movie->CollectionView: %@", movie.title);
        }
        
        // jump on main thread to reload data of collection view
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        // you are now on background thread
        // write statements to get the image
        
        NSData *posterData = [NSData dataWithContentsOfURL: movie.posterURL];
      
        UIImage *posterImage = [UIImage imageWithData:posterData];
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            // you are now on the main thread
            cell.posterImage.image = posterImage;
            
        }];
    }];
    
    //cell.posterImage.image = [UIImage imageNamed:@"cuteMovie.jpg"];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
        
        if (kind == UICollectionElementKindSectionFooter) {
            
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"seeMoreFooter" forIndexPath:indexPath];
            
        }
    
    return reusableView;
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
