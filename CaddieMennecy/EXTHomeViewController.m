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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *oldGamesButton;
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
    self.gameButton.hidden = YES;
    self.oldGamesButton.hidden = YES;
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    NSArray *strJsons = @[
    @"{\"name\":\"Golf De Mennecy Chevannes\",\"url\":\"http://www.golfdechevannes.fr\",\"last_update\":\"2011-11-23\",\"par\":35,\"sss1M\":73.1,\"sss2M\":73.1,\"sss3M\":69.9,\"sss4M\":66.4,\"sss5M\":65.2,\"sss1F\":0.0,\"sss2F\":0.0,\"sss3F\":75.8,\"sss4F\":71.6,\"sss5F\":69.9,\"slope1M\":132,\"slope2M\":132,\"slope3M\":131,\"slope4M\":123,\"slope5M\":120,\"slope1F\":0,\"slope2F\":0,\"slope3F\":134,\"slope4F\":125,\"slope5F\":122,\"holes\":[{\"num\":1,\"par\":4,\"hcp\":6,\"black\":375,\"white\":375,\"yellow\":363,\"blue\":327,\"red\":315,\"time\":14},{\"num\":2,\"par\":4,\"hcp\":2,\"black\":439,\"white\":439,\"yellow\":375,\"blue\":308,\"red\":298,\"time\":14},{\"num\":3,\"par\":4,\"hcp\":3,\"black\":379,\"white\":379,\"yellow\":364,\"blue\":318,\"red\":304,\"time\":14},{\"num\":4,\"par\":3,\"hcp\":16,\"black\":123,\"white\":123,\"yellow\":120,\"blue\":102,\"red\":101,\"time\":11},{\"num\":5,\"par\":4,\"hcp\":17,\"black\":347,\"white\":347,\"yellow\":332,\"blue\":291,\"red\":277,\"time\":14},{\"num\":6,\"par\":5,\"hcp\":13,\"black\":476,\"white\":476,\"yellow\":461,\"blue\":403,\"red\":390,\"time\":17},{\"num\":7,\"par\":4,\"hcp\":8,\"black\":368,\"white\":368,\"yellow\":316,\"blue\":304,\"red\":294,\"time\":14},{\"num\":8,\"par\":3,\"hcp\":18,\"black\":159,\"white\":159,\"yellow\":142,\"blue\":120,\"red\":115,\"time\":11},{\"num\":9,\"par\":4,\"hcp\":9,\"black\":342,\"white\":342,\"yellow\":328,\"blue\":285,\"red\":271,\"time\":14},{\"num\":10,\"par\":4,\"hcp\":15,\"black\":346,\"white\":346,\"yellow\":333,\"blue\":292,\"red\":278,\"time\":14},{\"num\":11,\"par\":4,\"hcp\":14,\"black\":358,\"white\":358,\"yellow\":343,\"blue\":301,\"red\":288,\"time\":14},{\"num\":12,\"par\":5,\"hcp\":5,\"black\":539,\"white\":539,\"yellow\":484,\"blue\":413,\"red\":398,\"time\":17},{\"num\":13,\"par\":3,\"hcp\":11,\"black\":158,\"white\":158,\"yellow\":153,\"blue\":130,\"red\":127,\"time\":11},{\"num\":14,\"par\":4,\"hcp\":4,\"black\":369,\"white\":369,\"yellow\":324,\"blue\":275,\"red\":264,\"time\":14},{\"num\":15,\"par\":4,\"hcp\":10,\"black\":391,\"white\":391,\"yellow\":311,\"blue\":300,\"red\":253,\"time\":14},{\"num\":16,\"par\":5,\"hcp\":12,\"black\":484,\"white\":484,\"yellow\":470,\"blue\":409,\"red\":392,\"time\":17},{\"num\":17,\"par\":3,\"hcp\":7,\"black\":194,\"white\":194,\"yellow\":150,\"blue\":144,\"red\":122,\"time\":11},{\"num\":18,\"par\":4,\"hcp\":1,\"black\":430,\"white\":430,\"yellow\":379,\"blue\":326,\"red\":311,\"time\":14}]}"
    ,@"{\"name\":\"Golf De Moliets\",\"url\":\"http://www.golfmoliets.com\",\"last_update\":\"2012-11-30\",\"par\":36,\"sss1M\":73.7,\"sss2M\":71.9,\"sss3M\":70.2,\"sss4M\":68.9,\"sss5M\":65.9,\"sss1F\":0.0,\"sss2F\":0.0,\"sss3F\":75.8,\"sss4F\":74.2,\"sss5F\":70.8,\"slope1M\":135,\"slope2M\":132,\"slope3M\":122,\"slope4M\":108,\"slope5M\":114,\"slope1F\":0,\"slope2F\":0,\"slope3F\":131,\"slope4F\":127,\"slope5F\":119,\"holes\":[{\"num\":1,\"par\":4,\"hcp\":11,\"black\":336,\"white\":327,\"yellow\":303,\"blue\":293,\"red\":256,\"time\":14},{\"num\":2,\"par\":4,\"hcp\":1,\"black\":407,\"white\":380,\"yellow\":355,\"blue\":355,\"red\":323,\"time\":14},{\"num\":3,\"par\":5,\"hcp\":5,\"black\":510,\"white\":481,\"yellow\":450,\"blue\":441,\"red\":414,\"time\":17},{\"num\":4,\"par\":4,\"hcp\":13,\"black\":415,\"white\":358,\"yellow\":343,\"blue\":331,\"red\":321,\"time\":14},{\"num\":5,\"par\":5,\"hcp\":9,\"black\":474,\"white\":463,\"yellow\":426,\"blue\":416,\"red\":366,\"time\":17},{\"num\":6,\"par\":3,\"hcp\":7,\"black\":191,\"white\":183,\"yellow\":144,\"blue\":129,\"red\":106,\"time\":11},{\"num\":7,\"par\":4,\"hcp\":3,\"black\":397,\"white\":370,\"yellow\":365,\"blue\":326,\"red\":268,\"time\":14},{\"num\":8,\"par\":3,\"hcp\":17,\"black\":141,\"white\":133,\"yellow\":118,\"blue\":112,\"red\":106,\"time\":11},{\"num\":9,\"par\":4,\"hcp\":15,\"black\":335,\"white\":335,\"yellow\":302,\"blue\":302,\"red\":240,\"time\":14},{\"num\":10,\"par\":4,\"hcp\":16,\"black\":369,\"white\":335,\"yellow\":335,\"blue\":302,\"red\":254,\"time\":14},{\"num\":11,\"par\":4,\"hcp\":2,\"black\":390,\"white\":354,\"yellow\":332,\"blue\":317,\"red\":278,\"time\":14},{\"num\":12,\"par\":3,\"hcp\":14,\"black\":133,\"white\":133,\"yellow\":111,\"blue\":111,\"red\":83,\"time\":11},{\"num\":13,\"par\":4,\"hcp\":4,\"black\":341,\"white\":312,\"yellow\":312,\"blue\":273,\"red\":217,\"time\":14},{\"num\":14,\"par\":4,\"hcp\":12,\"black\":373,\"white\":342,\"yellow\":342,\"blue\":303,\"red\":284,\"time\":14},{\"num\":15,\"par\":5,\"hcp\":10,\"black\":482,\"white\":447,\"yellow\":390,\"blue\":390,\"red\":319,\"time\":17},{\"num\":16,\"par\":3,\"hcp\":18,\"black\":133,\"white\":133,\"yellow\":114,\"blue\":114,\"red\":97,\"time\":11},{\"num\":17,\"par\":5,\"hcp\":6,\"black\":494,\"white\":474,\"yellow\":442,\"blue\":429,\"red\":410,\"time\":17},{\"num\":18,\"par\":4,\"hcp\":8,\"black\":365,\"white\":346,\"yellow\":334,\"blue\":319,\"red\":319,\"time\":14}]}"
    ,@"{\"name\":\"Golf De Seignosse\",\"url\":\"http://www.golfseignosse.com\",\"last_update\":\"2005-09-29\",\"par\":36,\"sss1M\":74.3,\"sss2M\":72.6,\"sss3M\":71.8,\"sss4M\":69.4,\"sss5M\":66.0,\"sss1F\":79.1,\"sss2F\":79.1,\"sss3F\":77.7,\"sss4F\":74.8,\"sss5F\":71.1,\"slope1M\":144,\"slope2M\":142,\"slope3M\":135,\"slope4M\":131,\"slope5M\":124,\"slope1F\":146,\"slope2F\":146,\"slope3F\":143,\"slope4F\":137,\"slope5F\":123,\"holes\":[{\"num\":1,\"par\":4,\"hcp\":5,\"black\":409,\"white\":374,\"yellow\":354,\"blue\":309,\"red\":263,\"time\":14},{\"num\":2,\"par\":4,\"hcp\":13,\"black\":298,\"white\":275,\"yellow\":275,\"blue\":251,\"red\":200,\"time\":14},{\"num\":3,\"par\":4,\"hcp\":1,\"black\":368,\"white\":350,\"yellow\":319,\"blue\":319,\"red\":284,\"time\":14},{\"num\":4,\"par\":5,\"hcp\":7,\"black\":444,\"white\":414,\"yellow\":414,\"blue\":394,\"red\":348,\"time\":17},{\"num\":5,\"par\":3,\"hcp\":17,\"black\":132,\"white\":132,\"yellow\":112,\"blue\":112,\"red\":86,\"time\":11},{\"num\":6,\"par\":4,\"hcp\":11,\"black\":354,\"white\":334,\"yellow\":320,\"blue\":295,\"red\":242,\"time\":14},{\"num\":7,\"par\":5,\"hcp\":3,\"black\":496,\"white\":465,\"yellow\":465,\"blue\":402,\"red\":382,\"time\":17},{\"num\":8,\"par\":3,\"hcp\":15,\"black\":122,\"white\":122,\"yellow\":106,\"blue\":99,\"red\":75,\"time\":11},{\"num\":9,\"par\":4,\"hcp\":9,\"black\":364,\"white\":316,\"yellow\":290,\"blue\":290,\"red\":234,\"time\":14},{\"num\":10,\"par\":4,\"hcp\":10,\"black\":315,\"white\":290,\"yellow\":290,\"blue\":237,\"red\":210,\"time\":14},{\"num\":11,\"par\":5,\"hcp\":6,\"black\":529,\"white\":502,\"yellow\":482,\"blue\":433,\"red\":397,\"time\":17},{\"num\":12,\"par\":3,\"hcp\":18,\"black\":117,\"white\":117,\"yellow\":101,\"blue\":91,\"red\":80,\"time\":11},{\"num\":13,\"par\":4,\"hcp\":2,\"black\":422,\"white\":418,\"yellow\":401,\"blue\":381,\"red\":347,\"time\":14},{\"num\":14,\"par\":4,\"hcp\":12,\"black\":328,\"white\":307,\"yellow\":307,\"blue\":269,\"red\":222,\"time\":14},{\"num\":15,\"par\":4,\"hcp\":16,\"black\":320,\"white\":306,\"yellow\":306,\"blue\":277,\"red\":245,\"time\":14},{\"num\":16,\"par\":3,\"hcp\":14,\"black\":185,\"white\":170,\"yellow\":170,\"blue\":159,\"red\":130,\"time\":11},{\"num\":17,\"par\":4,\"hcp\":8,\"black\":365,\"white\":353,\"yellow\":330,\"blue\":295,\"red\":244,\"time\":14},{\"num\":18,\"par\":5,\"hcp\":4,\"black\":561,\"white\":529,\"yellow\":511,\"blue\":457,\"red\":392,\"time\":17}]}"
    ];
    for(NSString *strJson in strJsons) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[strJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSString *name = [json objectForKey:@"name"];
        Course *course = [Course MR_findFirstByAttribute:@"name" withValue:name];
        if(! course) {
            Course *course = [Course MR_createEntity];
            course.name = name;
            course.par = [json objectForKey:@"par"];
            course.slope1M = [json objectForKey:@"slope1M"];
            course.slope2M = [json objectForKey:@"slope2M"];
            course.slope3M = [json objectForKey:@"slope3M"];
            course.slope4M = [json objectForKey:@"slope4M"];
            course.slope5M = [json objectForKey:@"slope5M"];
            course.sss1M = [json objectForKey:@"sss1M"];
            course.sss2M = [json objectForKey:@"sss2M"];
            course.sss3M = [json objectForKey:@"sss3M"];
            course.sss4M = [json objectForKey:@"sss4M"];
            course.sss5M = [json objectForKey:@"sss5M"];
            course.slope1F = [json objectForKey:@"slope1F"];
            course.slope2F = [json objectForKey:@"slope2F"];
            course.slope3F = [json objectForKey:@"slope3F"];
            course.slope4F = [json objectForKey:@"slope4F"];
            course.slope5F = [json objectForKey:@"slope5F"];
            course.sss1F = [json objectForKey:@"sss1F"];
            course.sss2F = [json objectForKey:@"sss2F"];
            course.sss3F = [json objectForKey:@"sss3F"];
            course.sss4F = [json objectForKey:@"sss4F"];
            course.sss5F = [json objectForKey:@"sss5F"];
            [course.managedObjectContext MR_saveToPersistentStoreAndWait];
            [course createHolesWithJsonArray:[json objectForKey:@"holes"]];
        } else {
            [course computePar];
        }
    }
    
    Course *course = [Course MR_findFirstByAttribute:@"name" withValue:@"Etioles"];
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
    self.gameButton.hidden = NO;
    self.oldGamesButton.hidden = NO;
    [self.indicator stopAnimating];
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
