//
//  Movie.h
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/5/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * year;
@property (strong, nonatomic) NSString * imbdID;
@property (strong, nonatomic) NSURL * posterURL;

@property (strong, nonatomic) NSString * director;
@property (strong, nonatomic) NSString * writer;
@property (strong, nonatomic) NSString * starring;

@property (strong, nonatomic) NSString * imdbRating;
@property (strong, nonatomic) NSString * metascore;

@property (strong, nonatomic) NSString * shortPlot;
@property (strong, nonatomic) NSString * fullPlot;


@property BOOL * favorite;

-(instancetype) initWithSearchDictionary:(NSDictionary *)movieDictionary;

@end
