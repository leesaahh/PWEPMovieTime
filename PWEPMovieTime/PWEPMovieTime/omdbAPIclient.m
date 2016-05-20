//
//  omdAPIclient.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/5/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "omdbAPIclient.h"
#import "MovieCollectionViewController.h"
#import "Movie.h"

NSString * const OMDB_URL = @"http://www.omdbapi.com/?";


@implementation omdbAPIclient

// http://www.omdbapi.com/?s=Batman&page=2

+(void)getMoviesforSearch:(NSString *)search withCompletion:(void (^)(NSArray *movies, NSString *errorMsg))completionBlock {

    NSString *urlString = [NSString stringWithFormat:@"%@s=%@&page=1", OMDB_URL, search];

    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"Creating task for search: %@", search);
        
        if(error) {
            
            NSLog(@"Error: %@", error.description);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode != 200) {
            
            NSLog(@"Something went wrong calling OMDb! Status code %lu", httpResponse.statusCode);
        }
        
        NSDictionary *searchResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"response dictionary:%@",searchResponse);
        
        NSMutableString *errorMsg = [NSMutableString new];
        
        if (searchResponse[@"Error"]) {
            errorMsg = searchResponse[@"Error"];
        }
        
        NSArray *movieDictionaries = searchResponse[@"Search"];
        
        //create mutable array
        NSMutableArray *mMovies = [NSMutableArray new];
        
        
        for (NSDictionary *movie in movieDictionaries) {
            if ([movie[@"Type"] isEqualToString:@"movie"]) {
            // create movie objects
            Movie * currentMovie = [[Movie alloc] initWithDictionary:movie];
            // add to local mutable array
            mMovies = (NSMutableArray *) [mMovies arrayByAddingObject:currentMovie];
            }
        }
        
        for (Movie *movie in mMovies) {
            NSLog(@"Created Movie: %@", movie.title);
            
        }
    
        // pass back mutable array in completion block
        completionBlock(mMovies,errorMsg);
        
    }];

    [task resume];
}

+(void)getMoviesforIMDbID:(NSString *)IMDbID withCompletion:(void (^)(Movie *movie))completionBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"%@i=%@", OMDB_URL, IMDbID];
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"Creating task for imdbID: %@", IMDbID);
        
        if(error) {
            
            NSLog(@"Error: %@", error.description);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode != 200) {
            
            NSLog(@"Something went wrong calling OMDb! Status code %lu", httpResponse.statusCode);
        }
        
        NSDictionary *searchResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"response dictionary:%@",searchResponse);
        
        Movie * currentMovie = [[Movie alloc] initWithDictionary:searchResponse];
        
        completionBlock(currentMovie);
        
    }];
    
    [task resume];
}

@end
