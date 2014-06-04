//
//  EXTNewGameViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 30/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTNewGameViewController.h"
#import "EXTResultGameViewController.h"

@interface EXTNewGameViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
- (IBAction)doStart:(id)sender;
- (IBAction)doEnd:(id)sender;

@property FXFormController *formController;

@end

@implementation EXTNewGameViewController

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
    
    if(currentGame.is_over.boolValue) {
        [self.startButton setBackgroundImage:[UIImage imageNamed:@"btn-back2px-orange"] forState:UIControlStateNormal];
        [self.startButton setTitle:@"Afficher les résultats" forState:UIControlStateNormal];
        [self.endButton setHidden:YES];
    } else {
        if([currentGame.thePlayerGames count] == 0) {
            [self.startButton setHidden:YES];
            [self.endButton setHidden:YES];
        } else {
            [self.startButton setHidden:NO];
            [self.startButton setBackgroundImage:[UIImage imageNamed:@"btn-back2px-green"] forState:UIControlStateNormal];
            [self.startButton setTitle:(currentGame.is_started.boolValue ? @"Continuer la partie" : @"Lancer la partie") forState:UIControlStateNormal];
            if(currentGame.is_started.boolValue) {
                [self.endButton setHidden:NO];
                [self.endButton setTitle:@"Terminer la partie" forState:UIControlStateNormal];
            } else {
                [self.endButton setHidden:YES];
            }
        }
    }
    self.formController.form = currentGame;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {return YES;}

-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showResult"] ){
        EXTResultGameViewController *vc = (EXTResultGameViewController *)[segue destinationViewController];
        vc.game = currentGame;
    }
}

- (IBAction)doStart:(id)sender {
    if(currentGame.is_over.boolValue) {
        [self performSegueWithIdentifier:@"showResult" sender: self];
    } else {
        [currentGame findOrCreateHolesForPlayers];
        [currentGame setIsStarted:YES];
        [self performSegueWithIdentifier:@"startGame2" sender: self];
    }
}

- (IBAction)doEnd:(id)sender {
    [currentGame setIsOver:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)choosePlayers:(UITableViewCell<FXFormFieldCell> *)cell {
    [self performSegueWithIdentifier: @"choosePlayers" sender: self];
}

- (void)doNothing:(UITableViewCell<FXFormFieldCell> *)cell
{
    
}

@end
