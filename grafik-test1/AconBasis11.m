//
//  AconBasis11.m
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "AconBasis11.h"

int const cMaxFelder=37;
int const cMaxEigenschaften=10;
NSString const *cFeldNameKennung=@"p";
NSString const *cEigenschaftKennung=@"e";


@implementation ProfilDaten

-(id)init:(int)nr{
    self=[super init];
    index=nr;
    eigenschaften=[NSMutableArray new];
    for (int i=0; i<cMaxEigenschaften; i++) {
        [eigenschaften addObject:@""];
    }

    feldNamen=[[NSMutableArray alloc]init];
    for (int i=0; i<cMaxFelder; i++) {
        [feldNamen addObject:@""];
    }

    winNamen=[NSMutableArray new];
    for (int i=0; i<cMaxFelder; i++) {
        [winNamen addObject:@""];
    }

    colorNamen=[NSMutableArray new];
    for (int i=0; i<cMaxFelder; i++) {
        [colorNamen addObject:@""];
    }
    


    return self;
}

-(void)einstellungenSpeichern:(NSUserDefaults *)defaults{

    for (int i=0; i<eigenschaften.count; i++) {
        [defaults setObject:[eigenschaften objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@%i-%i",cEigenschaftKennung,index,1+i]];
    }
    for (int i=0; i<feldNamen.count; i++) {
        [defaults setObject:[feldNamen objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@%i-%i",cFeldNameKennung,index,100+i]];
    }
    for (int i=0; i<winNamen.count; i++) {
        [defaults setObject:[winNamen objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@%i-%i",cFeldNameKennung,index,200+i]];
    }
    for (int i=0; i<colorNamen.count; i++) {
        [defaults setObject:[colorNamen objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@%i-%i",cFeldNameKennung,index,300+i]];
    }
}

-(void)einstellungenLaden:(NSUserDefaults *)defaults{
    NSString *text;
    for (int i=0; i<eigenschaften.count; i++) {
        text=[defaults valueForKey:[NSString stringWithFormat:@"%@%i-%i",cEigenschaftKennung,index,1+i]];
        if (text) {
            [eigenschaften replaceObjectAtIndex:i withObject:text];
        }
    }
    for (int i=0; i<feldNamen.count; i++) {
        text=[defaults valueForKey:[NSString stringWithFormat:@"%@%i-%i",cFeldNameKennung,index,100+i]];
        if (text) {
            [feldNamen replaceObjectAtIndex:i withObject:text];
        }
    }
    for (int i=0; i<winNamen.count; i++) {
        text=[defaults valueForKey:[NSString stringWithFormat:@"%@%i-%i",cFeldNameKennung,index,200+i]];
        if (text) {
            [winNamen replaceObjectAtIndex:i withObject:text];
        }
    }
    for (int i=0; i<colorNamen.count; i++) {
        text=[defaults valueForKey:[NSString stringWithFormat:@"%@%i-%i",cFeldNameKennung,index,300+i]];
        if (text) {
            [colorNamen replaceObjectAtIndex:i withObject:text];
        }
    }
}
-(NSString *)getVariableFeldNr:(int)feldNr vorgabeText:(NSString *)vorgabeText{
    
    NSString *text;
    if ((feldNr>0)&&(feldNr<=eigenschaften.count)) {
        text=[eigenschaften objectAtIndex:feldNr-1];
    }
    else
    if ((feldNr>=100)&&(feldNr<199)) {
        text=[feldNamen objectAtIndex:feldNr-100];
    }
    else
        if ((feldNr>=200)&&(feldNr<299)) {
            text=[winNamen objectAtIndex:feldNr-200];
        }
    else
        if ((feldNr>=300)&&(feldNr<399)) {
            text=[colorNamen objectAtIndex:feldNr-300];
        }
    else
        text=nil;

    if (!text || [text isEqualToString:@""]) {
        text=vorgabeText;
    }
    return text;
}



-(void)setVariableFeldNr:(int)feldNr text:(NSString *)text{

    if ((feldNr>0)&&(feldNr<=eigenschaften.count)) {
        [eigenschaften replaceObjectAtIndex:feldNr-1 withObject:text];
    }
    else
    if ((feldNr>=100)&&(feldNr<199)) {
        [feldNamen replaceObjectAtIndex:feldNr-100 withObject:text];
    }
    if ((feldNr>=200)&&(feldNr<299)) {
        [winNamen replaceObjectAtIndex:feldNr-200 withObject:text];
    }
    if ((feldNr>=300)&&(feldNr<399)) {
        [colorNamen replaceObjectAtIndex:feldNr-300 withObject:text];
    }
}


@end

@implementation AconBasis11


-(id)init:(int)max sektion:(NSString *)sektion
{
    self=[super init];
    maxProfDaten=max;
	if (!sektion) {
		sektion=@"x3";
	}
	mySektion=sektion; // [NSString stringWithFormat:@"%@",sektion];
	profDaten=[[NSMutableArray alloc]init];
    for (int i=0; i<max; i++) {
        [profDaten addObject:[[ProfilDaten alloc]init:i]];
    }
	
	deviceIsIPad=([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
	deviceIsIPhone=(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
	
	return self;
}



// Variable Speichern
-(void)einstellungenSpeichern;
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	for (int i=0; i<[profDaten count]; i++) {
        ProfilDaten *myProfilDaten=[profDaten objectAtIndex:i];
        [myProfilDaten einstellungenSpeichern:defaults];
	}
    
    [defaults setObject:[NSString stringWithFormat:@"%i",_aktivesProfil] forKey:@"aktivesProfil"];

    
    
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)einstellungenLaden;
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	for (int i=0; i<maxProfDaten; i++) {
        ProfilDaten *myProfilDaten=[profDaten objectAtIndex:i];
        [myProfilDaten einstellungenLaden:defaults];
	}

    NSString*txt=[defaults valueForKey:@"aktivesProfil"];
    _aktivesProfil=txt.intValue;
    
    [defaults setObject:[NSString stringWithFormat:@"%i",_aktivesProfil] forKey:@"aktivesProfil"];

}


-(NSString *)getVariableProfilNr:(int)nr feldNr:(int)feldNr vorgabeText:(NSString *)vorgabeText{
	if (nr<[profDaten count]) {
        ProfilDaten *myProfilDaten=[profDaten objectAtIndex:nr];
		return [myProfilDaten getVariableFeldNr:feldNr vorgabeText:vorgabeText];
	}
	else {
		return nil;
	}
}

-(NSString *)getVariableProfilNr:(int)nr feldNr:(int)feldNr{
    
    return [self getVariableProfilNr:nr feldNr:feldNr vorgabeText:@""];

}

-(void)setVariableProfilNr:(int)nr feldNr:(int)feldNr text:(NSString *)text{
	if (nr<[profDaten count]) {
        ProfilDaten *myProfilDaten=[profDaten objectAtIndex:nr];
        
        
		[myProfilDaten setVariableFeldNr:feldNr text:text];
	}
}


-(int)getMaxProfile{
    return profDaten.count;
}

-(int)getMaxFelder{

    return cMaxFelder;
}


@end
