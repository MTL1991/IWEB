//
//  QueriesTableViewController.m
//  Busca Pios
//
//  Created by Santiago Pavón on 16/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "QueriesTableViewController.h"
#import "QueryEditorViewController.h"
#import "TweetsTableViewController.h"

#define QUERIES_FILENAME @"queries.dat"

@interface QueriesTableViewController ()

@property (strong) NSMutableArray * queries;

@end

@implementation QueriesTableViewController

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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self loadQueries];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.queries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Query Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = self.queries[indexPath.row];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"¿Qué quieres buscar en Twitter?";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return @"IWEB 2013/2014 Práctica 10";
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.queries removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [self saveQueries];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{

    id obj = self.queries[fromIndexPath.row];
    
    [self.queries removeObjectAtIndex:fromIndexPath.row];
    [self.queries insertObject:obj atIndex:toIndexPath.row];
    
    [self saveQueries];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"ñam ñam";
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Show Tweets"]) {
       
        TweetsTableViewController * ttvc = segue.destinationViewController;
        
        NSInteger row = [self.tableView indexPathForSelectedRow].row;
        
        ttvc.query = self.queries[row];
        
        
    } else if ([segue.identifier isEqualToString:@"Add Query"]) {
        
        [self.queries insertObject:@"" atIndex:0];
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
        
        
        QueryEditorViewController *qevc = (QueryEditorViewController*)segue.destinationViewController;
        
        qevc.query = @"";
        qevc.row = 0;
        
    } else if ([segue.identifier isEqualToString:@"Edit Query"]) {
        
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        
        QueryEditorViewController *qevc = (QueryEditorViewController*)segue.destinationViewController;
        
        qevc.query = self.queries[indexPath.row];
        qevc.row = indexPath.row;
    }
    
}


- (IBAction) queryWasEdited:(UIStoryboardSegue*)segue
{
    QueryEditorViewController *qevc = (QueryEditorViewController*)segue.sourceViewController;
    
    if (qevc.query) { // La edicion no fue cancelada
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:qevc.row inSection:0];
        
        NSString * query = [qevc.query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([query isEqualToString:@""]) { // Borro la query
            [self.queries removeObjectAtIndex:ip.row];
            
            [self.tableView deleteRowsAtIndexPaths:@[ip]
                                  withRowAnimation:UITableViewRowAnimationLeft];
            
        } else { // Actualizo la query
            [self.queries replaceObjectAtIndex:ip.row withObject:query];
            
            
            [self.tableView reloadRowsAtIndexPaths:@[ip]
                                  withRowAnimation:UITableViewRowAnimationLeft];
        }
        
        [self saveQueries];
    }
}


#pragma mark - Persistence

- (NSString*) getQueriesPath {
    
    NSString * docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0];
    
    return [docsDir stringByAppendingPathComponent:QUERIES_FILENAME];
}


- (void) loadQueries {
    
    self.queries = [NSMutableArray arrayWithContentsOfFile:[self getQueriesPath]];
    
    if ( ! self.queries) {
        self.queries = [NSMutableArray  arrayWithArray:@[@"Salsa",
                                                         @"Merengue",
                                                         @"Bachata",
                                                         @"Tango",
                                                         @"Bachatango",
                                                         @"Chachacha",
                                                         @"Meneito",
                                                         @"Kizomba"]];
    }
}

- (void) saveQueries {
    
    [self.queries writeToFile:[self getQueriesPath] atomically:YES];
}
@end
