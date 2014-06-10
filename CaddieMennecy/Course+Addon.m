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
        // We try to search for the hole in the DB
        Hole *hole = [[Hole MR_createEntity] initWithArray:holeData andCourse:self];
        NSManagedObjectContext* context = hole.managedObjectContext;
        [context MR_saveToPersistentStoreAndWait];
    }
}
@end
