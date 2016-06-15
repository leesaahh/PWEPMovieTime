//
//  FavMovie+CoreDataProperties.h
//  PWEPMovieTime
//
//  Created by Flatiron School on 6/14/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FavMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavMovie (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *year;
@property (nullable, nonatomic, retain) NSString *imdbID;
@property (nullable, nonatomic, retain) NSString *director;
@property (nullable, nonatomic, retain) NSString *starring;
@property (nullable, nonatomic, retain) NSString *writer;
@property (nullable, nonatomic, retain) NSString *posterURL;

@end

NS_ASSUME_NONNULL_END
