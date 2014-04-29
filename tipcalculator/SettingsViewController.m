//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Hunaid Hussain on 4/27/14.
//  Copyright (c) 2014 kolekse. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstTipPercentage;
@property (weak, nonatomic) IBOutlet UITextField *secondTipPercentage;
@property (weak, nonatomic) IBOutlet UITextField *thirdTipPercentage;

- (IBAction)onTap:(id)sender;

- (void) loadUserDefaults;

-(void) updateUserDefaults;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadUserDefaults ];
}

- (void)viewWillDisappear:(BOOL)animated {
    [ self updateUserDefaults ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [ self.view endEditing:YES ];
    //[ self updateUserDefaults ];
}

- (void) loadUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float firstTip = kFirsTip;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"TipCalFirstTip"]) {
        firstTip = [ defaults floatForKey:@"TipCalFirstTip"];
    } else {
        [ defaults setFloat:firstTip forKey:@"TipCalFirstTip"];
    }
    float secondTip = kSecondTip;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"TipCalSecondTip"]) {
        secondTip = [ defaults floatForKey:@"TipCalSecondTip"];
    } else {
        [ defaults setFloat:secondTip forKey:@"TipCalSecondTip"];
    }
    float thirdTip = kThirdTip;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"TipCalThirdTip"]) {
        thirdTip = [ defaults floatForKey:@"TipCalThirdTip"];
    } else {
        [ defaults setFloat:thirdTip forKey:@"TipCalThirdTip"];
    }
    [defaults synchronize];
    
    self.firstTipPercentage.text  = [ NSString stringWithFormat:@"%g%%", firstTip ];
    self.secondTipPercentage.text = [ NSString stringWithFormat:@"%g%%", secondTip ];
    self.thirdTipPercentage.text  = [ NSString stringWithFormat:@"%g%%", thirdTip ];

}

- (void) updateUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    float firstTip  = [ self.firstTipPercentage.text floatValue ];
    float secondTip = [ self.secondTipPercentage.text floatValue ];
    float thirdTip  = [ self.thirdTipPercentage.text floatValue ];
    
    [ defaults setFloat:firstTip forKey:@"TipCalFirstTip"];
    [ defaults setFloat:secondTip forKey:@"TipCalSecondTip"];
    [ defaults setFloat:thirdTip forKey:@"TipCalThirdTip"];
    [ defaults synchronize];
}
@end
