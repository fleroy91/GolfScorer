//
//  EXTDataViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTHoleDataViewController.h"
#import "EXTScoreCardViewController.h"
#import "EXTHolePlayerViewController.h"
#import "EXTDAPagesContainer.h"

@interface EXTHoleDataViewController ()
@property EXTDAPagesContainer *pagesContainer;
@property (weak, nonatomic) IBOutlet UILabel *parLabel;
@property (weak, nonatomic) IBOutlet UILabel *handicapLabel;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property NSMutableArray *vcs;
@property (weak, nonatomic) IBOutlet UILabel *dist1Label;
@property (weak, nonatomic) IBOutlet UILabel *dist2Label;
@property (weak, nonatomic) IBOutlet UILabel *dist3Label;
@property (weak, nonatomic) IBOutlet UILabel *dist4Label;
@property (weak, nonatomic) IBOutlet UILabel *dist5Label;

- (IBAction)doNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation EXTHoleDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.pagesContainer = [[EXTDAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.playerView.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pagesContainer.topBarBackgroundColor = UIColorFromRGBAndAlpha(0, 0.2);
    self.pagesContainer.topBarHeight = 30;
    [self.playerView addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    [self.dist1Label setText:[self.hole formatDistanceForColor:0]];
    [self.dist2Label setText:[self.hole formatDistanceForColor:1]];
    [self.dist3Label setText:[self.hole formatDistanceForColor:2]];
    [self.dist4Label setText:[self.hole formatDistanceForColor:3]];
    [self.dist5Label setText:[self.hole formatDistanceForColor:4]];
    
    _vcs = [[NSMutableArray alloc] init];
    for(PlayerGameHole *pgh in self.playerGameHoles) {
        EXTHolePlayerViewController *holePlayerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EXTHolePlayerViewController"];
        holePlayerViewController.playerGameHole = pgh;
        holePlayerViewController.modelController = self;
        [_vcs addObject:holePlayerViewController];
    }
    self.pagesContainer.viewControllers = _vcs;
}

- (NSString *)getTitle
{
    return [NSString stringWithFormat:@"Trou n°%@", self.hole.number];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.parLabel.text = [NSString stringWithFormat:@"%@", self.hole.par];
    self.handicapLabel.text = [NSString stringWithFormat:@"%@", self.hole.handicap];
    [self updateNextButton];
}

- (void)doNothing:(UITableViewCell<FXFormFieldCell> *)cell
{
    
}
- (void)endGame:(UITableViewCell<FXFormFieldCell> *)cell
{
    [self saveHole];
    [currentGame setIsOver:YES];
    [self.modelController homeMenu:self];
}
- (void)saveHole
{
    for(EXTHolePlayerViewController *vc in self.vcs) {
        [vc saveHole];
    }
}
- (void)submitHole:(UITableViewCell<FXFormFieldCell> *)cell
{
    [self saveHole];
    if(self.pagesContainer.selectedIndex < [self.playerGameHoles count] - 1) {
        [self.pagesContainer setSelectedIndex:self.pagesContainer.selectedIndex+1 animated:YES];
    } else {
        // We have to go to the next hole
        [self.modelController pageForward];
    }
}
-(BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
- (BOOL)isLastHoleAndPlayer
{
    return [[self getCurrentPlayerGameHole] isLastHoleAndPlayer];
}
- (PlayerGameHole *)getCurrentPlayerGameHole
{
    NSUInteger index = self.pagesContainer.selectedIndex;
    EXTHolePlayerViewController *holePlayerViewController = self.vcs[index];
    return holePlayerViewController.playerGameHole;
}
-(void)updateNextButton
{
    if([self isLastHoleAndPlayer]) {
        [self.nextButton setTitle:@"Terminer la partie" forState:UIControlStateNormal];
        [self.nextButton setBackgroundImage:[UIImage imageNamed:@"btn-back2px-red"] forState:UIControlStateNormal];
    } else {
        [self.nextButton setTitle:@"Valider et suivant" forState:UIControlStateNormal];
        [self.nextButton setBackgroundImage:[UIImage imageNamed:@"btn-back2px-green"] forState:UIControlStateNormal];
    }
}

- (IBAction)doNext:(id)sender {
    if([self isLastHoleAndPlayer]) {
        [self endGame:nil];
    } else {
        [self submitHole:nil];
    }
}

@end
