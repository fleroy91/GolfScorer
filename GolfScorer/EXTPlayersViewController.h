//
//  EXTPlayersViewController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 29/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Game+init.h"

@interface EXTPlayersViewController : UITableViewController
<ABPeoplePickerNavigationControllerDelegate, UIActionSheetDelegate>

- (void)editPlayer:(Player *)player withIsNew:(BOOL)isNew;

@end
