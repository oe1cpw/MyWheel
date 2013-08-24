//
//  WheelImpressum.m
//  MyWheel
//
//  Created by Christian Pohanka on 15.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "WheelImpressum.h"
#import <QuartzCore/QuartzCore.h>

@interface WheelImpressum ()
{
    CGRect cpwFrame;
    BOOL keypressed;

}
@property (weak, nonatomic) IBOutlet UIView *topLevel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *cpwImage;

@end

@implementation WheelImpressum

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
    keypressed=false;
    cpwFrame=_cpwImage.frame;
    _cpwImage.alpha=0;
    _cpwImage.layer.cornerRadius=10;
    _cpwImage.layer.masksToBounds=true;
    
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"iAconBlau5030"]]];
    [_topLevel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"taste320600"]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    NSLog(@"%s finished  %@",__PRETTY_FUNCTION__,animationID);
    _cpwImage.frame=cpwFrame;

    if ([animationID isEqualToString:@"ani1"])
    {
        if (!keypressed) {
            
            
            NSLog(@"%s Zweite Animation gestartet",__PRETTY_FUNCTION__);
            
            [UIView beginAnimations:@"ani2" context:nil];
            [UIView setAnimationDuration:1];
            [UIView setAnimationDelay:1];
            [UIView setAnimationRepeatAutoreverses:true];
            [UIView setAnimationRepeatCount:2];
            _cpwImage.alpha=0.6;
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            [UIView setAnimationDelegate:self];
            [UIView commitAnimations];
        }
        
    }
    if ([animationID isEqualToString:@"ani2"])
        _cpwImage.alpha=1;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
/*
    [_label1 removeFromSuperview];
    [_label2 removeFromSuperview];
    [self.view addSubview:_label1];
    [self.view addSubview:_label2];
*/
    
    
    CGRect frame=_cpwImage.frame;
    CGRect frame2=_cpwImage.frame;
    frame2.origin.x=0;
    frame2.origin.y=0;
    frame2.size.width=10;
    frame2.size.height=10;
    _cpwImage.frame=frame2;
    
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _cpwImage.frame=frame;
                         _cpwImage.alpha=1;
                     }
                     completion:^(BOOL finished)
    {
        [UIView beginAnimations:@"ani1" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelay:1];
        [UIView setAnimationRepeatAutoreverses:true];
        [UIView setAnimationRepeatCount:2];
        CGRect frame=_cpwImage.frame;
        frame.origin.x=frame.origin.x+20;
        frame.origin.y=frame.origin.y+20;
        frame.size.width=frame.size.width-40;
        frame.size.height=frame.size.height-40;
        _cpwImage.frame=frame;
        [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
                
    }];
    
    
    
    

    
    
    // rechter Label
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _label2.transform = CGAffineTransformMakeRotation(+M_PI/2);
                         CGRect frame=_label2.frame;
                         frame.origin.x=self.view.frame.size.width-20-_label2.frame.size.width;
                         frame.origin.y=(self.view.frame.size.height-_label2.frame.size.height)/2;
                         _label2.frame=frame;
                     }
                     completion:^(BOOL finished){
                     }];
    
    // Linker Label
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _label1.transform = CGAffineTransformMakeRotation(-M_PI/2);
                         CGRect frame=_label1.frame;
                         frame.origin.x=20;
                         frame.origin.y=(self.view.frame.size.height-_label2.frame.size.height)/2;
                         _label1.frame=frame;
                     }
                     completion:^(BOOL finished){
                     }];
}



- (IBAction)panAction:(UIPanGestureRecognizer *)pan {
        
    CGRect frame=_topLevel.frame;
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point=[pan translationInView:_topLevel];
        frame=_topLevel.frame;
        
        frame.origin.x=point.x;
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
- (IBAction)clickBtn:(UIButton *)sender {
    
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame=_label1.frame;
                         frame.origin.x=100;
                         frame.origin.y=100;
                         _label1.frame=frame;

                     }
                     completion:^(BOOL finished){
                     }];

}

- (void)animationFinished3:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    NSLog(@"finished 3");
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)clickBild:(id)sender {
    
    
    CGRect frame=_cpwImage.frame;
    frame.origin.x=frame.origin.x+(frame.size.width/2);
    frame.origin.y=frame.origin.y+(frame.size.height/2);
    frame.size.height=0;
    frame.size.width=0;
    keypressed=true;

    [_cpwImage.layer removeAllAnimations];
    
    _cpwImage.alpha=1;
//    [self.view.layer removeAllAnimations];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationRepeatAutoreverses:false];
    [UIView setAnimationRepeatCount:1];
    _cpwImage.alpha=0.6;
    _cpwImage.frame=frame;
    [UIView setAnimationDidStopSelector:@selector(animationFinished3:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

@end
