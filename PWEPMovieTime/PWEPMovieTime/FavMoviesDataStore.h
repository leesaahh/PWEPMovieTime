//
//  FavMoviesDataStore.h
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/20/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import <CoreData/CoreData.h>

@interface FavMoviesDataStore : NSObject

+(FavMoviesDataStore *)sharedDataStore;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


//@property (strong, nonatomic) NSMutableArray *mFavMovies;

- (void)saveContext;

@end
