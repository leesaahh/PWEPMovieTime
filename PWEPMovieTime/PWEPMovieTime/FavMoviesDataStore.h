//
//  FavMoviesDataStore.h
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/20/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface FavMoviesDataStore : NSObject

+(FavMoviesDataStore *)sharedDataStore;

@property (strong, nonatomic) NSMutableArray *mFavMovies;

@end
