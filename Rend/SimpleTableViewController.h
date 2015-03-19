//
//  SimpleTableViewController.h
//  Rend
//
//  Created by Katerina Zorko on 2/12/15.
//  Copyright (c) 2015 KaterinaZorko. All rights reserved.
//

#ifndef Rend_SimpleTableViewController_h
#define Rend_SimpleTableViewController_h

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "NewEventViewController.h"

#endif

@class SimpleTableViewController;

@protocol SimpleTableViewControllerDelegate <NSObject>
- (void)addItemViewController:(SimpleTableViewController *)controller didFinishEnteringItem:(NSMutableArray*)array;
@end

@interface SimpleTableViewController : PFQueryTableViewController
{
    NSMutableArray *friends;
   // id <SimpleTableViewControllerDelegate> delegate;
    
}
@property (nonatomic, assign) id <SimpleTableViewControllerDelegate> delegate;
@property (nonatomic, strong) UIButton *backButton;
@property(nonatomic,retain) NSMutableArray *friends;
@end
