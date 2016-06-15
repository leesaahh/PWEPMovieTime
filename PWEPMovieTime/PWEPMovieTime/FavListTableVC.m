//
//  FavListTableVC.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 4/29/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "FavListTableVC.h"
#import "Movie.h"
#import "FavMoviesDataStore.h"
#import "FavMovieTableViewCell.h"
#import "FavMovie.h"
#import "MovieDetailsViewController.h"
#import <CoreData/CoreData.h>

@interface FavListTableVC ()

@property (strong, nonatomic) NSMutableArray* favMovies;

@property (strong, nonatomic) NSString *mIMDbID;


@end

@implementation FavListTableVC

-(void)fetchAllFavMovies {
    
    NSFetchRequest *allFavMoviesRequest = [NSFetchRequest fetchRequestWithEntityName:@"FavMovie"];
    FavMoviesDataStore *datastore = [FavMoviesDataStore sharedDataStore];
    
    self.favMovies = (NSMutableArray *)[datastore.managedObjectContext executeFetchRequest:allFavMoviesRequest error:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self fetchAllFavMovies];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    NSLog(@"view did load");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [self fetchAllFavMovies];
    
    return self.favMovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FavMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    // Configure the cell...
    FavMovie *movie = self.favMovies[indexPath.row];
    NSLog(@"Row %li: %@", indexPath.row, movie.title);
    
    cell.titleYearLabel.text = [NSString stringWithFormat:@"%@ - %@", movie.title, movie.year];
    cell.directorLabel.text = [NSString stringWithFormat:@"Director: %@", movie.director];
    cell.writerLabel.text = [NSString stringWithFormat:@"Writers: %@",movie.writer];
    cell.starringLabel.text = [NSString stringWithFormat:@"Starring: %@",movie.starring];
    
    
    if ([movie.posterURL isEqualToString:@"N/A"]) {
        
        cell.posterImage.image = [UIImage imageNamed:@"sadPopcorn"];
        
    }
    else {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperationWithBlock:^{
            // you are now on background thread
            // write statements to get the image
            
            NSURL *posterURL = [NSURL URLWithString:movie.posterURL];
            
            NSData *posterData = [NSData dataWithContentsOfURL: posterURL];
            
            UIImage *posterImage = [UIImage imageWithData:posterData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                // you are now on the main thread
                cell.posterImage.image = posterImage;
                
            }];
        }];
        
    }

    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FavMoviesDataStore *datastore = [FavMoviesDataStore sharedDataStore];

    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the favMovie from the datastore
        [datastore.managedObjectContext deleteObject:[self.favMovies objectAtIndex:indexPath.row]];
        
        // handle error
        NSError *error = nil;
        if (![datastore.managedObjectContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove row from table view
    
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
//         [self.tableView reloadData];

    }
    
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MovieDetailsViewController *detailsVC = segue.destinationViewController;
    
    detailsVC.IMDbID = self.mIMDbID;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FavMovie *favMovie = self.favMovies[indexPath.item];
    
    self.mIMDbID = favMovie.imdbID;
    
    [self performSegueWithIdentifier:@"fromFavListSegue" sender:self];
    
    NSLog(@"you selected: %@", favMovie.title);
}

@end
