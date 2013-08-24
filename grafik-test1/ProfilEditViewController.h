//
//  ProfilEditViewController.h
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfilEditViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *profilName;
@property (weak, nonatomic) IBOutlet UILabel *anzahlAnzeige;
@property (weak, nonatomic) IBOutlet UIStepper *anzahlStepper;
- (IBAction)anzahlStepperChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISwitch *myGreenFeld;
- (IBAction)greenFeld:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *gelbesFeld;
@property (weak, nonatomic) IBOutlet UISwitch *drehkreuz;

@end
