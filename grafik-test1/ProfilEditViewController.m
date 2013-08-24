//
//  ProfilEditViewController.m
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "ProfilEditViewController.h"
#import "wheelDraw.h"

@interface ProfilEditViewController (){
    
    int max;
}
@property (weak, nonatomic) IBOutlet UIButton *vorlageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *vorschauImage;

@end

@implementation ProfilEditViewController

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
    
    UIImage *myImage=[[UIImage imageNamed:@"BtnRed50.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    [_vorlageBtn setBackgroundImage:myImage forState:UIControlStateNormal];
    [_vorlageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    
	// Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    _profilName.text=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:1];
    _anzahlAnzeige.text=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:2 vorgabeText:@"12"];
    _anzahlStepper.value=_anzahlAnzeige.text.integerValue;
    
    [_myGreenFeld setOn:[[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:3 vorgabeText:@"1"]isEqualToString:@"1"]];
    [_gelbesFeld setOn:[[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:4 vorgabeText:@"1"]isEqualToString:@"1"]];
    [_drehkreuz setOn:[[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:5 vorgabeText:@"1"]isEqualToString:@"1"]];
    
    
    max=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:2 vorgabeText:@"12"].integerValue;
    [_myTableView reloadData];
    
    
    [WheelDraw gluecksradZeichnen:_vorschauImage aktivesProfil:aconBasis11.editProfilNr];


}

-(void)allesSpeichern{
    
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:1 text:_profilName.text];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:2 text:_anzahlAnzeige.text];
    if (_myGreenFeld.on)
        [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:3 text:@"1"];
    else
        [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:3 text:@"0"];
    if (_gelbesFeld.on)
        [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:4 text:@"1"];
    else
        [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:4 text:@"0"];
    if (_drehkreuz.on)
        [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:5 text:@"1"];
    else
        [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:5 text:@"0"];
    
    [aconBasis11 einstellungenSpeichern];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self allesSpeichern];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)anzahlStepperChanged:(id)sender {
    
    _anzahlAnzeige.text=[NSString stringWithFormat:@"%i",(int)_anzahlStepper.value];
    max=(int)_anzahlStepper.value;
    [_myTableView reloadData];
    
    [self allesSpeichern];
    [WheelDraw gluecksradZeichnen:_vorschauImage aktivesProfil:aconBasis11.editProfilNr];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return max;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:100+indexPath.row];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    aconBasis11.aktZeile=indexPath.row;
    
    NSLog(@"didHighlightRowAtIndexPath Zeile %i",aconBasis11.aktZeile);
    
}

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



- (IBAction)greenFeld:(id)sender {
    
    [self allesSpeichern];
    [WheelDraw gluecksradZeichnen:_vorschauImage aktivesProfil:aconBasis11.editProfilNr];

}
@end
