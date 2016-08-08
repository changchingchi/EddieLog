//
//  AddViewController.m
//  PoopandPee
//
//  Created by Chi, Chang(AWF) on 7/30/16.
//  Copyright © 2016 Chi, Chang(AWF). All rights reserved.
//

#import "AddViewController.h"
#import <CoreData/CoreData.h>

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize device;


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
    // Do any additional setup after loading the view.
    if(self.device){
        [self.milkvolume setText:[self.device valueForKey:@"milkvolume"]];
        [self.note setText:[self.device valueForKey:@"note"]];
        [self.poop setOn:[[self.device valueForKey:@"poop"] boolValue]];
        [self.breastfeeding setOn:[[self.device valueForKey:@"breastfeeding"] boolValue]];
        [self.pee setOn:[[self.device valueForKey:@"pee"] boolValue]];
        [self.pump setOn:[[self.device valueForKey:@"pump"] boolValue]];
    }
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.milkvolume.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    [self.milkvolume resignFirstResponder];
    self.milkvolume.text = @"";
}

-(void)doneWithNumberPad{
    [self.milkvolume resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd-HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:today];

    if(self.device){
        [self.device setValue:self.milkvolume.text forKey:@"milkvolume"];
        [self.device setValue:self.note.text forKey:@"note"];
        [self.device setValue:[NSNumber numberWithBool:self.poop.isOn] forKey:@"poop"];
        [self.device setValue:[NSNumber numberWithBool:self.pee.isOn] forKey:@"pee"];
        [self.device setValue:[NSNumber numberWithBool:self.pump.isOn] forKey:@"pump"];
        [self.device setValue:[NSNumber numberWithBool:self.breastfeeding.isOn] forKey:@"breastfeeding"];

    }else{
        NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Devices" inManagedObjectContext:context];
        [newEntity setValue:dateString forKey:@"time"];
        [newEntity setValue:self.milkvolume.text forKey:@"milkvolume"];
        [newEntity setValue:self.note.text forKey:@"note"];
        [newEntity setValue:[NSNumber numberWithBool:self.poop.isOn] forKey:@"poop"];
        [newEntity setValue:[NSNumber numberWithBool:self.pee.isOn] forKey:@"pee"];
        [newEntity setValue:[NSNumber numberWithBool:self.pump.isOn] forKey:@"pump"];
        [newEntity setValue:[NSNumber numberWithBool:self.breastfeeding.isOn] forKey:@"breastfeeding"];


    }
    

    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"%@ %@",error, [ error localizedDescription]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)DismissKeyboard:(id)sender {
    [self resignFirstResponder];
}

@end
