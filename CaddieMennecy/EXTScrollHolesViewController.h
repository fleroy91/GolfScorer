//
//  EXTScrollHolesViewController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 03/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXTScrollHolesViewController : UIViewController
- (void)saveCurrentHoleWithHole:(Hole *)hole;
- (void)pageForward;
- (IBAction)homeMenu:(id)sender;

@end
