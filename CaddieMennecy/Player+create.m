//
//  Player+create.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Player+create.h"
#import "EXTGlobal.h"

@implementation Player (create)

+(Player *)createFromPerson:(ABRecordRef)person
{
    Player *player = [Player MR_createEntity];
    player.lastname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    player.firstname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    player.surname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
    // TODO for note
    // NSString * note = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
    player.index = [NSNumber numberWithFloat:23.4];
    player.game = currentGame;
    
    return player;
}

@end
