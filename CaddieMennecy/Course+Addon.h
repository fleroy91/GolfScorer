//
//  Course+Addon.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 09/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Course.h"

@interface Course (Addon)
-(void)createHoles:(NSArray *)holesData;
-(void)createHolesWithJsonArray:(NSArray *)holesData;
@end
