//
//  VorlageCell.m
//  MyWheel
//
//  Created by Christian Pohanka on 11.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "VorlageCell.h"
#import "wheelDraw.h"

@interface VorlageCell()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myNameLabel;

@end

@implementation VorlageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showCellDaten:(NSString*)text
{

    _myNameLabel.text=text;
    
    
//    [WheelDraw gluecksradZeichnen:_myImageView aktivesProfil:0];
    


}


@end
