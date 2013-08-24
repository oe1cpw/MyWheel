//
//  VorlagenWahlViewController.m
//  grafik-test1
//
//  Created by Christian Pohanka on 08.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "VorlagenWahlViewController.h"
#import "VorlageCell.h"

@interface VorlagenWahlViewController ()
{
}

@end

@implementation VorlagenWahlViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    VorlageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    */
    // Configure the cell...
    NSString *text;
    switch (indexPath.row) {
        case 0:
            text=@"Roulette 12";
            break;
        case 1:
            text=@"Roulette 24";
            break;
        case 2:
            text=@"Roulette 36";
            break;
        case 3:
            text=@"Ehe Glücksrad";
            break;
            
        default:
            break;
    }
     
     [cell showCellDaten:text];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

-(void)setDatenProfillName:(NSString *)profilName anzahlText:(NSString *)anzahlText greenOnText:(NSString *)greenOnText gelbOnText:(NSString *)gelbOnText drehkreuzOnText:(NSString *)drehkreuzOnText fontColorText:(NSString *)fontColorText
{

    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:1 text:profilName];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:2 text:anzahlText];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:3 text:greenOnText];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:4 text:gelbOnText];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:5 text:drehkreuzOnText];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:6 text:fontColorText];
}

-(void)setFeldNr:(int)nr feldName:(NSString *)feldName winText:(NSString *)winText colorText:(NSString *)colorText
{
    
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:100+nr text:feldName];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:200+nr text:winText];
    [aconBasis11 setVariableProfilNr:aconBasis11.editProfilNr feldNr:300+nr text:colorText];

}



-(void)vorlageDatenSetzenNr:(int)nr
{
    // Alle Felder löschen
    for (int i=0; i<aconBasis11.getMaxFelder; i++) {
        NSString* name=[NSString stringWithFormat:@"%i",i+1];
        [self setFeldNr:i feldName:name winText:@"" colorText:@""];
    }
    
    switch (nr) {
        case 0: // Roulette 12
            [self setDatenProfillName:@"Roulette 12" anzahlText:@"13" greenOnText:@"1" gelbOnText:@"1" drehkreuzOnText:@"1"fontColorText:@"FFFFFF"];
            [self setFeldNr:0 feldName:@"5" winText:@"rot 5" colorText:@"FF0000"];
            [self setFeldNr:1 feldName:@"12" winText:@"Schwarz 12" colorText:@"000000"];
            [self setFeldNr:2 feldName:@"3" winText:@"rot 3" colorText:@"FF0000"];
            [self setFeldNr:3 feldName:@"10" winText:@"schwarz 10" colorText:@"000000"];
            [self setFeldNr:4 feldName:@"7" winText:@"rot 7" colorText:@"FF0000"];
            [self setFeldNr:5 feldName:@"8" winText:@"schwarz 8" colorText:@"000000"];
            [self setFeldNr:6 feldName:@"9" winText:@"rot 9" colorText:@"FF0000"];
            [self setFeldNr:7 feldName:@"2" winText:@"schwarz 2" colorText:@"000000"];
            [self setFeldNr:8 feldName:@"7" winText:@"rot 7" colorText:@"FF0000"];
            [self setFeldNr:9 feldName:@"6" winText:@"schwarz 6" colorText:@"000000"];
            [self setFeldNr:10 feldName:@"11" winText:@"rot 11" colorText:@"FF0000"];
            [self setFeldNr:11 feldName:@"4" winText:@"schwarz 4" colorText:@"000000"];
            [self setFeldNr:12 feldName:@"0" winText:@"Grün 0" colorText:@"00FF00"];
            break;
        case 1: // Roulette 24
            [self setDatenProfillName:@"Roulette 24" anzahlText:@"24" greenOnText:@"1" gelbOnText:@"1" drehkreuzOnText:@"1" fontColorText:@""];
            //[self setFeldNr:0 feldName:@"Name" winText:@"Info" colorText:@""];
            break;
        case 2: // Roulette 36
            [self setDatenProfillName:@"Roulette 36" anzahlText:@"36" greenOnText:@"1" gelbOnText:@"1" drehkreuzOnText:@"1" fontColorText:@""];
            //[self setFeldNr:0 feldName:@"Name" winText:@"Info" colorText:@""];
            break;
        case 3: // Ehe Glücksrad
            [self setDatenProfillName:@"Ehe Sex" anzahlText:@"6" greenOnText:@"0" gelbOnText:@"1" drehkreuzOnText:@"1" fontColorText:@""];
            [self setFeldNr:0 feldName:@"SEX" winText:@"Ja heute steht SEX am Plan" colorText:@""];
            [self setFeldNr:1 feldName:@"kein Sex" winText:@"Wegen Kopfschnerzen kein Sex" colorText:@""];
            [self setFeldNr:2 feldName:@"kein Sex" winText:@"Leider die Regel" colorText:@""];
            [self setFeldNr:3 feldName:@"kein Sex" winText:@"Es geht mir nicht wirklich gut" colorText:@""];
            [self setFeldNr:4 feldName:@"kein Sex" winText:@"Eigentlich habe ich keine Lust" colorText:@""];
            [self setFeldNr:5 feldName:@"kein Sex" winText:@"Leider heute kein Sex" colorText:@""];
            break;
            
        default:
            break;
    }

    NSLog(@"Vorlage %i",nr);
    [self.navigationController popViewControllerAnimated:YES];



}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* selectedRow = [self.tableView indexPathForSelectedRow];
    NSLog(@"Vorlage Click %i",selectedRow.row);
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Vorlage übernemhen" message:@"Möchten Sie die Vorlage übernehmen?" delegate:self cancelButtonTitle:@"Nein" otherButtonTitles:@"Ja", nil];
    [alertView show];
}






-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"btn %i",buttonIndex);
    if (buttonIndex==1) {
        NSIndexPath* selectedRow = [self.tableView indexPathForSelectedRow];
        NSLog(@"Vorlagedaten setzen  Nr.%i",selectedRow.row);
        [self vorlageDatenSetzenNr:selectedRow.row];

    }

}

@end
