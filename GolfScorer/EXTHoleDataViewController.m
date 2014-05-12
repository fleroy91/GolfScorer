//
//  EXTDataViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTHoleDataViewController.h"
#import "EXTHolesRootViewController.h"

@interface EXTHoleDataViewController ()
- (IBAction)homeMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *holeLabel;
@property (weak, nonatomic) IBOutlet UILabel *parLabel;
@property (weak, nonatomic) IBOutlet UILabel *handicapLabel;
@property (weak, nonatomic) IBOutlet UILabel *dist1Label;
@property (weak, nonatomic) IBOutlet UILabel *dist2Label;
@property (weak, nonatomic) IBOutlet UIView *dist2View;
@property (weak, nonatomic) IBOutlet UIView *dist1View;
@property (weak, nonatomic) IBOutlet UIButton *player1Button;
@property (weak, nonatomic) IBOutlet UIButton *player2Button;
@property (weak, nonatomic) IBOutlet UIButton *player3Button;
@property (weak, nonatomic) IBOutlet UIButton *player4Button;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brutLabel;
@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UILabel *hcpLabel;
@property (weak, nonatomic) IBOutlet UILabel *brutTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *netTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hcpTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *hcpView;
@property (weak, nonatomic) IBOutlet UIView *brutView;
@property (weak, nonatomic) IBOutlet UIView *netView;
@property (weak, nonatomic) IBOutlet UITableView *formView;

- (IBAction)toggleDisplay:(id)sender;
@property NSUInteger indexPlayerSelected;
@property BOOL showStableford;

- (IBAction)chosePlayer1:(id)sender;
- (IBAction)chosePlayer2:(id)sender;
- (IBAction)chosePlayer3:(id)sender;
- (IBAction)chosePlayer4:(id)sender;

@property (nonatomic, strong) FXFormController *formController;

@end

@implementation EXTHoleDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _indexPlayerSelected = 1;
    
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.formView;
    self.formController.delegate = self;
    self.formController.form = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.holeLabel.text = [NSString stringWithFormat:@"%@", self.hole.number];
    self.parLabel.text = [NSString stringWithFormat:@"%@", self.hole.par];
    self.handicapLabel.text = [NSString stringWithFormat:@"%@", self.hole.handicap];
    self.dist1Label.text = [NSString stringWithFormat:@"%@m", self.hole.range2];
    self.dist2Label.text = [NSString stringWithFormat:@"%@m", self.hole.range3];
    
    // We need to manage the players button
    [self updateButtonWithPlayerAtIndex:1 withButton:self.player1Button];
    [self updateButtonWithPlayerAtIndex:2 withButton:self.player2Button];
    [self updateButtonWithPlayerAtIndex:3 withButton:self.player3Button];
    [self updateButtonWithPlayerAtIndex:4 withButton:self.player4Button];
    
    self.dataLabel.text = [NSString stringWithFormat:@"Trou #%@", self.hole.number];
    
    self.formController.form = (id)self.modelController.playerGameHole;
    [self.formView reloadData];
}

- (void)submitHole:(UITableViewCell<FXFormFieldCell> *)cell
{
    [self.modelController saveCurrentHoleWithHole:self.hole];
    
    if(self.indexPlayerSelected < [self.playerGameHoles count]) {
        self.indexPlayerSelected ++;
        [self viewWillAppear:NO];
    } else {
        // We have to go to the next hole
        [self.modelController pageForward:(UIPageViewController *)self.parentViewController];
    }
}

- (void)doNothin:(UITableViewCell<FXFormFieldCell> *)cell
{
    // We do nothing on purpose
}

- (void)updateButtonWithPlayerAtIndex:(NSUInteger)index withButton:(UIButton *)button
{
    // First we search for the player game
    PlayerGame *pg = nil;
    PlayerGameHole *currentPgh = nil;
    for(PlayerGameHole *pgh in self.playerGameHoles) {
        if(pgh.inPlayerGame.row.unsignedIntValue == index) {
            pg = pgh.inPlayerGame;
            currentPgh = pgh;
        }
    }
    if(pg) {
        // We have a player !
        button.enabled = YES;
        [button setTitle:[NSString stringWithFormat:@"%@\n%@", pg.forPlayer.firstname, [pg getBrutScore:NO]] forState:UIControlStateNormal];
        if(index == self.indexPlayerSelected) {
            button.backgroundColor = [UIColor cyanColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            
            self.playerNameLabel.text = [NSString stringWithFormat:@"%@ %@", pg.forPlayer.firstname, pg.forPlayer.lastname];
            self.brutLabel.text = [pg getBrutScore:self.showStableford];
            self.netLabel.text = [pg getNetScore:self.showStableford];
            if(self.showStableford) {
                self.hcpLabel.text = [NSString stringWithFormat:@"%d",currentPgh.forHole.par.unsignedIntValue + currentPgh.game_hcp.unsignedIntValue];
            } else {
                self.hcpLabel.text = [NSString stringWithFormat:@"%@",currentPgh.game_hcp];
            }
            // We need to display the score form
            self.modelController.playerGameHole = currentPgh;
          
        } else {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    } else {
        // There's no player
        button.enabled = NO;
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
}

- (IBAction)homeMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)chosePlayer1:(id)sender {
    self.indexPlayerSelected = 1;
    [self viewWillAppear:NO];
}

- (IBAction)chosePlayer2:(id)sender {
    self.indexPlayerSelected = 2;
    [self viewWillAppear:NO];
}

- (IBAction)chosePlayer3:(id)sender {
    self.indexPlayerSelected = 3;
    [self viewWillAppear:NO];
}

- (IBAction)chosePlayer4:(id)sender {
    self.indexPlayerSelected = 4;
    [self viewWillAppear:NO];
}
- (IBAction)toggleDisplay:(id)sender {
    self.showStableford = !self.showStableford;
    if(self.showStableford) {
        self.hcpView.backgroundColor = UIColorFromRGB(0xcee25d);
        self.brutView.backgroundColor = UIColorFromRGB(0xcee25d);
        self.netView.backgroundColor = UIColorFromRGB(0xcee25d);
        self.brutTitleLabel.text = @"S Brut";
        self.netTitleLabel.text = @"S Net";
        self.hcpTitleLabel.text = @"S Par";
    } else {
        self.hcpView.backgroundColor = [UIColor whiteColor];
        self.brutView.backgroundColor = [UIColor whiteColor];
        self.netView.backgroundColor = [UIColor whiteColor];
        self.brutTitleLabel.text = @"Brut";
        self.netTitleLabel.text = @"Net";
        self.hcpTitleLabel.text = @"C. Reçus";
        
    }
    [self viewWillAppear:NO];
}
@end
