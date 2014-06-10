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
    player.start_color = @2;
    player.gender = @0;
    // TODO for note
    // NSString * note = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
    player.index = [NSNumber numberWithFloat:23.4];
    [player.managedObjectContext MR_saveToPersistentStoreAndWait];
    return player;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.firstname, self.lastname];
}
-(NSArray *)fields
{
    return @[
             @{FXFormFieldKey: @"lastname", FXFormFieldTitle: @"Nom", FXFormFieldHeader:@" "},
             @{FXFormFieldKey: @"firstname", FXFormFieldTitle: @"Prénom"},
             @{FXFormFieldKey: @"is_default", FXFormFieldTitle: @"Joueur principal", FXFormFieldType: FXFormFieldTypeBoolean},
             @{FXFormFieldKey: @"index", FXFormFieldTitle: @"Index", FXFormFieldType: FXFormFieldTypeNumber},
             @{FXFormFieldKey: @"gender", FXFormFieldTitle: @"Sexe", FXFormFieldOptions: @[@"Homme", @"Femme"]},
             @{FXFormFieldKey: @"start_color", FXFormFieldTitle: @"Départ", FXFormFieldOptions: @[@"Noir", @"Blanc", @"Jaune", @"Bleu", @"Rouge"]}
             ];
}

@end
