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
    [ret addObject:@{FXFormFieldTitle: @" ", FXFormFieldAction: @"doNothing:"}];
    if([self isLastHole] && [self isLastPlayer]) {
        [ret addObject:@{FXFormFieldTitle: @"Terminer la partie", @"contentView.backgroundColor": [UIColor redColor], FXFormFieldAction: @"endGame:"}];
    } else {
        [ret addObject:@{FXFormFieldTitle: @"Valider et suivant", @"contentView.backgroundColor": [UIColor greenColor], FXFormFieldAction: @"submitHole:"}];
    }
    return ret;
}

@end
