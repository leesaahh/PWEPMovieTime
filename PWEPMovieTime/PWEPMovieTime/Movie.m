//
//  Movie.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/5/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype) initWithDictionary:(NSDictionary *)movieDictionary{
    
    self = [super init];
    
    if (self) {
        
        [self parseOMDbDictionary:movieDictionary];
        
    }
    
    return self;
    
}

-(void)parseOMDbDictionary: (NSDictionary *) movieDictionary {
    
    _title = movieDictionary[@"Title"];
    _year = movieDictionary[@"Year"];
    _imbdID = movieDictionary[@"imdbID"];
    _posterURL = [NSURL URLWithString: movieDictionary[@"Poster"]];
    
    _director = movieDictionary[@"Director"];
    _writer = movieDictionary[@"Writer"];
    _starring = movieDictionary[@"Actors"];
    
    _imdbRating = movieDictionary[@"imdbRating"];
    _metascore = movieDictionary[@"Metascore"];
    
    _shortPlot = movieDictionary[@"Plot"];
    _fullPlot = movieDictionary[@"Plot"];
    
}


@end
