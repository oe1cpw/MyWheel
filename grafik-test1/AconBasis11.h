//
//  AconBasis11.h
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProfilDaten : NSObject{
    int index; // nr 0..xx
    int maxFelder;  // Anzahl der Felder im Rad
    BOOL unsave; // true speichert alles zurück
    NSMutableArray *eigenschaften;  //  Liste der Eigenschaften 1..99
    NSMutableArray *feldNamen;  //  Liste der Namen  100..199
    NSMutableArray *winNamen;  //  Liste der Namen  200..299
    NSMutableArray *colorNamen; // Liste der Farben 300..399
    
}
-(id)init:(int)nr;
-(void)einstellungenSpeichern:(NSUserDefaults *)defaults;
-(NSString *)getVariableFeldNr:(int)feldNr vorgabeText:(NSString *)vorgabeText;
-(void)setVariableFeldNr:(int)feldNr text:(NSString *)text;

@end


@interface AconBasis11 : NSObject {
	NSMutableArray *profDaten;
	int maxProfDaten;
	NSString *mySektion;
	BOOL deviceIsIPad;
	BOOL deviceIsIPhone;
}

-(id)init:(int)max sektion:(NSString *)sektion;
-(void)einstellungenSpeichern;
-(void)einstellungenLaden;

-(NSString *)getVariableProfilNr:(int)nr feldNr:(int)feldNr vorgabeText:(NSString *)vorgabeText;
-(NSString *)getVariableProfilNr:(int)nr feldNr:(int)feldNr;

-(void)setVariableProfilNr:(int)nr feldNr:(int)feldNr text:(NSString *)text;


-(int)getMaxProfile;
-(int)getMaxFelder;

@property int aktProfil;
@property int editProfilNr;
@property int aktZeile;
@property int aktivesProfil;


@end

AconBasis11 *aconBasis11;


