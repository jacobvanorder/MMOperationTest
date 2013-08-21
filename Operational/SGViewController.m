//
//  SGViewController.m
//  Operational
//
//  Created by mrJacob on 8/21/13.
//  Copyright (c) 2013 sushiGrass. All rights reserved.
//

#import "SGViewController.h"

#import "SGOperationSingleton.h"

@interface SGViewController ()

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

- (IBAction)mainQueueTouched:(id)sender;
- (IBAction)backgroundQueueTouched:(id)sender;
- (IBAction)mainOperationTouched:(id)sender;
- (IBAction)privateOperationTouched:(id)sender;

@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(NSData *)commonRequest  {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/688911/June.png"]];
    
    NSURLResponse *connectionResponse = nil;
    NSError *connectionError = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&connectionResponse error:&connectionError];
    return responseData;
}

- (IBAction)mainQueueTouched:(id)sender {
    [[SGOperationSingleton sharedOperation] performBlockOnMainQueue:^{
        NSData *commonRequest = [self commonRequest];
        NSLog(@"%i", (commonRequest == nil));
    }];
}

- (IBAction)backgroundQueueTouched:(id)sender {
    [[SGOperationSingleton sharedOperation] performBlockOnPrivateQueue:^{
        NSData *commonRequest = [self commonRequest];
        NSLog(@"%i", (commonRequest == nil));
    }];
}

- (IBAction)mainOperationTouched:(id)sender {
    [[SGOperationSingleton sharedOperation] performJuneOperationOnMainThreadWithCompletionBlock:^(NSData *completionData) {
        NSLog(@"%i", (completionData == nil));
    }];
}

- (IBAction)privateOperationTouched:(id)sender {
    [[SGOperationSingleton sharedOperation] performJuneOperationOnPrivateThreadWithCompletionBlock:^(NSData *completionData) {
        NSLog(@"%i", (completionData == nil));
    }];
}
@end
