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
        _posterURL = [NSURL URLWithString: movieDictionary[@"Poster"]];
        
    }
    
    return self;
    
}

-(void)parseOMDbDictionary {
    
    
}


@end