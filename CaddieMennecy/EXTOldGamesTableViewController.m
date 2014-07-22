//
//  EXTOldGamesTableViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTOldGamesTableViewController.h"
#import <CoreData/NSFetchRequest.h>
#import <CoreData/NSManagedObjectContext.h>
#import "EXTGlobal.h"
#import "EXTResultGameViewController.h"

@interface EXTOldGamesTableViewController ()
@property NSArray* games;
@end

@implementation EXTOldGamesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadGames
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"is_over = YES"];
    self.games = [Game MR_findAllSortedBy:@"when" ascending:NO withPredicate:predicate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadGames];

    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OldGame";
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    Game * game = self.games[indexPath.row];
    cell.textLabel.text = [game description];
    cell.detailTextLabel.text = [game getPlayersNames];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = UIColorFromRGB(0xebebeb);
    [[UITableViewCell appearance] setTintColor:[UIColor whiteColor]];
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0] title:@"Editer"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                title:@"Supprimer"];
    
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    switch (index) {
        case 0:
        {
            NSLog(@"Edit button was pressed");
            currentGame = [self.games objectAtIndex:cellIndexPath.row];
            [self performSegueWithIdentifier:@"editGame" sender: self];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            Game * game = self.games[cellIndexPath.row];
            [game MR_deleteEntity];
            [self loadGames];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        default:
            break;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)prefersStatusBarHidden {return YES;}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showGameResult" sender: self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showGameResult"] ){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Game * game = self.games[indexPath.row];
        EXTResultGameViewController *vc = (EXTResultGameViewController *)[segue destinationViewController];
        vc.game = game;
    } 
}

@end
