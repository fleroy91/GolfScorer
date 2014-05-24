//
//  EXTScoreCardViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 20/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTScoreCardViewController.h"

@interface EXTScoreCardViewController ()
@property NSArray *distLabels;
@property NSArray *parLabels;
@property NSArray *scoreLabels;
@property (weak, nonatomic) IBOutlet UILabel *d1;
@property (weak, nonatomic) IBOutlet UILabel *d2;
@property (weak, nonatomic) IBOutlet UILabel *d3;
@property (weak, nonatomic) IBOutlet UILabel *d4;
@property (weak, nonatomic) IBOutlet UILabel *d5;
@property (weak, nonatomic) IBOutlet UILabel *d6;
@property (weak, nonatomic) IBOutlet UILabel *d7;
@property (weak, nonatomic) IBOutlet UILabel *d8;
@property (weak, nonatomic) IBOutlet UILabel *d9;
@property (weak, nonatomic) IBOutlet UILabel *d10;
@property (weak, nonatomic) IBOutlet UILabel *d11;
@property (weak, nonatomic) IBOutlet UILabel *d12;
@property (weak, nonatomic) IBOutlet UILabel *d13;
@property (weak, nonatomic) IBOutlet UILabel *d14;
@property (weak, nonatomic) IBOutlet UILabel *d15;
@property (weak, nonatomic) IBOutlet UILabel *d16;
@property (weak, nonatomic) IBOutlet UILabel *d17;
@property (weak, nonatomic) IBOutlet UILabel *d18;

@property (weak, nonatomic) IBOutlet UILabel *p1;
@property (weak, nonatomic) IBOutlet UILabel *p2;
@property (weak, nonatomic) IBOutlet UILabel *p3;
@property (weak, nonatomic) IBOutlet UILabel *p4;
@property (weak, nonatomic) IBOutlet UILabel *p5;
@property (weak, nonatomic) IBOutlet UILabel *p6;
@property (weak, nonatomic) IBOutlet UILabel *p7;
@property (weak, nonatomic) IBOutlet UILabel *p8;
@property (weak, nonatomic) IBOutlet UILabel *p9;
@property (weak, nonatomic) IBOutlet UILabel *p10;
@property (weak, nonatomic) IBOutlet UILabel *p11;
@property (weak, nonatomic) IBOutlet UILabel *p12;
@property (weak, nonatomic) IBOutlet UILabel *p13;
@property (weak, nonatomic) IBOutlet UILabel *p14;
@property (weak, nonatomic) IBOutlet UILabel *p15;
@property (weak, nonatomic) IBOutlet UILabel *p16;
@property (weak, nonatomic) IBOutlet UILabel *p17;
@property (weak, nonatomic) IBOutlet UILabel *p18;

@property (weak, nonatomic) IBOutlet UILabel *s1;
@property (weak, nonatomic) IBOutlet UILabel *s2;
@property (weak, nonatomic) IBOutlet UILabel *s3;
@property (weak, nonatomic) IBOutlet UILabel *s4;
@property (weak, nonatomic) IBOutlet UILabel *s5;
@property (weak, nonatomic) IBOutlet UILabel *s6;
@property (weak, nonatomic) IBOutlet UILabel *s7;
@property (weak, nonatomic) IBOutlet UILabel *s8;
@property (weak, nonatomic) IBOutlet UILabel *s9;
@property (weak, nonatomic) IBOutlet UILabel *s10;
@property (weak, nonatomic) IBOutlet UILabel *s11;
@property (weak, nonatomic) IBOutlet UILabel *s12;
@property (weak, nonatomic) IBOutlet UILabel *s13;
@property (weak, nonatomic) IBOutlet UILabel *s14;
@property (weak, nonatomic) IBOutlet UILabel *s15;
@property (weak, nonatomic) IBOutlet UILabel *s16;
@property (weak, nonatomic) IBOutlet UILabel *s17;
@property (weak, nonatomic) IBOutlet UILabel *s18;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)btnCloseAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *inTotalDistLabel;
@property (weak, nonatomic) IBOutlet UILabel *inTotalParLabel;
@property (weak, nonatomic) IBOutlet UILabel *inTotalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *outTotalDistLabel;
@property (weak, nonatomic) IBOutlet UILabel *outTotalParLabel;
@property (weak, nonatomic) IBOutlet UILabel *outTotalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalDistLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalParLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;

@end

@implementation EXTScoreCardViewController

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
    _distLabels = [[NSArray alloc] initWithObjects:_d1,_d2,_d3,_d4,_d5,_d6,_d7,_d8,_d9, _d10, _d11, _d12, _d13, _d14, _d15, _d16, _d17, _d18, nil];
    _parLabels = [[NSArray alloc] initWithObjects:_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8,_p9, _p10, _p11, _p12, _p13, _p14, _p15, _p16, _p17, _p18,nil];
    _scoreLabels = [[NSArray alloc] initWithObjects:_s1,_s2,_s3,_s4,_s5,_s6,_s7,_s8,_s9, _s10, _s11, _s12, _s13, _s14, _s15, _s16, _s17, _s18,nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deviceOrientationDidChangeNotification:)
     name:UIDeviceOrientationDidChangeNotification
     object:nil];
}

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    switch (orientation)
    {
        case UIDeviceOrientationPortrait:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}
- (BOOL)prefersStatusBarHidden {return YES;}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for(UILabel *lbl in self.distLabels) {
        lbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px.png"]];
    }
    for(UILabel *lbl in self.parLabels) {
        lbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px.png"]];
    }
    for(UILabel *lbl in self.scoreLabels) {
        lbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px.png"]];
    }
    self.inTotalParLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.inTotalDistLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.inTotalScoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.outTotalParLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.outTotalDistLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.outTotalScoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.totalParLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.totalDistLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    self.totalScoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-50.png"]];
    
    [self.titleLabel setText:[self.playerGame.forPlayer description]];
    int totalScore = 0;
    int totalDist = 0;
    int totalPar = 0;
    int inTotalScore = 0;
    int inTotalDist = 0;
    int inTotalPar = 0;
    int outTotalScore = 0;
    int outTotalDist = 0;
    int outTotalPar = 0;
    BOOL inFound = NO;
    BOOL outFound = NO;
    for(int holeNumber = 1; holeNumber <= 18 ; holeNumber ++) {
        int holeIndex = holeNumber - 1;
        PlayerGameHole *found = nil;
        for(PlayerGameHole *pgh in self.playerGame.thePlayerGameHoles) {
            if(pgh.number.integerValue == holeNumber) {
                found = pgh;
                break;
            }
        }
        if(found) {
            int par = found.forHole.par.integerValue;
            int score = found.hole_score.integerValue;
            // TODO
            int dist = found.forHole.range3.unsignedIntegerValue;
            totalPar += par;
            if(! found.is_saved.boolValue) {
                score = 0;
            }
            totalScore += score;
            totalDist += dist;
            if(holeNumber <= 9) {
                if(found.is_saved.boolValue) {
                    inFound = YES;
                }
                inTotalPar += par;
                inTotalDist += dist;
                inTotalScore += score;
            } else {
                if(found.is_saved.boolValue) {
                    outFound = YES;
                }
                outTotalPar += par;
                outTotalDist += dist;
                outTotalScore += score;
            }
            [self.parLabels[holeIndex] setText:[NSString stringWithFormat:@"%d", par]];
            [self.distLabels[holeIndex] setText:[NSString stringWithFormat:@"%dm", dist]];
            if(found.is_saved.boolValue) {
                UILabel *scoreLabel =self.scoreLabels[holeIndex];
                [scoreLabel setText:[NSString stringWithFormat:@"%d", score]];
                if(score < par - 1) {
                    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-eagle.png"]];
                } else if(score < par) {
                    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-birdie.png"]];
                } else if(score > par + 1) {
                    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-double.png"]];
                } else if(score > par) {
                    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-back1px-bogey.png"]];
                }

            } else {
                [self.scoreLabels[holeIndex] setText:@""];
            }
        } else {
            [self.parLabels[holeIndex] setText:@""];
            [self.scoreLabels[holeIndex] setText:@""];
            [self.distLabels[holeIndex] setText:@""];
        }
    }
    [self.inTotalParLabel setText:[NSString stringWithFormat:@"%d", inTotalPar]];
    [self.inTotalDistLabel setText:[NSString stringWithFormat:@"%dm", inTotalDist]];
    if(inFound) {
        [self.inTotalScoreLabel setText:[NSString stringWithFormat:@"%d", inTotalScore]];
    } else {
        [self.inTotalScoreLabel setText:@""];
    }
    [self.outTotalParLabel setText:[NSString stringWithFormat:@"%d", outTotalPar]];
    [self.outTotalDistLabel setText:[NSString stringWithFormat:@"%dm", outTotalDist]];
    if(outFound) {
        [self.outTotalScoreLabel setText:[NSString stringWithFormat:@"%d", outTotalScore]];
    } else {
        [self.outTotalScoreLabel setText:@""];
    }
    [self.totalParLabel setText:[NSString stringWithFormat:@"%d", totalPar]];
    [self.totalDistLabel setText:[NSString stringWithFormat:@"%dm", totalDist]];
    [self.totalScoreLabel setText:[NSString stringWithFormat:@"%d", totalScore]];
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

- (IBAction)btnCloseAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
