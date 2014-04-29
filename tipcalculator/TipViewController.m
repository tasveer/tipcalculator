//
//  TipViewController.m
//  tipcalculator
//
//  Created by Hunaid Hussain on 4/25/14.
//  Copyright (c) 2014 kolekse. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabelValue;
@property (weak, nonatomic) IBOutlet UILabel *totalLabelValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipSelectionControl;


- (IBAction)onTap:(id)sender;

- (void) updateValues;

- (void) onSettingsButton;

@end


@implementation TipViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [ [ UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_filled-25.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton) ];

    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    NSLog(@"View did load");
    //[ self updateValues ];
}

- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"view will appear");
    [ self updateValues ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [ self.view endEditing:YES ];
    [ self updateValues ];
}

- (void) updateValues {
    
    float billAmount = [self.billTextField.text floatValue ];
    
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
    

    NSArray* tipArray = @[@(firstTip), @(secondTip), @(thirdTip)];

    [ self.tipSelectionControl setTitle:[NSString stringWithFormat:@"%g%%", firstTip] forSegmentAtIndex:0];
    [ self.tipSelectionControl setTitle:[NSString stringWithFormat:@"%g%%", secondTip] forSegmentAtIndex:1];
    [ self.tipSelectionControl setTitle:[NSString stringWithFormat:@"%g%%", thirdTip] forSegmentAtIndex:2];

    
    float tipAmount = billAmount * [ tipArray[self.tipSelectionControl.selectedSegmentIndex ] floatValue ] * .01;
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabelValue.text = [ NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabelValue.text = [ NSString stringWithFormat:@"$%0.2f", totalAmount ];

}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
