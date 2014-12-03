//
//  WebViewController.m
//  Pokedesk
//
//  Created by Santiago Pavón on 20/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Poner nombre de la pokemon como titulo de la Navigation Bar
    self.title = self.race.name;
    
    // Cargar la URL del pokemon
    NSString *str = [NSString stringWithFormat:
                     @"http://es.pokemon.wikia.com/wiki/%@", self.race.name];
    
    // Escapar caracteres conflictivos
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}


@end
