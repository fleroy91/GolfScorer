//
//  EXTGameViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 29/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTGameViewController.h"
#import "EXTPlayersViewController.h"

@interface EXTGameViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FXFormController *formController;

@end

@implementation EXTGameViewController

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
    self.formController.form = currentGame;
    [self.tableView reloadData];
    /*
    [self.dateLabel setText:[currentGame.when description]];
    [self.kindLabel setText:currentGame.kind];
    [self.nbPlayersLabel setText:[NSString stringWithFormat:@"%d", [currentGame.thePlayerGames count]]];
    assert(currentGame);
    self.endGameButton.hidden = ! currentGame.is_started;
    if(currentGame.is_started) {
        [self.startGameButton setTitle: @"Continuer la partie" forState:UIControlStateNormal];
    } else {
        [self.startGameButton setTitle: @"Démarrer la partie" forState:UIControlStateNormal];
    }
     */
}

- (IBAction)endGame:(id)sender
{
    [currentGame setIsOver:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"startGame"] ){
        [currentGame findOrCreateHolesForPlayers];
    }
}
- (void)choosePlayers:(UITableViewCell<FXFormFieldCell> *)cell {
    [self performSegueWithIdentifier: @"choosePlayers" sender: self];
}

- (void)doNothing:(UITableViewCell<FXFormFieldCell> *)cell
{
    
}

@end
