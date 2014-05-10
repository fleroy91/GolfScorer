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

- (NSArray *)fields
{
    return @[
             @{FXFormFieldKey: @"hole_score", FXFormFieldHeader:@" ", FXFormFieldTitle: @"Score", FXFormFieldCell: [FXFormStepperCell class]},
             @{FXFormFieldKey: @"nb_putts", FXFormFieldTitle: @"Putts", FXFormFieldCell: [FXFormStepperCell class]},
             @{FXFormFieldKey: @"fairway", FXFormFieldTitle: @"Fairway",  FXFormFieldType: FXFormFieldTypeOption},
             @{FXFormFieldKey: @"gir", FXFormFieldTitle: @"Green en régulation",  FXFormFieldType: FXFormFieldTypeOption},
             @{FXFormFieldTitle: @"Valider et suivant", FXFormFieldHeader: @" ", @"contentView.backgroundColor": [UIColor redColor], FXFormFieldAction: @"submitHole:"}
             ];
}

@end
