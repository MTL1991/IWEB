//
//  ElegirRazaViewController.m
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "ElegirRazaViewController.h"
#import "PokedeskModel.h"
#import "Race.h"
#import "Type.h"
#import "PokemonCVCell.h"

@interface ElegirRazaViewController ()

@property (nonatomic,strong) PokedeskModel* pokedeskModel;
@end

@implementation ElegirRazaViewController

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
    
    self.pokedeskModel = [[PokedeskModel alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View Data Source

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.pokedeskModel.types count];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView
      numberOfItemsInSection:(NSInteger)section
{
    Type * type = self.pokedeskModel.types[section];
    return [type.races count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"PokemonCell";
    
    PokemonCVCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                     forIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    
    Type * type = self.pokedeskModel.types[section];
    Race * race = type.races[item];
    
    cell.nameLabel.text = race.name;
    cell.iconImageView.image = [UIImage imageNamed:race.icon];
    
    
    return cell;
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"Raza"]){
        
        NSIndexPath * ip = [self.collectionView indexPathForCell:sender];
        
        Type * type = self.pokedeskModel.types[ip.section];
        
        
        self.raceNewPokemon = type.races[ip.item];
        
    }
    
}






@end