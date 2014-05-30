//
//  EXTSettingsViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 26/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTSettingsViewController.h"

@interface EXTSettingsViewController ()

@property FXFormController *formController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)doContact:(id)sender;

@end

@implementation EXTSettingsViewController

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
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.tableView;
    self.formController.delegate = self;
    self.formController.form = currentGame;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.formController.form = settings;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)prefersStatusBarHidden {return YES;}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doContact:(id)sender {
    
    NSURL *_mailURL = [NSURL URLWithString:@"mailto:golfscorer@mobagile.fr?subject=Message%20pour%20Golf%20Scorer"];
    [[UIApplication sharedApplication] openURL:_mailURL];
}
@end
