//
//  omdbAPIclient.h
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/5/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieCollectionViewController.h"

@interface omdbAPIclient : NSObject

+(void)getMoviesforSearch:(NSString *)search withCompletion:(void (^)(NSArray *movies))completionBlock;

@end
