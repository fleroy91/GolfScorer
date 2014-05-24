//
//  EXTPlayersViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 29/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTPlayersViewController.h"
#import "EXTPlayerNavController.h"
#import "EXTPlayerViewController.h"
#import "Game+init.h"
#import "Player+create.h"
#import "PlayerGame.h"
#import "SWTableViewCell.h"

@interface EXTPlayersViewController ()
- (IBAction)showPicker:(id)sender;
- (void)createPlayerFromPerson:(ABRecordRef)person;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAddPlayer;
@property UIBarButtonItem *editBarButtonItem;
@property UIBarButtonItem *addBarButtonItem;
@property NSArray *players;

@end

@implementation EXTPlayersViewController

- (void)createPlayerFromPerson:(ABRecordRef)person
{
    Player * player = [Player createFromPerson:person];
    [self editPlayer:player withIsNew:YES];
}

- (void)editPlayer:(Player *)player withIsNew:(BOOL)isNew
{
    EXTPlayerNavController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayerNavController"];
    EXTPlayerViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayerViewController"];
    [vc addChildViewController:pv];
    pv.player = player;
    pv.isNewObject = isNew;
    vc.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
-(BOOL)shouldAutorotate
{
    return NO;
}
- (BOOL)prefersStatusBarHidden {return YES;}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (IBAction)addPlayerFromButton:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Créer un nouveau joueur"
                                                             delegate:self
                                                    cancelButtonTitle:@"Annuler"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Nouveau joueur", @"Choisir parmi les contacts", nil];
    [actionSheet showInView:self.tableView];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(enterEditMode:)];
    self.addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPlayerFromButton:)];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:self.addBarButtonItem, nil];
    self.players = [Player MR_findAllSortedBy:@"lastname" ascending:YES];

    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.players = [Player MR_findAllSortedBy:@"lastname" ascending:YES];
    [self.tableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // TODO : do not compare with strings
    if(buttonIndex == 0) {
        // We need to show a new player form
        Player *player = [Player MR_createEntity];
        [self editPlayer:player withIsNew:YES];
    } else if(buttonIndex == 1) {
        ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:^(void){ NSLog(@" Dismiss"); }];
}

// Called after a person has been selected by the user.
// Return YES if you want the person to be displayed.
// Return NO  to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self createPlayerFromPerson:person];
    }];
    return NO;
}

// Called after a value has been selected by the user.
// Return YES if you want default action to be performed.
// Return NO to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (IBAction)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:^(void){
        NSLog(@"Done");
    }];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return [self.players count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    Player *player = [self.players objectAtIndex:indexPath.row];
    PlayerGame *pg = [currentGame findPlayerGameForPlayer:player];
    if(pg) {
        [currentGame removePlayerFromGame:player];
    } else {
        [currentGame addPlayerInGame:player];
    }
    [self updateCell:cell withPlayer:player];
    if([currentGame.thePlayerGames count] > 1) {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%d joueurs", [currentGame.thePlayerGames count]]];
    } else {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%d joueur", [currentGame.thePlayerGames count]]];
    }
    [tableView reloadData];
    
}
-(void)updateCell:(UITableViewCell *)cell withPlayer:(Player *)player
{
    PlayerGame *pg = [currentGame findPlayerGameForPlayer:player];
    if(pg) {
        [cell.backgroundView setBackgroundColor:[UIColor cyanColor]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Joueur %@", pg.row];
    } else {
        [cell.backgroundView setBackgroundColor:[UIColor whiteColor]];
        cell.detailTextLabel.text = nil;
    }
    cell.textLabel.text = [player description];
    [cell setSelected:NO animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"player";
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = UIColorFromRGB(0xebebeb);
    cell.backgroundColor = [UIColor clearColor];

    // Configure the cell...
    Player *player = [self.players objectAtIndex:indexPath.row];
    [self updateCell:cell withPlayer:player];
    if([currentGame.thePlayerGames count] > 1) {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%d joueurs", [currentGame.thePlayerGames count]]];
    } else {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"%d joueur", [currentGame.thePlayerGames count]]];
    }
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
            Player *player = [self.players objectAtIndex:cellIndexPath.row];
            [self editPlayer:player withIsNew:NO];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            Player *player = [self.players objectAtIndex:cellIndexPath.row];
            [currentGame removePlayerFromGame:player];
            NSManagedObjectContext *context = player.managedObjectContext;
            [player MR_deleteEntity];
            [context MR_saveToPersistentStoreAndWait];
            self.players = [Player MR_findAllSortedBy:@"lastname" ascending:YES];
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
    return NO;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
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
