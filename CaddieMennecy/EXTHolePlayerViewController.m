//
//  EXTHolePlayerViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 05/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTHolePlayerViewController.h"
#import "EXTDistanceView.h"

@interface EXTHolePlayerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hcpLabel;
@property (weak, nonatomic) IBOutlet UILabel *brutLabel;
@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UILabel *sParLabel;
@property (weak, nonatomic) IBOutlet UILabel *sBrutLabel;
@property (weak, nonatomic) IBOutlet UILabel *sNetLabel;
@property (nonatomic, strong) FXFormController *formController;
@property (weak, nonatomic) IBOutlet UITableView *formView;

@end

@implementation EXTHolePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)saveHole
{
    [self.playerGameHole saveScore];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.formView;
    self.formController.delegate = self;
    self.formController.form = nil;
}

- (NSString *)getTitle
{
    return self.playerGameHole.inPlayerGame.forPlayer.firstname;
}

- (BOOL)prefersStatusBarHidden {return YES;}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.brutLabel.text = [self.playerGameHole.inPlayerGame getBrutScore:NO];
    self.netLabel.text = [self.playerGameHole.inPlayerGame getNetScore:NO];
    self.sBrutLabel.text = [self.playerGameHole.inPlayerGame getBrutScore:YES];
    self.sNetLabel.text = [self.playerGameHole.inPlayerGame getNetScore:YES];
    self.hcpLabel.text = [NSString stringWithFormat:@"%@",self.playerGameHole.game_hcp];
    self.sParLabel.text = [NSString stringWithFormat:@"%d",self.playerGameHole.forHole.par.unsignedIntValue + self.playerGameHole.game_hcp.unsignedIntValue];
    self.formController.form = (id)self.playerGameHole;
    [self.formView reloadData];
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
