//
//  EXTPlayersViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 29/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTPlayersViewController.h"
#import "EXTPlayerViewController.h"
#import "Game+init.h"
#import "Player+create.h"
#import "PlayerGame.h"

@interface EXTPlayersViewController ()
- (IBAction)addPlayerFromButton:(id)sender;
- (void)createPlayerFromPerson:(ABRecordRef)person;
- (IBAction)enterEditMode:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAddPlayer;

@end

@implementation EXTPlayersViewController

- (void)createPlayerFromPerson:(ABRecordRef)person
{
    Player * player = [Player createFromPerson:person];
    // We need to display the form
    [self editPlayer:player withIsNew:YES];
}

- (void)editPlayer:(Player *)player withIsNew:(BOOL)isNew
{
    EXTPlayerViewController *vc = [[EXTPlayerViewController alloc] init];
    vc.player = player;
    vc.isNewObject = isNew;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)enterEditMode:(id)sender {
    
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

- (IBAction)addPlayerFromButton:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Créer un nouveau joueur"
                                                             delegate:self
                                                    cancelButtonTitle:@"Annuler"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Nouveau joueur", @"Choisir parmi les contacts", nil];
    [actionSheet showFromBarButtonItem:self.btnAddPlayer animated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    // TODO : do not compare with strings
    if([buttonTitle isEqualToString:@"Annuler"]) {
        // We do nothing
    } else if([buttonTitle isEqualToString:@"Nouveau Joueur"]) {
        // We need to show a new player form
        Player *player = [Player MR_createEntity];
        [self editPlayer:player withIsNew:YES];
    } else {
        ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return [currentGame.thePlayerGames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerGame *playerGame = [currentGame.thePlayerGames objectAtIndex:indexPath.row];
    Player *player = [playerGame forPlayer];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"player" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", player.lastname, player.firstname];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", player.index.doubleValue];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
