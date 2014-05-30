//
//  ViewController.m
//  xh_dotsWithLabel
//
//  Created by Xiaohe Hu on 5/30/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"
#import "xh_dotsLabel.h"
@interface ViewController ()
@property (nonatomic, strong)   xh_dotsLabel        *dotsLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self initDotsView];
}

-(void)initDotsView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSArray *totalData = [[NSArray alloc] initWithContentsOfFile:path];
    for (int i = 0; i < totalData.count; i++) {
        NSDictionary *dotsData = [totalData objectAtIndex:i];
        xh_dotsLabel *dotView = [[xh_dotsLabel alloc] init];
        [dotView setDict_viewData:dotsData];
        
        [self.view addSubview: dotView];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
