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
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *nbPlayersLabel;

@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (weak, nonatomic) IBOutlet UIButton *endGameButton;
- (IBAction)endGame:(id)sender;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.dateLabel setText:[currentGame.when description]];
    [self.kindLabel setText:currentGame.kind];
    [self.nbPlayersLabel setText:[NSString stringWithFormat:@"%d", [currentGame.thePlayerGames count]]];
    assert(currentGame);
    self.endGameButton.hidden = ! currentGame.is_started;
    if(currentGame.is_started) {
        self.startGameButton.titleLabel.text = @"Continuer la partie";
    } else {
        self.startGameButton.titleLabel.text = @"Démarrer la partie";
    }
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


@end
