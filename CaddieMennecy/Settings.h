//
//  Settings.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 04/07/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Settings : NSManagedObject

@property (nonatomic, retain) NSNumber * displayKind;
@property (nonatomic, retain) NSNumber * useGPS;

@end
