//
//  NuevosPokemonsTableViewController.m
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "NuevosPokemonsTableViewController.h"
#import "EditarViewController.h"
#import "PokedeskModel.h"
#import "NewPokemon.h"
#import "NewPokemonBook.h"
#import "PokemonNewCell.h"

@interface NuevosPokemonsTableViewController ()
@property (strong, nonatomic) IBOutlet PokedeskModel *PokedeskModel;
@property (nonatomic,strong) NewPokemonBook * NewPokemonBook;

@end

@implementation NuevosPokemonsTableViewController


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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    if (! self.NewPokemonBook) {
        self.NewPokemonBook = [[NewPokemonBook alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    return [self.NewPokemonBook.NewPokemon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"New Pokemon";
    PokemonNewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                           forIndexPath:indexPath];
    
    

    
    NewPokemon *pokemon = self.NewPokemonBook.NewPokemon[indexPath.row];
    cell.name.text = [NSString stringWithFormat:@"%@ ('%@')",pokemon.name, pokemon.race.name];
    cell.image.image = [UIImage imageNamed:pokemon.race.icon];

    
    return cell;
}



- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.NewPokemonBook.NewPokemon removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Editar"]) {
       EditarViewController *evc = segue.destinationViewController;
        
       NSIndexPath * ip = [self.tableView indexPathForSelectedRow];
        
       evc.NewPokemon = self.NewPokemonBook.NewPokemon[ip.row];
        
    } else if ([segue.identifier isEqualToString:@"Nuevo"]) {
        
     EditarViewController *evc = segue.destinationViewController;
        
        NSNumber  * codeinit = [[NSNumber alloc] initWithInt:0];
        
        NewPokemon * newPokemon = [[NewPokemon alloc] initWithName:@""
                                                              race: [[Race alloc] initWithCode: codeinit
                                                                                          name:@""
                                                                                          icon:@""]];
        [self.NewPokemonBook.NewPokemon insertObject:newPokemon atIndex:0];
        
        NSIndexPath * ip = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[ip]
                              withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tableView selectRowAtIndexPath:ip
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionTop];
        
      evc.NewPokemon = newPokemon;
    }
}

- (IBAction) contactWasChanged:(UIStoryboardSegue*)segue
{
    NSIndexPath * ip = [self.tableView indexPathForSelectedRow];
    
    [self.tableView reloadRowsAtIndexPaths:@[ip]
                          withRowAnimation:YES];
}


@end
