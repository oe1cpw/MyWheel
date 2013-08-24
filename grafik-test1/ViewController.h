//
//  ViewController.h
//  grafik-test1
//
//  Created by Christian Pohanka on 14.07.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheelDraw.h"
#import "wheelToolbox.h"



@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *aktPos;

@property (weak, nonatomic) IBOutlet UIView *wheelView;
- (IBAction)clickSpinWheel:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *winAnzeigeLabel;
@property (weak, nonatomic) IBOutlet UIButton *spinnWheelButton;
@end
