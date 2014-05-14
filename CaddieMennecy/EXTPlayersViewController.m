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

@interface EXTPlayersViewController ()
- (IBAction)showPicker:(id)sender;
- (void)createPlayerFromPerson:(ABRecordRef)person;
- (IBAction)enterEditMode:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAddPlayer;
@property UIBarButtonItem *editBarButtonItem;
@property UIBarButtonItem *addBarButtonItem;
@property NSArray *players;

@end

@implementation EXTPlayersViewController

- (void)createPlayerFromPerson:(ABRecordRef)person
{
    Player * player = [Player createFromPerson:person];
    /*
    PlayerGame *playerGame = [PlayerGame MR_createEntity];
    playerGame.forPlayer = player;
    playerGame.row = [NSNumber numberWithInteger:[currentGame.thePlayerGames count] + 1];
    playerGame.inGame = currentGame;
    [playerGame.managedObjectContext MR_saveToPersistentStoreAndWait];
     */
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

- (IBAction)enterEditMode:(id)sender {
    if([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.editBarButtonItem setTitle:@"Editer"];
    } else {
        [self.editBarButtonItem setTitle:@"Done"];
        [self.addBarButtonItem setEnabled:NO];
        [self.tableView setEditing:YES animated:YES];
    }
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
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:self.addBarButtonItem, self.editBarButtonItem, nil];
    self.players = [Player MR_findAllSortedBy:@"lastname" ascending:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [self createPlayerFromPerson:person];
    [self dismissViewControllerAnimated:YES completion:^(void){ NSLog(@" Dismiss"); }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Player *player = [self.players objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"player" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [player description];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", player.index.doubleValue];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Player *player = [self.players objectAtIndex:indexPath.row];
        NSManagedObjectContext *context = player.managedObjectContext;
        [player MR_deleteEntity];
        [context MR_saveToPersistentStoreAndWait];
        self.players = [Player MR_findAllSortedBy:@"lastname" ascending:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
