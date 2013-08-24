//
//  StammViewController.h
//  grafik-test1
//
//  Created by Christian Pohanka on 04.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheelDraw.h"



@interface StammViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

- (IBAction)clickClose:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@end
