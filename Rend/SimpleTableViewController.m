//
//  SimpleTableViewController.m
//  Rend
//
//  Created by Katerina Zorko on 2/12/15.
//  Copyright (c) 2015 KaterinaZorko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleTableViewController.h"
#import "NewEventViewController.h"

//@interface SimpleTableViewController : PFQueryTableViewController
//
//@end

@implementation SimpleTableViewController
@synthesize delegate;

-(void)loadView{
    [super loadView];
    
   /* _backButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 200, 50)];
    [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    [_backButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_backButton];
    
    [_backButton addTarget:nil action:@selector(chooseFriends:) forControlEvents:UIControlEventTouchUpInside];*/
    
     [self addBackButtonWithTitle:@"back"];
    
    
}
- (void)addBackButtonWithTitle:(NSString *)title
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
}
- (void)backButtonPressed
{
   // NewEventViewController *stv = [NewEventViewController alloc];
   // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:stv];
    
    //[self presentViewController:nav animated:YES completion:nil];*/
    // write your code to prepare popview
    //passes back friends array to new event view controller
    [self.delegate addItemViewController:self didFinishEnteringItem:friends];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
     //[self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    //initialize friends array
    self->friends = [[NSMutableArray alloc] init];
    
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"_User";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    
   /* if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }*/
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *cellIdentifier = @"cell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = object[@"username"];
    //detail text cell that will be hidden with ObjectId
    cell.detailTextLabel.text = [object objectId];
    cell.detailTextLabel.hidden = TRUE;
    //test to show user object IDs
    NSLog(@"%@", [object objectId]);
   /* cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@",
                                 object[@"priority"]];*/
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [friends removeObject: cell.detailTextLabel.text];
        //print statement of friends array- for testing
        for (NSString *string in friends)
        {
            NSLog(@"%@", string);
            
        }
        NSLog(@"\n");
    }
    else
    {
        //[friends addObject: cell.textLabel.text];
        [friends addObject: cell.detailTextLabel.text];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //NSLog(@"%@", [friends objectAtIndex:0]);
        
    }
}

@end