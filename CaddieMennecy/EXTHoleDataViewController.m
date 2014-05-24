//
//  EXTDataViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTHoleDataViewController.h"
#import "EXTHolesRootViewController.h"
#import "EXTScoreCardViewController.h"

@interface EXTHoleDataViewController ()
- (IBAction)homeMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *holeLabel;
@property (weak, nonatomic) IBOutlet UILabel *parLabel;
@property (weak, nonatomic) IBOutlet UILabel *handicapLabel;
@property (weak, nonatomic) IBOutlet UILabel *distLabel;
@property (weak, nonatomic) IBOutlet UIButton *player1Button;
@property (weak, nonatomic) IBOutlet UIButton *player2Button;
@property (weak, nonatomic) IBOutlet UIButton *player3Button;
@property (weak, nonatomic) IBOutlet UIButton *player4Button;
@property (weak, nonatomic) IBOutlet UILabel *brutLabel;
@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UILabel *hcpLabel;
@property (weak, nonatomic) IBOutlet UILabel *brutTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *netTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hcpTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *formView;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property NSInteger range_index;
@property PlayerGame *currentPlayerGame;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)toggleDisplay:(id)sender;
- (IBAction)toggleDistance:(id)sender;
@property NSUInteger indexPlayerSelected;
@property BOOL showStableford;
@property (weak, nonatomic) IBOutlet UILabel *elapsedLabel;

- (IBAction)chosePlayer1:(id)sender;
- (IBAction)chosePlayer2:(id)sender;
- (IBAction)chosePlayer3:(id)sender;
- (IBAction)chosePlayer4:(id)sender;

@property (nonatomic, strong) FXFormController *formController;
@property BOOL canHandleOrientation;

@property NSTimer *myTimer;
- (void)updateTime:(id)sender;

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
    self.range_index = -1;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deviceOrientationDidChangeNotification:)
     name:UIDeviceOrientationDidChangeNotification
     object:nil];
    self.canHandleOrientation = YES;
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:30.0
                                     target:self
                                   selector:@selector(updateTime:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
{
    if(self.canHandleOrientation) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        switch (orientation)
        {
            case UIDeviceOrientationPortrait:
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
            {
                self.canHandleOrientation = NO;
                UIStoryboard *storyboard = self.storyboard;
                EXTScoreCardViewController * vc = (EXTScoreCardViewController *)[storyboard instantiateViewControllerWithIdentifier:@"scoreCardView"];
                vc.playerGame = self.currentPlayerGame;
                vc.notifOrientation = YES;
                vc.modalPresentationStyle = UIModalPresentationFullScreen;
                vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                [self presentViewController:vc animated:YES completion:^{
                    self.canHandleOrientation = YES;
                }];
                break;
            }
            default:
                break;
        }
    }
}

- (void)updateTime:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate * now = [NSDate date];
    NSString *formattedDateString = [dateFormatter stringFromDate:now];
    [self.timeLabel setText:formattedDateString];
    NSTimeInterval duration = [now timeIntervalSinceDate:currentGame.when];
    NSUInteger seconds = (NSUInteger)round(duration);
    [self.elapsedLabel setText:[NSString stringWithFormat:@"%02u:%02u",
                                 seconds / 3600, (seconds / 60) % 60]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.holeLabel.text = [NSString stringWithFormat:@"%@", self.hole.number];
    self.parLabel.text = [NSString stringWithFormat:@"%@", self.hole.par];
    self.handicapLabel.text = [NSString stringWithFormat:@"%@", self.hole.handicap];
    // We need to manage the players button
    [self updateButtonWithPlayerAtIndex:1 withButton:self.player1Button];
    [self updateButtonWithPlayerAtIndex:2 withButton:self.player2Button];
    [self updateButtonWithPlayerAtIndex:3 withButton:self.player3Button];
    [self updateButtonWithPlayerAtIndex:4 withButton:self.player4Button];
    
    self.formController.form = (id)self.modelController.playerGameHole;
    [self.formView reloadData];
    [self updateTime:nil];
}

- (void)doNothing:(UITableViewCell<FXFormFieldCell> *)cell
{
    
}
- (void)endGame:(UITableViewCell<FXFormFieldCell> *)cell
{
    [currentGame setIsOver:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)submitHole:(UITableViewCell<FXFormFieldCell> *)cell
{
    [self.modelController saveCurrentHoleWithHole:self.hole];
    
    if(self.indexPlayerSelected < [self.playerGameHoles count]) {
        [self animateUpdateViewAtIndex:self.indexPlayerSelected+1];
    } else {
        // We have to go to the next hole
        [self.modelController pageForward:(UIPageViewController *)self.parentViewController];
    }
}

- (NSString *)getDistance
{
    NSUInteger dist = 0;
    switch(self.range_index) {
        case 0:
            dist = self.hole.range1.unsignedIntegerValue;
            break;
        case 1:
            dist = self.hole.range2.unsignedIntegerValue;
            break;
        case 2:
            dist = self.hole.range3.unsignedIntegerValue;
            break;
        case 3:
            dist = self.hole.range4.unsignedIntegerValue;
            break;
        case 4:
            dist = self.hole.range5.unsignedIntegerValue;
            break;
        default:
            dist = self.hole.range3.unsignedIntegerValue;
            break;
    }
    return [NSString stringWithFormat:@"%d m", dist];
}

- (void)updateButtonWithPlayerAtIndex:(NSUInteger)index withButton:(UIButton *)button
{
    NSArray *dist_colors = [[NSArray alloc] initWithObjects:[UIColor blackColor], [UIColor whiteColor], [UIColor yellowColor], [UIColor blueColor], [UIColor redColor], nil];
    
    // First we search for the player game
    PlayerGame *pg = nil;
    PlayerGameHole *currentPgh = nil;
    for(PlayerGameHole *pgh in self.playerGameHoles) {
        if(pgh.inPlayerGame.row.unsignedIntValue == index) {
            pg = pgh.inPlayerGame;
            currentPgh = pgh;
        }
    }
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(pg) {
        // We have a player !
        button.enabled = YES;
        [button setTitle:[NSString stringWithFormat:@"%@", pg.forPlayer.firstname] forState:UIControlStateNormal];
        if(index == self.indexPlayerSelected) {
            self.currentPlayerGame = pg;
            if(self.range_index < 0) {
                self.range_index = pg.forPlayer.start_color.integerValue;
            }
            [button setBackgroundImage:[UIImage imageNamed:@"btn-back2px.png"] forState:UIControlStateNormal];
            
            self.distLabel.text = [self getDistance];
            [self.distLabel setTextColor:dist_colors[self.range_index]];
            self.brutLabel.text = [pg getBrutScore:self.showStableford];
            self.netLabel.text = [pg getNetScore:self.showStableford];
            if(self.showStableford) {
                self.hcpLabel.text = [NSString stringWithFormat:@"%d",currentPgh.forHole.par.unsignedIntValue + currentPgh.game_hcp.unsignedIntValue];
                [self.hcpLabel setTextColor:[UIColor yellowColor]];
                [self.brutLabel setTextColor:[UIColor yellowColor]];
                [self.netLabel setTextColor:[UIColor yellowColor]];
            } else {
                self.hcpLabel.text = [NSString stringWithFormat:@"%@",currentPgh.game_hcp];
                [self.hcpLabel setTextColor:[UIColor whiteColor]];
                [self.brutLabel setTextColor:[UIColor whiteColor]];
                [self.netLabel setTextColor:[UIColor whiteColor]];
            }
            // We need to display the score form
            self.modelController.playerGameHole = currentPgh;
        } else {
            [button setBackgroundImage:[UIImage alloc] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    } else {
        // There's no player
        button.enabled = NO;
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
}
- (BOOL)prefersStatusBarHidden {return YES;}

- (IBAction)homeMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
-(void)animateUpdateViewAtIndex:(NSInteger)index
{
    self.range_index = -1;
    if(self.indexPlayerSelected != index) {
        // We need to unselect the buttons
        [self.player1Button setBackgroundImage:nil forState:UIControlStateNormal];
        [self.player2Button setBackgroundImage:nil forState:UIControlStateNormal];
        [self.player3Button setBackgroundImage:nil forState:UIControlStateNormal];
        [self.player4Button setBackgroundImage:nil forState:UIControlStateNormal];
    }
    UIButton *button = nil;
    self.indexPlayerSelected = index;
    switch(self.indexPlayerSelected) {
        case 1:
            button = self.player1Button;
            break;
        case 2:
            button = self.player2Button;
            break;
        case 3:
            button = self.player3Button;
            break;
        case 4:
            button = self.player4Button;
            break;
    }
    [UIView animateWithDuration:0.1 animations:^(void){
        [self.playerView setAlpha:0];
    } completion:^(BOOL finished) {
        [self updateButtonWithPlayerAtIndex:index withButton:button];
        self.formController.form = (id)self.modelController.playerGameHole;
        [self.formView reloadData];
        [UIView animateWithDuration:0.1 animations:^(void){
            [self.playerView setAlpha:1];
        } completion:nil];
    }];
}

- (IBAction)chosePlayer1:(id)sender {
    [self animateUpdateViewAtIndex:1];
}

- (IBAction)chosePlayer2:(id)sender {
    [self animateUpdateViewAtIndex:2 ];
}

- (IBAction)chosePlayer3:(id)sender {
    [self animateUpdateViewAtIndex:3 ];
}

- (IBAction)chosePlayer4:(id)sender {
    [self animateUpdateViewAtIndex:4 ];
}

- (IBAction)toggleDisplay:(id)sender {
    self.showStableford = !self.showStableford;
    if(self.showStableford) {
        [self.brutTitleLabel setText:@"S Brut"];
        [self.netTitleLabel setText:@"S Net"];
        [self.hcpTitleLabel setText: @"S Par"];
    } else {
        [self.brutTitleLabel setText:@"Brut"];
        [self.netTitleLabel setText:@"Net"];
        [self.hcpTitleLabel setText: @"C. Reçus"];
    }
    [self viewWillAppear:YES];
}

- (IBAction)toggleDistance:(id)sender {
    self.range_index ++;
    if(self.range_index > 4 ) {
        self.range_index = 0;
    }
    [self viewWillAppear:YES];
}

@end
