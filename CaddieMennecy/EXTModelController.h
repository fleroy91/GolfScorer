//
//  EXTModelController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXTHoleDataViewController;

@interface EXTModelController : NSObject <UIPageViewControllerDataSource>

- (EXTHoleDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(EXTHoleDataViewController *)viewController;

@end
