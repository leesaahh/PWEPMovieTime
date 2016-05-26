//
//  FavMoviesDataStore.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/20/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "FavMoviesDataStore.h"

@implementation FavMoviesDataStore

+(FavMoviesDataStore *)sharedDataStore {
    
    static FavMoviesDataStore *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FavMoviesDataStore alloc]init];
    });
    
    return instance;
}

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.mFavMovies = [[NSMutableArray alloc]init];
    }
    
    return self;
}

@end
