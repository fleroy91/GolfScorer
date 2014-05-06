//
//  EXTHomeViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTHomeViewController.h"
#import "EXTAppDelegate.h"
#import "EXTOldGamesTableViewController.h"
#import "EXTGameViewController.h"
#import "EXTGlobal.h"

@interface EXTHomeViewController ()
@end

@implementation EXTHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)documentIsReady
{
    NSLog(@"Loaded !");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Loading !");
    NSLog(@"We need to display a spinner !");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigations

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"OldGames"] ){
    } else if ([segue.identifier isEqualToString:@"NewGame"]) {
        currentGame = [Game create];
    } else if ([segue.identifier isEqualToString:@"EditGame"]) {
        
    }
}
@end
