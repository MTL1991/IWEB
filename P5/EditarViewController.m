//
//  EditarViewController.m
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "EditarViewController.h"
#import "PokedeskModel.h"
#import "NewPokemon.h"
#import "NewPokemonBook.h"
#import "PokemonNewCell.h"
#import "ElegirRazaViewController.h"

@interface EditarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *raceLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic,strong) Race* raceNewPokemon;
@end

@implementation EditarViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.nameTextField.text = self.NewPokemon.name;
    self.raceLabel.text = self.NewPokemon.race.name;
    self.raceNewPokemon = self.NewPokemon.race;
    [self.nameTextField becomeFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self.nameTextField becomeFirstResponder];
            break;
        case 1:
            [self.button becomeFirstResponder];
            break;
        default:
            break;
    }
}
- (IBAction)returnPressed:(UITextField *)sender {
    [self.button becomeFirstResponder];
    
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Hecho"]) {
        self.NewPokemon.name = self.nameTextField.text;
        self.NewPokemon.race.name = self.raceLabel.text;
        self.NewPokemon.race = self.raceNewPokemon;
        
        
    }if([segue.identifier isEqualToString:@"Elegir"]){
        
        ElegirRazaViewController* ervc = segue.destinationViewController;
        
        ervc.raceNewPokemon = self.raceNewPokemon;
        
        
        
        
        
    }
    
    
    
}

-(IBAction)updatePokemon:(UIStoryboardSegue*)segue
{
    if([segue.identifier isEqualToString:@"Raza"]){
        
        ElegirRazaViewController* ervc = segue.sourceViewController;
        
        self.raceNewPokemon = ervc.raceNewPokemon;
        
        self.raceLabel.text = self.raceNewPokemon.name;
        
        
        
    }
    
}


@end
