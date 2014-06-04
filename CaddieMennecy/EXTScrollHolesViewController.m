//
//  EXTScrollHolesViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 03/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTScrollHolesViewController.h"
#import "EXTHoleDataViewController.h"
#import "EXTScoreCardViewController.h"
#import "EXTDAPagesContainer.h"

@interface EXTScrollHolesViewController ()

@property EXTDAPagesContainer *pagesContainer;
@property NSMutableArray *holes;
@property NSInteger startingPageIndex;
@property (weak, nonatomic) IBOutlet UIView *holesView;
@property BOOL canHandleOrientation;
@property NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property NSMutableArray *vcs;

// Actions
- (void)updateTime:(id)sender;

@end

@implementation EXTScrollHolesViewController

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
    // We need to create all the PlayerGameHoles for the currentGame
    _holes = [[NSMutableArray alloc] init];
    int nbHolesAdded = 0;
    self.startingPageIndex = -1;
    NSUInteger number = [currentGame getStartingHoleNumber];
    while (nbHolesAdded < [currentGame getNbHolesPlayed]) {
        for(Hole *h in currentGame.forCourse.theHoles) {
            if(h.number.integerValue == number) {
                [_holes addObject:h];
                if(self.startingPageIndex < 0) {
                    // We need to find the first PGH not saved and show it
                    NSMutableArray *pghs = [self findPlayerGameHolesForHole:h];
                    for(PlayerGameHole *pgh in pghs) {
                        if(! pgh.is_saved.boolValue) {
                            self.startingPageIndex = nbHolesAdded;
                        }
                    }
                }
                break;
            }
        }
        nbHolesAdded ++;
        number ++;
        if(number > 18) {
            number = 1;
        }
    }
    NSLog(@"Nb holes in game : %d", [_holes count]);
    if(self.startingPageIndex == -1) {
        self.startingPageIndex = nbHolesAdded - 1;
    }
    
    self.pagesContainer = [[EXTDAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.holesView.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pagesContainer.topBarBackgroundColor = UIColorFromRGBAndAlpha(0, 0.3);
    [self.holesView addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    
    _vcs = [[NSMutableArray alloc] init];
    for(Hole *hole in self.holes) {
        EXTHoleDataViewController *dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EXTHoleDataViewController"];
        dataViewController.hole = hole;
        dataViewController.playerGameHoles = [self findPlayerGameHolesForHole:hole];
        dataViewController.pageIndex = [_vcs count];
        dataViewController.modelController = self;
        [_vcs addObject:dataViewController];
    }
    
    self.pagesContainer.viewControllers = _vcs;
    [self.pagesContainer setSelectedIndex:self.startingPageIndex animated:YES];
    
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

- (void)updateTime:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate * now = [NSDate date];
    NSString *formattedDateString = [dateFormatter stringFromDate:now];
    [self.timeLabel setText:formattedDateString];
    NSTimeInterval duration = [now timeIntervalSinceDate:currentGame.when];
    NSUInteger seconds = (NSUInteger)round(duration);
    [self.elapsedTimeLabel setText:[NSString stringWithFormat:@"%02u:%02u",
                                seconds / 3600, (seconds / 60) % 60]];
}

- (IBAction)homeMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
                EXTHoleDataViewController *holeDataVc = self.vcs[self.pagesContainer.selectedIndex];
                EXTScoreCardViewController * vc = (EXTScoreCardViewController *)[storyboard instantiateViewControllerWithIdentifier:@"scoreCardView"];
                vc.playerGame = holeDataVc.currentPlayerGame;
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

- (void)pageForward
{
    [self.pagesContainer setSelectedIndex:self.pagesContainer.selectedIndex + 1 animated:YES];
}

-(NSMutableArray *)findPlayerGameHolesForHole:(Hole *)hole
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for(PlayerGame *pg in currentGame.thePlayerGames) {
        for(PlayerGameHole *pgh in pg.thePlayerGameHoles) {
            assert(pgh.forHole);
            if(pgh.number.integerValue == hole.number.integerValue) {
                [ret addObject:pgh];
            }
        }
    }
    return ret;
}

-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {return YES;}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateTime:nil];
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
