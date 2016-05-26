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

@interface FavListTableVC ()

@property (strong, nonatomic) NSMutableArray* favMovies;


@end

@implementation FavListTableVC

-(void)viewWillAppear:(BOOL)animated {
    
    FavMoviesDataStore *dataStore = [FavMoviesDataStore sharedDataStore];
    
    self.favMovies = dataStore.mFavMovies;
    
    NSLog(@"Your stored favorites:%@",self.favMovies);
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    return self.favMovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FavMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Movie *movie = self.favMovies[indexPath.row];
    NSLog(@"Row %li: %@", indexPath.row, movie.title);
    
    cell.titleYearLabel.text = [NSString stringWithFormat:@"%@ - %@", movie.title, movie.year];
    cell.directorLabel.text = [NSString stringWithFormat:@"Director: %@", movie.director];
    cell.writerLabel.text = [NSString stringWithFormat:@"Writers: %@",movie.writer];
    cell.starringLabel.text = [NSString stringWithFormat:@"Starring: %@",movie.starring];
    
    NSString *posterUrlString = [NSString stringWithFormat:@"%@",movie.posterURL];
    
    if ([posterUrlString isEqualToString:@"N/A"]) {
        
        cell.posterImage.image = [UIImage imageNamed:@"sadPopcorn"];
        
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
                cell.posterImage.image = posterImage;
                
            }];
        }];
        
    }

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
