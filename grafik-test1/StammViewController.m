//
//  StammViewController.m
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "StammViewController.h"

@interface StammViewController (){
    NSMutableArray *aktiveProfile;
    CGFloat orgX;

}
@property (weak, nonatomic) IBOutlet UIImageView *vorschauImage;
@property (weak, nonatomic) IBOutlet UIView *vorschauView;
@property (weak, nonatomic) IBOutlet UIButton *bearbeitenButton;
@property (weak, nonatomic) IBOutlet UIView *topLevel;

@end

@implementation StammViewController

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
    orgX=0;
	// Do any additional setup after loading the view.
    aktiveProfile=[NSMutableArray new];
    
    UIImage *myImage=[[UIImage imageNamed:@"btnblau50.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    [_bearbeitenButton setBackgroundImage:myImage forState:UIControlStateNormal];
    [_bearbeitenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [aktiveProfile removeAllObjects];
    NSString *profilName;
    for (int i=0; i<aconBasis11.getMaxProfile; i++) {
        profilName=[aconBasis11 getVariableProfilNr:i feldNr:1];
        if ((profilName) && (![profilName isEqualToString:@""])) {
            [aktiveProfile addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    aconBasis11.editProfilNr=aconBasis11.aktivesProfil;

    [_myPickerView  reloadAllComponents];
    if (aconBasis11.aktivesProfil<aktiveProfile.count) {
        [_myPickerView selectRow:aconBasis11.aktivesProfil inComponent:0 animated:true];
    }
    
    [WheelDraw gluecksradZeichnen:_vorschauImage aktivesProfil:aconBasis11.aktivesProfil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [aconBasis11 einstellungenSpeichern];
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return (NSInteger) aktiveProfile.count;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber *nr=[aktiveProfile objectAtIndex:row];
    
    return [aconBasis11 getVariableProfilNr:[nr intValue] feldNr:1];

}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    aconBasis11.aktivesProfil=row;
    aconBasis11.editProfilNr=row;
    NSLog(@"select %i",row);
 //   [self dismissViewControllerAnimated:true completion:nil];
    
    [WheelDraw gluecksradZeichnen:_vorschauImage aktivesProfil:row];

}
- (IBAction)panAction:(UIPanGestureRecognizer *)pan {
    
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
        
        NSLog(@"Pan action  Changed");
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"Pan action fertig");
        
        if (abs(_topLevel.frame.origin.x)>60) {
            [self dismissViewControllerAnimated:true completion:nil];
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
