//
//  EXTPlayerViewController.m
//  GolfScorer
//
//  Created by Frédéric Leroy on 12/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTPlayerViewController.h"

@interface EXTPlayerViewController ()
- (IBAction)doCancel:(id)sender;
- (IBAction)doOK:(id)sender;
@end

@implementation EXTPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        //set up form
        self.formController.form = self.player;
    }
    return self;
}


- (IBAction)doCancel:(id)sender {
    if(self.isNewObject) {
        // We need to delete it
        [self.player MR_deleteEntity];
        self.player = nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doOK:(id)sender {
    if(self.isNewObject) {
        // We need to create a player Game for the current Game
        PlayerGame *pgh = [PlayerGame MR_createEntity];
        pgh.forPlayer = self.player;
        pgh.row = [NSNumber numberWithUnsignedInt:[currentGame.thePlayerGames count] + 1];
        pgh.inGame = currentGame;
        [pgh.managedObjectContext MR_saveToPersistentStoreAndWait];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
