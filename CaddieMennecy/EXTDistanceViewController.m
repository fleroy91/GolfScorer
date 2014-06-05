//
//  EXTDistanceViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 04/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTDistanceViewController.h"
#import "EXTDistanceView.h"

@interface EXTDistanceViewController () <UIScrollViewDelegate>
@property (nonatomic)  NSArray *distColors;
@property (strong, nonatomic) EXTDistanceView *distView;

@end

@implementation EXTDistanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _distColors = @[[UIColor blackColor], [UIColor whiteColor], [UIColor yellowColor], [UIColor blueColor], [UIColor redColor]];

    self.distView = [[EXTDistanceView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.distView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
