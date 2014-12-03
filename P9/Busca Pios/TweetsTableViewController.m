//
//  TweetsTableViewController.m
//  Busca Pios
//
//  Created by Santiago Pavón on 16/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "QueryTableViewCell.h"
#import "Tweet.h"


// ==========================================================
//                   VERSION SIN GCD
// ==========================================================
// La version sin GCD no responde con suavidad a los gestos del usuario.
// Se bloquea cuando intenta obtener el token de acceso, los datos JDON y
// las imagenes de los usuarios.
//
// ==========================================================
//                   VERSION CON GCD
// ==========================================================
// La version con GCD si responde con suavidad a los gestos del usuario.
// Usa GCD para enviar a otros threads las operaciones bloqueantes.
//
// ==========================================================
// Practica 10:
//   Este fichero contiene la version sin CGD.
//   En las sesiones de laboratorio lo modificaremos para hacer uso
//   de la facilidades proporcionadas por GCD.
// ==========================================================

#define TWITTER_SEARCH_URL @"https://api.twitter.com/1.1/search/tweets.json"

// Clave y password de acceso de la aplicacion a Twitter.
//
// El alumno debe dar de alta una nueva aplicacion en twitter e introducir en
// estos defines los valores de su aplicacion.
//
// Para obtener estos valores hay que dar de alta una aplicacion en Twitter.
// - Conectarse a https://dev.twitter.com
// - Pulsar "Sign in" para entrar en su cuenta de usuario.
//    o Meter el Username y el Password.
// - Desplegar el menu asociado a la foto del perfil  y seleccionar "My Applications".
// - Pulsar el boton "Create a new apllication".
//    o Rellenar los campos del formulario: Name, Description y Web Site.
//    o Leerse y aceptar las "Rules of the Road".
//    o Escribir el Captcha
//    o Pulsar el boton "Create your Twitter application".
// - Y nos sale una pagina con la Consumer Key y la Consumer Secret que debe
//   utilizar la aplicacion que acabamos de crear.
//
#define CONSUMER_KEY     @"PVNNrjpA5W3vazrECZOmA"
#define CONSUMER_SECRET  @"4G4sc7mdurijcy3Iv3tgmlsZ4wm0WX1H4vdsE8TVdk"


// Token de acceso devuelto por el servicio Twitter para que podamos acceder a su API.
// Lo almacenamos en una variable estatica para conservar su valor durante toda la ejecucion
// de la aplicacion. Asi solo debe obtenerse este valor una sola vez.
static  NSString* access_token;


@interface TweetsTableViewController ()

/**
 *  Los tweets encontrados tras la busqueda.
 *  Es un array de objetos Tweet.
 */
@property (strong) NSMutableArray * tweets;

/**
 *  Almacen de profile images.
 *  La clave es un NSString con el URL, y el valor es un objeto UIImage.
 */
@property (strong) NSCache * images;

@property (assign) int contadorPitorros;

@end


@implementation TweetsTableViewController


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.tweets = [NSMutableArray array];
    self.images = [[NSCache alloc] init];
    
    [self getAccessToken];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Get Access Token

/**
 *  Obtiene el token de acceso que hay que usar para acceder al API de busquedas.
 *
 *  La peticion HTTP:
 *     - URL = https://api.twitter.com/oauth2/token
 *     - metodo = POST
 *     - cabecera = Authorization: Basic $Base64BearerToken
 *     - cabecera = Content-Type: application/x-www-form-urlencoded;charset=UTF-8
 *     - body = grant_type=client_credentials
 *
 *  La respuesta HTTP:
 *     - Si hay exito:
 *           { "access_token":"el_valor_del_token","token_type":"bearer"}
 *     - Si hay errores:
 *           {"errors":[{"label":"authenticity_token_error","code":99,"message":"Unable to verify your credentials"}]}
 *           {"errors":[{"message":"Bad Authentication data","code":215}]}
 *           u otros ...
 */
- (void) getAccessToken
{
    if (access_token) {
        [self getTweets];
        return;
    }
    
    NSLog(@"Obteniendo el token de acceso.");
    
    self.title = @"Autenticando ...";
    [self incrNetActivity];
    
    dispatch_queue_t queue = dispatch_queue_create("cola out", NULL);
    
    dispatch_async(queue, ^{
    
    NSString * bearer_token = [NSString stringWithFormat:@"%@:%@",
                               [CONSUMER_KEY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [CONSUMER_SECRET stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
    NSString *base64_bearer_token = [[bearer_token dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
        
    // NSLog(@"Base64 token = %@", base64_bearer_token);
    
    NSString * body = @"grant_type=client_credentials";
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/oauth2/token"];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    [req setHTTPMethod:@"POST"];
    
    [req addValue:[NSString stringWithFormat:@"Basic %@",base64_bearer_token] forHTTPHeaderField:@"Authorization"];
    
    [req addValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *length = [NSString stringWithFormat:@"%d", [body length]];
    [req addValue:length forHTTPHeaderField:@"Content-Length"];
    
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse * responseHTTP = nil;
    NSError * error = nil;
    NSData * jsonData = [NSURLConnection sendSynchronousRequest:req
                                              returningResponse:&responseHTTP
                                                          error:&error];
    sleep (5);
    if (jsonData) {
        NSInteger statusCode = [responseHTTP statusCode];
        if ( statusCode == 200 ) {
            NSError * err;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:0
                                                                error:&err];
            access_token = dic[@"access_token"];
        }
    }
        dispatch_async(dispatch_get_main_queue(), ^{
    [self decrNetActivity];
            
    if (access_token) {
        [self getTweets];
    } else {
        // No pudo realizarse la conexion o la descarga fallo.
      
    self.title = @"Error descargando Tweets";
    }
        });
    
});
}


#pragma mark - Search tweets

/**
 *  Obtiene todos los tweet que encajan con el string buscado (self.query).
 *
 *  Los tweets encontrados se dividen en paginas que hay que descargarse una a una.
 *
 *  Los tweets encontradose almacenan en self.tweets.
 */
- (void) getTweets {
    
    self.title = @"Downloading ...";
    [self incrNetActivity];
    
    dispatch_queue_t queue = dispatch_queue_create("baja pios", NULL);
    
    dispatch_async(queue, ^{
    // Construye la query que hay que añadir a la URL.
    // Con esta query solo se baja la primera pagina de tweets.
    __block NSString * current_query = [[NSString stringWithFormat:@"?q=%@",self.query] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    while ( current_query ) {
        
        // Construimos la URL añadiendo la query
        NSString * pageURL = [NSString stringWithFormat:@"%@%@",TWITTER_SEARCH_URL,current_query];
        
        // Descargamos un JSON con los datos.
        NSData * data = [self downloadJSONDataPage:pageURL];
        
        // Procesamos el JSON recibido.
        // Nos devuelven una nueva query para descargar mas tweets de nuestra busqueda
        current_query = [self addJSONData:data];
    }
        dispatch_async(dispatch_get_main_queue(), ^{
    
            [self decrNetActivity];
            self.title = self.query;
        });
        
    });
}

/**
 *  Descarga un JSON.
 *  
 *  @param strURL La URL desde la que descargaremos el JSON.
 *
 *  @returns Un NSData conteniendo un JSON.
 */
- (NSData*) downloadJSONDataPage:(NSString*)strURL {
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    // Añadimos la cabecera de autenticacion necesaria para acceder al API de busquedas de Twitter.
    [req addValue:[NSString stringWithFormat:@"Bearer %@",access_token] forHTTPHeaderField:@"Authorization"];
    
    NSHTTPURLResponse * responseHTTP = nil;
    NSError * error = nil;
    NSData * jsonData = [NSURLConnection sendSynchronousRequest:req
                                              returningResponse:&responseHTTP
                                                          error:&error];
    return jsonData;
}


/**
 *  Dado un NSData con el JSON devuelto por el API de busquedas de Twitter, extrae el JSON, y
 *  crea objetos Tweet que añade al array self.tweets.
 *
 *  El JSON es un diccionario con dos claves: "statuses" y "search_metadata".
 *
 *  El valor asociado a la clave "statuses" es un array con los tweets encontrados.
 *
 *  Cada tweet es un diccionario. En esta aplicacion solo cogemos los valores asociados a las claves 
 *  "text" y "user". El valor de "text" es el mensaje de tweet. El Valor de "user" es otro diccionario
 *  del que tomamos los valores asociados a las claves "name" y "profile_image_url", que son el nombre 
 *  de autor y la url a su foto.
 *
 *  El valor asociado a la clave "search_metadata" es diccionaro del que solo nos interesa el valor
 *  asociado a la clave "next_results". Es la query a utilizar para bajar la siguiente pagina de tweets.
 *
 *  @param jsonData Es un NSData conteniendo el JSON devuelto por twitter.
 *
 *  @returns Devuelve la query que hay que usar para bajar la siguiente pagina de tweets, o nil
 *           si no hay mas paginas para descargar.
 */
- (NSString*) addJSONData:(NSData*)jsonData {
    
    if ( ! jsonData ) return nil;
    
    NSDictionary * dic;
    NSError * err;
    dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                          options:NSJSONReadingMutableContainers
                                            error:&err];
    if (!dic) {
        NSLog(@"Error parsing JSON = %@",[err localizedDescription]);
        return nil;
    }
    
    
    // Log main keys
    // for (NSString *key in [dic allKeys]) {
    //    NSLog(@"KEY = %@ -> %@",key, dic[key]);
    //}
    
    
    // Extrae los tweets y los almacena en self.tweets.
    // Y actualiza la Table View.
    [dic[@"statuses"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *tweetDic = obj;
        
        Tweet * tweet = [[Tweet alloc] initWithText:tweetDic[@"text"]
                                           username:tweetDic[@"user"][@"name"]
                                           imageUrl:tweetDic[@"user"][@"profile_image_url"]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.tweets addObject:tweet];
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:[self.tweets count]-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[ip]
                              withRowAnimation:NO];
        });
        }];
    
    // Devuelve la query a utilizar para bajar la siguiente pagina de tweets.
    return dic[@"search_metadata"][@"next_results"];
}


#pragma mark - Network Activity

/**
 *  Activa el indicador de actividad de red.
 */
- (void) incrNetActivity
{
    self.contadorPitorros++;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

/**
 *  Desactiva el indicador de actividad de red.
 */
- (void) decrNetActivity
{
    self.contadorPitorros--;
 
    if(self.contadorPitorros<= 0){
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];

    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Tweet Cell";
    QueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                               forIndexPath:indexPath];
    // Configure the cell...
    
    NSUInteger row = indexPath.row;
    
    Tweet * tweet = [self.tweets objectAtIndex:row];
    
    cell.msgLabel.text = tweet.text;
    cell.usernameLabel.text = tweet.username;
    
    UIImage * img = [self.images objectForKey:tweet.imageUrl];
    
    // Si no tengo la imagen, la descargo
    if ( ! img ) {
        
        // Borro la imagen vieja de la celda reutilizada
        cell.userImageView.image = nil;
        
        [self incrNetActivity];
        
        dispatch_queue_t queue = dispatch_queue_create("baja foto",NULL);
        
        dispatch_async(queue, ^{
            
            NSURL *url = [NSURL URLWithString:tweet.imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            if (data) {
                // Guardo la nueva imagen descargada.
                UIImage* newImg = [UIImage imageWithData:data];
                [self.images setObject:newImg
                                forKey:tweet.imageUrl];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Poner la nueva imagen en la celda
                   // cell.userImageView.image = newImg;
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                });
            }
        });
        
        [self decrNetActivity];
    } else {
        // Poner la imagen en la celda
        cell.userImageView.image = img;
    }
    
    
    return cell;
}



#pragma mark - Table View delegate

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
