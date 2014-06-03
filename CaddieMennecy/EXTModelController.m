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
@property (strong, nonatomic) NSMutableArray *holes;
@property BOOL moveInProgress;
@end

@implementation EXTModelController

- (id)init
{
    self = [super init];
    if (self) {
        // We need to create all the PlayerGameHoles for the currentGame
        // TODO : Manage the course !!!!
        _holes = [[NSMutableArray alloc] init];
        int nbHolesAdded = 0;
        self.startingPageIndex = -1;
        NSUInteger number = [currentGame getStartingHoleNumber];
        while (nbHolesAdded < [currentGame getNbHolesPlayed]) {
            for(Hole *h in currentGame.forCourse.theHoles) {
                if(h.number.integerValue == number) {
                    [_holes addObject:h];
                    if(self.startingPageIndex < 0) {
                        // We need to find the first PGH not saved and show it
                        NSMutableArray *pghs = [self findPlayerGameHolesForHole:h];
                        for(PlayerGameHole *pgh in pghs) {
                            if(! pgh.is_saved.boolValue) {
                                self.startingPageIndex = nbHolesAdded;
                            }
                        }
                    }
                    break;
                }
            }
            nbHolesAdded ++;
            number ++;
            if(number > 18) {
                number = 1;
            }
        }
        NSLog(@"Nb holes in game : %d", [_holes count]);
        if(self.startingPageIndex == -1) {
            self.startingPageIndex = nbHolesAdded - 1;
        }
    }
    return self;
}

- (EXTHoleDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.holes count] == 0) || (index >= [self.holes count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    EXTHoleDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"EXTHoleDataViewController"];
    dataViewController.hole = self.holes[index];
    dataViewController.playerGameHoles = [self findPlayerGameHolesForHole:self.holes[index]];
    dataViewController.pageIndex = index;
    dataViewController.modelController = self;
    return dataViewController;
}

-(NSMutableArray *)findPlayerGameHolesForHole:(Hole *)hole
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for(PlayerGame *pg in currentGame.thePlayerGames) {
        for(PlayerGameHole *pgh in pg.thePlayerGameHoles) {
            assert(pgh.forHole);
            if(pgh.number.integerValue == hole.number.integerValue) {
                [ret addObject:pgh];
            }
        }
    }
    return ret;
}

- (void)saveCurrentHole:(UIPageViewController *)pageViewController {
    EXTHoleDataViewController *theCurrentViewController = [pageViewController.viewControllers objectAtIndex:0];
    Hole * hole = self.holes[theCurrentViewController.pageIndex];
    [self saveCurrentHoleWithHole:hole];
}
- (void)saveCurrentHoleWithHole:(Hole *)hole
{
    self.playerGameHole.is_saved = @YES;
    [self.playerGameHole.managedObjectContext MR_saveToPersistentStoreAndWait];
    [self.playerGameHole.inPlayerGame saveAndComputeScoreUntil:hole];
}
/*
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [currentGame getNbHolesPlayed];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    EXTHoleDataViewController *theCurrentViewController = [pageViewController.viewControllers objectAtIndex:0];
    return theCurrentViewController.pageIndex;
}
*/
#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EXTHoleDataViewController *) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound) || self.moveInProgress) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EXTHoleDataViewController *) viewController).pageIndex;
    if (index == NSNotFound || self.moveInProgress) {
        return nil;
    }
    
    index++;
    if (index == [self.holes count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (void)pageForward:(UIPageViewController *)pageViewController
{
    //get current index of current page
    EXTHoleDataViewController *theCurrentViewController = [pageViewController.viewControllers objectAtIndex:0];
    NSUInteger retreivedIndex = ((EXTHoleDataViewController *) theCurrentViewController).pageIndex;
    
    //check that current page isn't last page
    if (retreivedIndex < [self.holes count] - 1){
        
        //get the page to go to
        EXTHoleDataViewController *targetPageViewController = [self viewControllerAtIndex:(retreivedIndex + 1) storyboard:theCurrentViewController.storyboard];
        self.moveInProgress = YES;
        
        //add page view
        [pageViewController setViewControllers:@[targetPageViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            if(finished) {
                self.moveInProgress = NO;
            }
        }];
        
    }
    
}
- (void)pageBackward:(UIPageViewController *)pageViewController
{
    //get current index of current page
    EXTHoleDataViewController *theCurrentViewController = [pageViewController.viewControllers objectAtIndex:0];
    NSUInteger retreivedIndex = ((EXTHoleDataViewController *) theCurrentViewController).pageIndex;
    
    //check that current page isn't first page
    if (retreivedIndex > 0){
        
        //get the page to go to
        EXTHoleDataViewController *targetPageViewController = [self viewControllerAtIndex:(retreivedIndex - 1) storyboard:theCurrentViewController.storyboard];
        self.moveInProgress = YES;
        //add page view
        [pageViewController setViewControllers:@[targetPageViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            if(finished) {
                self.moveInProgress = NO;
            }
        }];
        
    }
    
}
@end
