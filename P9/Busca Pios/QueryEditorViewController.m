//
//  QueryEditorViewController.m
//  Busca Pios
//
//  Created by Santiago Pavón on 16/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "QueryEditorViewController.h"

@interface QueryEditorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *queryTextField;

@end

@implementation QueryEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.queryTextField.text = self.query;
    
    [self.queryTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender {
    
    [self performSegueWithIdentifier:@"Edit Done" sender:self];
}


#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Edit Cancel"]) {
        
        self.query = nil;
        
    } else if ([segue.identifier isEqualToString:@"Edit Done"]) {
        
        self.query = self.queryTextField.text;
        
    }
}

@end
