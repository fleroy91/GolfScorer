//
//  Settings+addon.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 26/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Settings.h"
#import <FXForms.h>

@interface Settings (addon) <FXForm>

typedef NS_ENUM(NSInteger, SettingsDisplayKindType) {
    SettingsDisplayKindMeter,
    SettingsDisplayKindYard
};

-(NSUInteger)convertDistance:(NSUInteger)meters;
-(NSString *)getDistanceUnit;

@end
