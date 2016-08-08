//
//  AddViewController.h
//  PoopandPee
//
//  Created by Chi, Chang(AWF) on 7/30/16.
//  Copyright © 2016 Chi, Chang(AWF). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *poop;
@property (weak, nonatomic) IBOutlet UISwitch *pee;
@property (weak, nonatomic) IBOutlet UISwitch *pump;
@property (weak, nonatomic) IBOutlet UISwitch *breastfeeding;
@property (weak, nonatomic) IBOutlet UITextField *note;
@property (weak, nonatomic) IBOutlet UITextField *milkvolume;

@property (strong) NSManagedObjectContext *device;

- (IBAction)save:(id)sender;
- (IBAction)DismissKeyboard:(id)sender;

@end
