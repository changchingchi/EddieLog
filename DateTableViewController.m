//
//  TableViewController.m
//  PoopandPee
//
//  Created by Chi, Chang(AWF) on 7/30/16.
//  Copyright © 2016 Chi, Chang(AWF). All rights reserved.
//

#import "DateTableViewController.h"
#import <Coredata/CoreData.h>
@interface DateTableViewController ()

@property(strong) NSMutableArray *devices;

@end

@implementation DateTableViewController


-(NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Devices"];
    
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    NSManagedObjectModel *device = [self.devices objectAtIndex:indexPath.row];
    
    
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"time"]]];
    //    if(![[device valueForKey:@"milkvolume"] isEqualToString:@""]){
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",
                                   [[device valueForKey:@"breastfeeding"] boolValue]?@"Breastfeeding":@"",
                                   ![[device valueForKey:@"milkvolume"] isEqualToString:@""]? [[device valueForKey:@"milkvolume"] stringByAppendingString:@"mL bottle milk"]:@"",
                                   [[device valueForKey:@"pump"] boolValue]?@"Pump":@"",
                                   [[device valueForKey:@"poop"] boolValue]?@"Poop":@"",
                                   [[device valueForKey:@"pee"] boolValue]?@"Pee":@"",
                                   [device valueForKey:@"note"]]];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *manageobjectcontext = [self managedObjectContext];
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [manageobjectcontext deleteObject:[self.devices objectAtIndex:indexPath.row]];
    }
    NSError *error = nil;
    if(![manageobjectcontext save:&error]){
        NSLog(@"%@ %@",error, [ error localizedDescription]);
    }
    [self.devices removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"DateEntity"]){
        NSManagedObjectModel *SelectedDevice = [self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        TableViewController *addview = [segue destinationViewController];
        addview.device = SelectedDevice;
    }
}


@end
