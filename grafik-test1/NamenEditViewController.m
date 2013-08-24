//
//  NamenEditViewController.m
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "NamenEditViewController.h"

@interface NamenEditViewController ()

@end

@implementation NamenEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear  Zeile  %i",aconBasis11.aktZeile);
    
    _feldName.text=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:100+aconBasis11.aktZeile];
    _winAnzeige.text=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:200+aconBasis11.aktZeile];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:100+(aconBasis11.aktZeile) text:_feldName.text];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:200+(aconBasis11.aktZeile) text:_winAnzeige.text];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
