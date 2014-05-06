//
//  EXTModelController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTModelController.h"
#import "Hole.h"
#import "EXTHoleDataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface EXTModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation EXTModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        _pageData = [[NSArray alloc] init];
        NSArray *holesData = @[@[@1, @4, @6, @375, @363, @327, @315],
                               @[@2, @4, @2, @375, @363, @327, @315],
                               @[@3, @4, @5, @375, @363, @327, @315],
                               @[@4, @3, @16, @375, @363, @327, @315],
                               @[@5, @4, @17, @375, @363, @327, @315],
                               @[@6, @5, @13, @375, @363, @327, @315],
                               @[@7, @4, @8, @375, @363, @327, @315],
                               @[@8, @3, @18, @375, @363, @327, @315],
                               @[@9, @4, @9, @375, @363, @327, @315],
                               @[@10, @4, @15, @375, @363, @327, @315],
                               @[@11, @4, @14, @375, @363, @327, @315],
                               @[@12, @5, @5, @375, @363, @327, @315],
                               @[@13, @3, @11, @375, @363, @327, @315],
                               @[@14, @4, @4, @375, @363, @327, @315],
                               @[@15, @4, @10, @375, @363, @327, @315],
                               @[@16, @5, @12, @375, @363, @327, @315],
                               @[@17, @3, @7, @375, @363, @327, @315],
                               @[@18, @4, @1, @375, @363, @327, @315]];
        for(int i=0; i < [holesData count]; i++){
            NSArray *holeData = holesData[i];
            Hole *hole = [[Hole alloc] initWithArray:holeData];
        }
                               
    }
    return self;
}

- (EXTHoleDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    EXTHoleDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"EXTHoleViewController"];
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(EXTHoleDataViewController *)viewController
{   
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(EXTHoleDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(EXTHoleDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
