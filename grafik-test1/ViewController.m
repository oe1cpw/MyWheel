//
//  ViewController.m
//  grafik-test1
//
//  Created by Christian Pohanka on 14.07.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
//#import "wheelToolbox.h"


@interface ViewController ()
{
    int step;
    int startStep;
    int anzahl;
    int aktPosition;
    int nextStep;
    CGFloat aktGrad;
    int aktR;
    int aktG;
    int aktB;
    
    CGFloat orgX;

}
@property (weak, nonatomic) IBOutlet UIView *topLevel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    orgX=0;
    anzahl=12;
    
    [_topLevel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"holz320548.png"]]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"steine6060.png"]]];
    
    aconBasis11=[[AconBasis11 alloc]init:12 sektion:nil];
    [aconBasis11 einstellungenLaden];
    
}

-(void)viewWillAppear:(BOOL)animated{

    anzahl=[[aconBasis11 getVariableProfilNr:aconBasis11.aktivesProfil feldNr:2]intValue];
    nextStep=anzahl;
    startStep=0;
    step=0;
    aktPosition=0; // Position nach dem Zeichnen
    aktGrad=0;
//    [self gluecksradZeichnen:_myImageView];
    
    [WheelDraw gluecksradZeichnen:_myImageView aktivesProfil:aconBasis11.aktivesProfil];
    
    _winAnzeigeLabel.text=@"Initialisierung";
    _spinnWheelButton.enabled=false;
    
    step=anzahl;
    startStep=step;
    [self rotateAnimate:step];
    
    
}

- (void) playSound: (NSString*) fileName withExtension: (NSString*) extension
{
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
	if (path) {
		NSURL *pathUrl = [NSURL fileURLWithPath:path];
		SystemSoundID audioEffect;
		AudioServicesCreateSystemSoundID((__bridge CFURLRef)pathUrl, &audioEffect);
        
		AudioServicesPlaySystemSound(audioEffect);
	}
}


- (void) playSound2: (NSString*) fileName withExtension: (NSString*) extension
{
    NSURL *soundurl   = [[NSBundle mainBundle] URLForResource:fileName withExtension: extension];
    NSError *error;
//    AVAudioPlayer *mySoundPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:soundurl error:&error];
    AVAudioPlayer *mySoundPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:soundurl error:&error];
    mySoundPlayer.volume=0.99f; //between 0 and 1
    [mySoundPlayer prepareToPlay];
    mySoundPlayer.numberOfLoops=0; //or more if needed

    [mySoundPlayer play];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rotateAnimate:(int)myStep{
    
    [self playSound:@"BtnUp" withExtension:@"mp3"];

    NSTimeInterval time=0.12;
    
    if (step==1)
        time=0.28;
    else
    if (step==2)
        time=0.22;
    else
    if (step==3)
        time=0.19;
    else
    if (step==4)
        time=0.15;

    if (startStep-step==0)
        time=0.21;
    else
    if (startStep-step==1)
        time=0.19;
    else
    if (startStep-step==2)
        time=0.17;
    else
    if (startStep-step==3)
        time=0.15;
    
    
    int faktor=anzahl;
    if (faktor>20) {
        faktor=20;
    }
    
    time=time*12/(2*faktor);
    
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_myImageView cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:time];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    // Transformation. Rotates the view 
    
    // 1..anzahl
    aktPosition++;
    if (aktPosition>anzahl)
        aktPosition=1;
    
    
    aktGrad=((CGFloat)aktPosition-1)*(360/(CGFloat)anzahl)-90+1*(360/(2*(CGFloat)anzahl));
    if (aktGrad<0)
        aktGrad=aktGrad+360;

//   NSLog(@"aktPosition:%i %i Grad:%f ",aktPosition,step,aktGrad);
   
    CGFloat rad=aktGrad*M_PI/180.0;
    step--;
    
//    NSLog(@"step:%i  %i  Grad:%f Rad:%f",step,myStep,grad,rad);
    
    [_myImageView setTransform:CGAffineTransformMakeRotation(rad)];
    [UIView commitAnimations];

}

-(void)rotateAnimateLastStep:(CGFloat)faktor name:(NSString *)name time:(NSTimeInterval)time{
    
    time=time*12/anzahl;
    
    [UIView beginAnimations:name context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_myImageView cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:time];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    // Transformation. Rotates the view
    
    aktGrad=((CGFloat)aktPosition-1)*(360/(CGFloat)anzahl)-90+faktor*(360/(2*(CGFloat)anzahl));
    if (aktGrad<0)
        aktGrad=aktGrad+360;
    
    CGFloat rad=aktGrad*M_PI/180.0;
    
    //    NSLog(@"step:%i  %i  Grad:%f Rad:%f",step,myStep,grad,rad);
    
    [_myImageView setTransform:CGAffineTransformMakeRotation(rad)];
    [UIView commitAnimations];
    
}





- (void)spinWheel {
    
    if (step==0) {
        _winAnzeigeLabel.text=@"Good Luck";
        _spinnWheelButton.enabled=false;
        NSNumber *zufallszahl = [[NSNumber alloc] initWithInt:(random() % (anzahl)) +1];
        int gr=(random() % (2)) +2; // 2,3,4
        
        step=gr*anzahl+zufallszahl.intValue-aktPosition;
        startStep=step;
        [self rotateAnimate:step];
    }
    
}

- (IBAction)clickSpinWheel:(id)sender {
    [self spinWheel];
    
    
    NSString *xx =[[NSString alloc]initWithFormat:@"jaja"];
    
    NSLog(@"%s    %i",__PRETTY_FUNCTION__,xx.getTwo);
    
    NSLog(@"%s    %i",__PRETTY_FUNCTION__,xx.getFive);
    

}



-(void) animationDidStop: (NSString *) animationID finished:(NSNumber *)finished context:(void *)context{
    
    
//    NSLog(@"Animation Stop  Step: %i",step);
    
    if([animationID isEqualToString:@"rotate"]){
        if (step>0)
            [self rotateAnimate:step];
        else
            [self rotateAnimateLastStep:1.5 name:@"rotateLast" time:0.44];
    }
    else
    if([animationID isEqualToString:@"rotateLast"]){
        
        _winAnzeigeLabel.text=[aconBasis11 getVariableProfilNr:aconBasis11.editProfilNr feldNr:200+aktPosition-1];
        [self rotateAnimateLastStep:1 name:@"rotateLast2" time:0.66];
        //NSLog(@"rotateLast - fertig");
    }
    else
    if([animationID isEqualToString:@"rotateLast2"]){
        _spinnWheelButton.enabled=true;
        [self playSound:@"BtnDown" withExtension:@"m4a"];

        //NSLog(@"rotateLast2 - fertig");
        
        
    }
    
    _aktPos.text=[NSString stringWithFormat:@"%i",aktPosition];
}



- (IBAction)panAction:(UIPanGestureRecognizer*)pan {
    CGRect frame=_topLevel.frame;
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point=[pan translationInView:_topLevel];
        frame=_topLevel.frame;
        
        frame.origin.x=orgX+point.x;
        /*
        if (frame.origin.x<0) {
            frame.origin.x=0;
        }
         */
        _topLevel.frame=frame;
        
        //NSLog(@"Pan action  Changed");
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        
//        NSLog(@"Pan action fertig");
        
        if (abs(_topLevel.frame.origin.x)>60) {
            if (_topLevel.frame.origin.x>0) {
                [self performSegueWithIdentifier:@"stamm" sender:self];
            }
            else
            {
                [self performSegueWithIdentifier:@"impressum" sender:self];
            }
        }
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                         
                             CGRect frame=_topLevel.frame;
                             frame.origin.x=0;
                             _topLevel.frame=frame;
                         
                         }
                         completion:^(BOOL finished){
                         
                         }];
        
    }
}

@end
