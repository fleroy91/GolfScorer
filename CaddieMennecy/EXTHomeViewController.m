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
#import "EXTGameViewController.h"
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
    [self.fetchedResultsController performFetch:nil];
    if([self.fetchedResultsController.fetchedObjects count] == 0) {
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
        for(NSArray *holeData in holesData){
            // We try to search for the hole in the DB
            Hole *hole = [[Hole MR_createEntity] initWithArray:holeData andCourse:course];
            NSManagedObjectContext* context = hole.managedObjectContext;
            [context MR_saveToPersistentStoreAndWait];
        }
    
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
    } else if ([segue.identifier isEqualToString:@"NewGame"]) {
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
