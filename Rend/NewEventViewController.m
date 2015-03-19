//
//  NewEventViewController.m
//  Rend
//
//  Created by Katerina Zorko on 1/30/15.
//  Copyright (c) 2015 KaterinaZorko. All rights reserved.
//

#import "NewEventViewController.h"
#import "SimpleTableViewController.h"


@interface NewEventViewController ()

@end

@implementation NewEventViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setTitle:NSLocalizedString(@"Parse Push Notifications", @"Parse Push Notifications")];
    
   
   // [self loadInstallData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


-(void)loadView{
    [super loadView];
    
    _chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 200, 50)];
    [_chooseButton setTitle:@"SelectFriends" forState:UIControlStateNormal];
    [_chooseButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_chooseButton];
    
    [_chooseButton addTarget:nil action:@selector(chooseFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
        /*  locationManager = [[CLLocationManager alloc] init];
         [locationManager setDelegate:(id)self];
         [locationManager requestWhenInUseAuthorization];
         [locationManager requestAlwaysAuthorization];
         [locationManager startMonitoringSignificantLocationChanges];
         [locationManager startUpdatingLocation];
         
         // Cache any current location info
         CLLocation *currentLocation = locationManager.location;
         if (currentLocation) {
         currentLocation = currentLocation;
         }
         */
    
}
- (void)addItemViewController:(SimpleTableViewController *)controller didFinishEnteringItem:(NSMutableArray*) array
{
    friends = array;
    NSLog(@"This was returned from ViewControllerB %@",friends);
}

- (IBAction)chooseFriends:(id)sender {
    
    NSLog(@"blah");
    
    SimpleTableViewController *stv = [[SimpleTableViewController alloc]initWithStyle:UITableViewStylePlain];
    stv.delegate = self;
    stv.friends = self.friends;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:stv];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)shareLocation:(id)sender
    {
    NSLog(@"Hello");
   /* PFQuery *query = [PFInstallation query];
        [query whereKey:@"channels" equalTo:@"global"];
    
    [query whereKey:@"deviceType" equalTo:@"ios"];
    PFPush *iOSPush = [[PFPush alloc] init];
    [iOSPush setMessage:@"Katerina has asked to share your location with her."];
   //[iOSPush setChannel:@"global"];
    [iOSPush setQuery:query];
    [iOSPush sendPushInBackground];
    */
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"location");
                 //PFUser *user = [PFUser currentUser];
                 PFObject *userLocation = [PFObject objectWithClassName:@"LocationObject"];
                 userLocation[@"location"] = @"geoPoint";
                 [userLocation saveInBackground];
             }
         }];
        
    
   // [PFPush sendPushMessageToChannelInBackground:@"global" withMessage:@"Hello World!"];

    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"global"];
    [push setMessage:@"The Giants just scored!"];
    [push sendPushInBackground];
        
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"friendsList"] = friends;  //TODO friends from simple table view controller
    [event saveInBackground];
    
    for (NSString *string in friends)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        // PFObject *object = [query whereKey:@"objectId" equalTo:string];
        PFObject *object = [query getObjectWithId: string];
        [object setObject:@"" forKey:@"channels"];
        [object saveInBackground];
         
    }
       /* PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"objectId" containedIn:friends];
        NSArray *followingArray = [query findObjects];
        for (NSString *string in followingArray)
        {
            PFObject *object = [query getObjectWithId: string];
            [object setObject:@"" forKey:@"channels"];
            [object saveInBackground];
            
        }*/
   
    
    for (NSString *string in friends)
    {
        NSLog(@"%@", string);
        
    }
    NSLog(@"\n");
    }
@end