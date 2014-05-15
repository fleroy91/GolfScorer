//
//  EXTPlayerViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 13/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTPlayerViewController.h"

@interface EXTPlayerViewController ()
- (IBAction)doCancel:(id)sender;
- (IBAction)doOK:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) FXFormController *formController;
@end

@implementation EXTPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.tableView;
    self.formController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    assert(self.player);
    if(self.isNewObject) {
        [self.navItem setTitle:@"Nouveau joueur"];
    } else {
        [self.navItem setTitle:[self.player description]];
    }
    self.formController.form = self.player;
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doCancel:(id)sender {
    if(self.isNewObject) {
        // We need to delete it
        [self.player MR_deleteEntity];
        self.player = nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doOK:(id)sender {
    if(self.isNewObject) {
        [self.player.managedObjectContext MR_saveToPersistentStoreAndWait];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
