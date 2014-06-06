//
//  PlayerGameHole+form.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 10/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "PlayerGameHole+form.h"
#import <FXForms.h>

@implementation PlayerGameHole (form)

- (BOOL)isLastHole
{
    BOOL ret = (self.number.integerValue == [self.inPlayerGame.inGame getEndingHoleNumber]);
    return ret;
}

-(BOOL)isLastPlayer
{
    return (self.inPlayerGame.row.integerValue == [self.inPlayerGame.inGame.thePlayerGames count]);
}

- (BOOL)isLastHoleAndPlayer
{
    return ([self isLastHole] && [self isLastPlayer]);
}

- (void)saveScore
{
    self.is_saved = @YES;
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
    [self.inPlayerGame saveAndComputeScore];
}

-(NSString *)formatDistanceForColor:(NSUInteger)start_color
{
    return [self.forHole formatDistanceForColor:start_color];
}

- (NSArray *)fields
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    [ret addObject:@{FXFormFieldKey: @"hole_score", FXFormFieldTitle: @"Score", FXFormFieldCell: [FXFormStepperCell class]}];
    [ret addObject:@{FXFormFieldKey: @"nb_putts", FXFormFieldTitle: @"Putts", FXFormFieldCell: [FXFormStepperCell class]}];
    if(self.forHole.par.integerValue > 3) {
        [ret addObject:@{FXFormFieldKey: @"fairway", FXFormFieldTitle: @"Fairway",  FXFormFieldType: FXFormFieldTypeOption}];
    }/*
      else {
        [ret addObject:@{FXFormFieldTitle: @" ", FXFormFieldAction: @"doNothing:"}];
    }*/
    [ret addObject:@{FXFormFieldKey: @"gir", FXFormFieldTitle: @"Green en régulation",  FXFormFieldType: FXFormFieldTypeOption}];
//    [ret addObject:@{FXFormFieldTitle: @" ", FXFormFieldAction: @"doNothing:"}];
    return ret;
}

@end
