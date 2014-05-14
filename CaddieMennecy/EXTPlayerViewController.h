//
//  EXTPlayerViewController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 13/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "FXForms.h"

@interface EXTPlayerViewController : UITableViewController <FXFormControllerDelegate>

@property Player *player;
@property BOOL isNewObject;

@end
