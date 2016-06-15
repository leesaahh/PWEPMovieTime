//
//  FullPlotViewController.m
//  PWEPMovieTime
//
//  Created by Lisa Lee on 5/20/16.
//  Copyright © 2016 Lisa Lee. All rights reserved.
//

#import "FullPlotViewController.h"
#import "omdbAPIclient.h"

@interface FullPlotViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fullPlotLabel;

@end

@implementation FullPlotViewController


-(void)viewWillAppear:(BOOL)animated {
    
    [omdbAPIclient getMoviesforIMDbIDFullPlot:self.IMDbID withCompletion:^(NSString *fullPlot) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.fullPlotLabel.text = fullPlot;
            
        }];
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
