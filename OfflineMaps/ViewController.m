//
//  ViewController.m
//  OfflineMaps
//
//  Created by Jonathan Hillebrand on 18.04.17.
//  Copyright © 2017 Jaysquared. All rights reserved.
//

#import "ViewController.h"
@import Mapbox;


@interface ViewController ()
@property MGLMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *stylePath = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"json"];
    NSURL *styleUrl = [NSURL fileURLWithPath:stylePath];
    
    self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds styleURL:styleUrl];
    [self.view addSubview:self.mapView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
