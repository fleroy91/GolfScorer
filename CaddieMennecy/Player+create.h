//
//  Player+create.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Player.h"
#import <AddressBookUI/AddressBookUI.h>

@interface Player (create)

+(Player *)createFromPerson:(ABRecordRef)person;

@end
