//
//  Movie.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/5/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype) initWithSearchDictionary:(NSDictionary *)movieDictionary{
    
    self = [super init];
    
    if (self) {
        
        _title = movieDictionary[@"Title"];
        _year = movieDictionary[@"Year"];
        _imbdID = movieDictionary[@"imdbID"];
        _posterURL = movieDictionary[@"Poster"];
        
    }
    
    return self;
    
}

-(instancetype) initWithImdbIdDictionary: (NSDictionary *)imdbIdDictionary{
    self = [super init];
    
    if (self) {
       // statements
    }
    return self;
}


+(Movie *) movieFromDictionary: (NSDictionary *) movieDictionary {
    
    Movie *movie = [[Movie alloc] initWithSearchDictionary: movieDictionary];
    return movie;
}
@end
