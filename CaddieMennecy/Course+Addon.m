//
//  Course+Addon.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 09/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Course+Addon.h"

@implementation Course (Addon)
-(void)createHoles:(NSArray *)holesData
{
    for(NSArray *holeData in holesData){
        [[Hole MR_createEntity] initWithArray:holeData andCourse:self];
    }
}

-(void)createHolesWithJsonArray:(NSArray *)holesData
{
    for(NSDictionary *holeData in holesData){
        [[Hole MR_createEntity] initWithDictionnary:holeData andCourse:self];
    }
    
}

@end
