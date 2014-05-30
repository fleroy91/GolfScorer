//
//  Settings+addon.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 26/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Settings+addon.h"

@implementation Settings (addon)

+ (NSArray *)displayOptions
{
    return @[@"Mètres", @"Yards"];
}

- (NSArray *)fields
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    [ret addObject:@{FXFormFieldKey: @"displayKind", FXFormFieldTitle: @"Affichage", FXFormFieldHeader:@" ", FXFormFieldOptions: [Settings displayOptions]}];
    [ret addObject:@{FXFormFieldKey: @"useGPS", FXFormFieldTitle: @"Me localiser avec le GPS", FXFormFieldType: FXFormFieldTypeBoolean}];
    return ret;
}

-(NSUInteger)convertDistance:(NSUInteger)meters
{
    if(self.displayKind == SettingsDisplayKindMeter) {
        return meters;
    } else {
        return (NSUInteger)((double)meters / 1.0936133);
    }
}

-(NSString *)getDistanceUnit
{
    return (self.displayKind == SettingsDisplayKindMeter ? @"m" : @"y");
}

@end
