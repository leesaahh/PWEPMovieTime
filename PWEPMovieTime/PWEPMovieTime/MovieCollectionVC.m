//
//  MovieCollectionVC.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 4/29/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "MovieCollectionVC.h"
#import "MoviePosterCollectionViewCell.h"

@interface MovieCollectionVC () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>



@end

@implementation MovieCollectionVC

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
    self.searchBarText = searchText;
    NSLog(@"you searched: %@", self.searchBarText);
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

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.posterImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.posterImage.clipsToBounds = YES;
    cell.posterImage.image = [UIImage imageNamed:@"cuteMovie.jpg"];
    
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
