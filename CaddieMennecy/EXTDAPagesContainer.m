//
//  EXTDAPagesContainer.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 03/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTDAPagesContainer.h"
#import "EXTHoleDataViewController.h"

@interface EXTDAPagesContainer ()

@end

@implementation EXTDAPagesContainer
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
    // We need to save the current hole
    if(selectedIndex > self.selectedIndex) {
        EXTHoleDataViewController *currentVc = (EXTHoleDataViewController *)self.viewControllers[self.selectedIndex];
        [currentVc saveHole];
    }
    
    // And refresh the next page
    EXTHoleDataViewController *nextVc = (EXTHoleDataViewController *)self.viewControllers[selectedIndex];
    [nextVc viewWillAppear:animated];
    [super setSelectedIndex:selectedIndex animated:animated];
}

@end
