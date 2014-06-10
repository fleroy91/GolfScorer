//
//  EXTHomeViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTHomeViewController.h"
#import "EXTAppDelegate.h"
#import "EXTOldGamesTableViewController.h"
#import "EXTNewGameViewController.h"
#import "EXTGlobal.h"

@interface EXTHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *gameButton;
- (IBAction)resetAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation EXTHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)documentIsReady
{
    NSLog(@"Loaded !");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Loading !");
    NSLog(@"We need to display a spinner !");
    [self findOrCreateHolesInDB];
    [self.versionLabel setText:[NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    currentGame = [Game MR_findFirstOrderedByAttribute:@"when" ascending:NO];
    if(currentGame.is_over.boolValue) {
        currentGame = nil;
    }
    if(! currentGame.is_started.boolValue) {
        [currentGame MR_deleteEntity];
        currentGame = nil;
    }
    if(currentGame) {
        [self.gameButton setTitle: @"Partie en cours" forState:UIControlStateNormal];
    } else {
        [self.gameButton setTitle: @"Nouvelle partie" forState:UIControlStateNormal];
    }
}
- (BOOL)prefersStatusBarHidden {return YES;}

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (_fetchedResultsController == nil) {
        self.fetchedResultsController = [Hole MR_fetchAllSortedBy:@"number" ascending:YES withPredicate:nil groupBy:nil delegate:self];
    }
	
	return _fetchedResultsController;
}

- (void)findOrCreateHolesInDB
{
    Course *course = [Course MR_findFirstByAttribute:@"name" withValue:@"Mennecy - Chevannes"];
    if(! course) {
        // Create the data model.
        Course *course = [Course MR_createEntity];
        course.name = @"Mennecy - Chevannes";
        course.par = @71;
        course.slope2M = @132;
        course.slope3M = @131;
        course.slope4M = @123;
        course.slope5M = @120;
        course.sss2M = @73.1;
        course.sss3M = @69.9;
        course.sss4M = @66.4;
        course.sss5M = @65.2;
        course.slope2F = @134;
        course.slope3F = @125;
        course.slope4F = @122;
        course.sss2F = @75.8;
        course.sss3F = @71.6;
        course.sss4F = @69.9;
        [course.managedObjectContext MR_saveToPersistentStoreAndWait];
        
        NSArray *holesData = @[@[@1,  @4,  @6, @375, @363, @327, @315],
                               @[@2,  @4,  @2, @439, @375, @308, @298],
                               @[@3,  @4,  @5, @379, @364, @318, @304],
                               @[@4,  @3, @16, @123, @120, @102, @101],
                               @[@5,  @4, @17, @347, @332, @291, @277],
                               @[@6,  @5, @13, @476, @461, @403, @390],
                               @[@7,  @4,  @8, @368, @316, @304, @294],
                               @[@8,  @3, @18, @159, @142, @120, @115],
                               @[@9,  @4,  @9, @342, @328, @285, @271],
                               @[@10, @4, @15, @346, @333, @292, @278],
                               @[@11, @4, @14, @358, @343, @301, @288],
                               @[@12, @5,  @5, @539, @484, @413, @398],
                               @[@13, @3, @11, @158, @153, @130, @127],
                               @[@14, @4,  @4, @369, @324, @275, @264],
                               @[@15, @4, @10, @391, @311, @300, @253],
                               @[@16, @5, @12, @484, @470, @409, @392],
                               @[@17, @3,  @7, @194, @150, @144, @122],
                               @[@18, @4,  @1, @430, @379, @326, @311]];
        [course createHoles:holesData];
    }
    course = [Course MR_findFirstByAttribute:@"name" withValue:@"Etioles"];
    if(! course) {
        // Create the data model.
        Course *course = [Course MR_createEntity];
        course.name = @"Etioles";
        course.par = @73;
        course.slope2M = @123;
        course.slope3M = @118;
        course.slope4M = @1114;
        course.slope5M = @109;
        course.sss2M = @72.9;
        course.sss3M = @70.5;
        course.sss4M = @68.4;
        course.sss5M = @65.9;
        course.slope2F = @133;
        course.slope3F = @128;
        course.slope4F = @118;
        course.sss2F = @70.5;
        course.sss3F = @73.8;
        course.sss4F = @70.5;
        [course.managedObjectContext MR_saveToPersistentStoreAndWait];
        
        NSArray *holesData = @[@[@1,  @5,  @8, @480, @450, @418, @392],
                               @[@2,  @4, @12, @362, @351, @292, @262],
                               @[@3,  @4, @2,  @391, @367, @357, @287],
                               @[@4,  @4, @18, @280, @237, @227, @187],
                               @[@5,  @3, @10, @184, @158, @138, @108],
                               @[@6,  @5, @4,  @506, @466, @451, @445],
                               @[@7,  @4, @14, @337, @327, @313, @302],
                               @[@8,  @5, @6,  @467, @457, @405, @377],
                               @[@9,  @3, @16, @160, @139, @120, @118],
                               @[@10, @4, @13, @314, @284, @243, @206],
                               @[@11, @4, @7,  @353, @331, @310, @271],
                               @[@12, @4, @1,  @384, @375, @346, @324],
                               @[@13, @5, @3,  @510, @468, @447, @404],
                               @[@14, @4, @17, @289, @269, @262, @226],
                               @[@15, @3, @15, @165, @145, @132, @103],
                               @[@16, @5, @9,  @469, @440, @415, @408],
                               @[@17, @3, @11, @195, @169, @155, @116],
                               @[@18, @4, @5,  @386, @344, @323, @311]];
        [course createHoles:holesData];
    }

}
-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark - Navigations

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"OldGames"] ){
    } else if ([segue.identifier isEqualToString:@"NewGame2"]) {
        if(! currentGame) {
            currentGame = [Game create];
        }
    }
}
- (IBAction)resetAction:(id)sender {
    [Course MR_truncateAll];
    [Game MR_truncateAll];
    [Hole MR_truncateAll];
    [PlayerGame MR_truncateAll];
    [PlayerGameHole MR_truncateAll];
    [Player MR_truncateAll];
    [MagicalRecord saveWithBlockAndWait:nil];
    [self findOrCreateHolesInDB];
    [self viewWillAppear:YES];
}
@end
