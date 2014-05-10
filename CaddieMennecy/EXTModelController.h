//
//  EXTModelController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXTHoleDataViewController;
@class Hole;

@interface EXTModelController : NSObject <UIPageViewControllerDataSource>

- (EXTHoleDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (void)pageForward:(UIPageViewController *)pageViewController;
- (void)saveCurrentHole:(UIPageViewController *)pageViewController;
- (void)saveCurrentHoleWithHole:(Hole *)hole;
@property PlayerGameHole *playerGameHole;

@end
