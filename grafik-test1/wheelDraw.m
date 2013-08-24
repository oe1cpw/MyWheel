//
//  wheelDraw.m
//  MyWheel
//
//  Created by Christian Pohanka on 11.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import "WheelDraw.h"


@interface WheelDraw ()
{
    int anzahl;
    CGFloat aktR;
    CGFloat aktG;
    CGFloat aktB;
    int aktivesProfil;
    CGFloat maxWidth;
}
@end

@implementation WheelDraw



-(CGFloat)mySize:(CGFloat)size
{
    return (size*(maxWidth/280));
}



-(UIColor*)colorWithHexString:(NSString *)stringToConvert
{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor blueColor];//DEFAULT_VOID_COLOR;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return [UIColor blueColor];//DEFAULT_VOID_COLOR;
    
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    
//    NSLog(@"%i %i %i  von %@",r,g,b,stringToConvert);
    
    aktR=r/255;
    aktG=g/255;
    aktB=b/255;
    
    
    
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}


-(void)addRotatedLabel:(CGContextRef)context grad:(CGFloat)grad atX:(CGFloat)atX atY:(CGFloat)atY witdh:(int)width text:(NSString*)text nr:(int)nr{
    
    
    CGFloat rotation=grad*M_PI/180.0;
    
    CGContextRotateCTM(context, +rotation);
    
    CGSize maxSize = CGSizeMake([self mySize:140],[self mySize:16]);
    UIFont *font = [UIFont boldSystemFontOfSize:[self mySize:12.5f]];
    CGSize textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByClipping];

    CGRect titleRect = CGRectMake(atX,atY, width, textSize.height);
    
    //  NSLog(@"Text grad:%f  X:%f  Y:%f w:%f h:%f   %@ ",grad,atX,atY,titleRect.size.width,titleRect.size.height,text);
    
    //    [[UIColor redColor] setFill];  // Farbe der Schrift
    
    NSString *colorText=[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:6];
    if (![colorText isEqualToString:@""]) {
        [self colorWithHexString:colorText];
        CGContextSetRGBFillColor(context, aktR,aktG,aktB, 1);
//        CGContextSetRGBStrokeColor(context, aktR,aktG,aktB, 1);

//        NSLog(@"TextColor  %@",colorText);
        
//        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
    }
    else
        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
    
    [text drawInRect:titleRect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentRight];
    
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    //CGContextTranslateCTM(context,centerX,centerY);

/* ist OK schreibt einen Text an eine Stelle
    CGContextSelectFont(context, "Helvetica-Bold", 18/10 , kCGEncodingMacRoman);
    const char* str = [@"CPW" UTF8String];
    CGContextShowTextAtPoint(context,75,+8,str,3);
*/
    
    
    CGContextRotateCTM(context, -rotation);
}

-(void)drawTextSegments:(CGContextRef)context centerX:(CGFloat)centerX centerY:(CGFloat)centerY radius:(CGFloat)radius  count:(int)count{
    
    CGFloat vonGrad=0;
    CGFloat bisGrad=0;
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(context,centerX,centerY);
    for (int i=0; i<count; i++) {  // i 0..count-1
        vonGrad=(CGFloat)i*360/count;
        bisGrad=(CGFloat)(i+1)*360/count;
        //      NSLog(@"Nr.:%i %f %f",i,vonGrad,bisGrad);
        int nr=anzahl-i;
        // Text dazu schreiben
        NSString* text= //[NSString stringWithFormat:@"%i",nr]; // 1..anzahl
        
        
        [aconBasis11 getVariableProfilNr:aktivesProfil feldNr:100+nr-1];
        
        
        
        CGFloat grad=vonGrad+(bisGrad-vonGrad)/2;
        
        [self addRotatedLabel:context grad:(grad) atX:([self mySize:30]) atY:(-8) witdh:[self mySize:105] text:text nr:i];
        
        
    }
    CGContextTranslateCTM(context,-centerX,-centerY);
}



-(void)drawSegment:(CGContextRef)context centerX:(CGFloat)centerX centerY:(CGFloat)centerY radius:(CGFloat)radius vonGrad:(CGFloat)vonGrad bisGrad:(CGFloat)bisGrad nr:(int)nr{
    
    //    CGContextSetLineWidth(context,1);
    //    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    int c=nr % 13; // nr 1..xx    
    if ((anzahl % 14)==0)
        c=nr % 11;
    
//    NSLog(@"Segmnet %i   >%@<",nr-1,[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:300+nr-1]);
    
    int cnr=anzahl-(nr);
    NSString *colorText=[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:300+cnr];
    if (![colorText isEqualToString:@""]) {
        
        [self colorWithHexString:colorText];
        CGContextSetRGBFillColor(context, aktR,aktG,aktB, 1);
        
        
//        NSLog(@"Color %i  %@",300+cnr,colorText);
        
    }
    else
        switch (c) {
            case 12:
                CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1);
                break;
            case 11:
                CGContextSetRGBFillColor(context, 0.99, 0.8, 0.8, 1);
                break;
            case 1:
                CGContextSetRGBFillColor(context, 0.8, 0.99, 0.8, 1);
                break;
            case 10:
                CGContextSetRGBFillColor(context, 0.8, 0.8, 0.99, 1);
                break;
            case 2:
                CGContextSetRGBFillColor(context, 0.99, 0.99, 0.8, 1);
                break;
            case 9:
                CGContextSetRGBFillColor(context, 0.8, 0.99, 0.99, 1);
                break;
            case 3:
                CGContextSetRGBFillColor(context, 0.99, 0.6, 0.6, 1);
                break;
            case 8:
                CGContextSetRGBFillColor(context, 0.99, 0.99, 0.6, 1);
                break;
            case 4:
                CGContextSetRGBFillColor(context, 0.6, 0.6, 0.99, 1);
                break;
            case 7:
                CGContextSetRGBFillColor(context, 0.6, 0.99, 0.6, 1);
                break;
            case 5:
                CGContextSetRGBFillColor(context, 0.6, 0.99, 0.99, 1);
                break;
            case 6:
                CGContextSetRGBFillColor(context, 0.99, 0.6, 0.99, 1);
                break;
            default:
                CGContextSetRGBFillColor(context, 0.99, 0.99, 0.99, 1);
                break;
        }
    
    
    CGContextMoveToPoint(context,centerX,centerY);
    CGContextAddArc (context,
                     centerX,centerY,
                     radius,
                     vonGrad*M_PI/180.0,
                     bisGrad*M_PI/180.0,
                     0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
}

-(void)drawMultiSegments:(CGContextRef)context centerX:(CGFloat)centerX centerY:(CGFloat)centerY radius:(CGFloat)radius  count:(int)count{
    
    CGFloat vonGrad=0;
    CGFloat bisGrad=0;
    
    for (int i=0; i<count; i++) {  // i 0..count-1
        vonGrad=(CGFloat)i*360/count;
        bisGrad=(CGFloat)(i+1)*360/count;
        //      NSLog(@"Nr.:%i %f %f",i,vonGrad,bisGrad);
        [self drawSegment:context centerX:centerX centerY:centerY radius:radius vonGrad:vonGrad bisGrad:bisGrad nr:i+1];
    }
}


-(void)drawWhiteLineSegments:(CGContextRef)context centerX:(CGFloat)centerX centerY:(CGFloat)centerY radius:(CGFloat)radius  count:(int)count{
    
    CGFloat vonGrad=0;
    CGFloat bisGrad=0;
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(context,centerX,centerY);
    for (int i=0; i<count; i++) {  // i 0..count-1
        vonGrad=(CGFloat)i*360/count;
        bisGrad=(CGFloat)(i+1)*360/count;
        //      NSLog(@"Nr.:%i %f %f",i,vonGrad,bisGrad);
        //int nr=i+1;
        //CGFloat grad=vonGrad+(bisGrad-vonGrad)/2;
        
        
        CGFloat rotation=vonGrad*M_PI/180.0;
        
        
        CGContextRotateCTM(context, +rotation);
        
        
        CGContextSetLineWidth(context,1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint (context,centerX-1,0);
        
        CGContextStrokePath(context);
        
        CGContextRotateCTM(context, -rotation);
        
        
    }
    CGContextTranslateCTM(context,-centerX,-centerY);
}

-(void)drawWheelCrossBlack:(CGContextRef)context centerX:(CGFloat)centerX centerY:(CGFloat)centerY radius:(CGFloat)radius  count:(int)count{
    
    CGFloat grad=0;
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(context,centerX,centerY);
    for (int i=0; i<4; i++) {  // i 0..3
        grad=(CGFloat)i*360/4;  // 0,90,180,270
        
        CGFloat rotation=grad*M_PI/180.0;
        
        
        CGContextRotateCTM(context, +rotation);
        
        
        CGContextSetLineWidth(context,1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint (context,[self mySize:30],0);
        
        CGContextStrokePath(context);
        
        
        CGRect rect= CGRectMake([self mySize:27],[self mySize:-3],[self mySize:6],[self mySize:6]);
        CGContextSetLineWidth(context,0);
        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
        CGContextBeginPath(context);
        CGContextAddEllipseInRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        CGContextRotateCTM(context, -rotation);
        
        
    }
    CGContextTranslateCTM(context,-centerX,-centerY);
}


-(void)doGluecksradZeichnen:(UIImageView*)imageView aktivesProfil:(int)aktivesProfilNr{
    
    aktivesProfil=aktivesProfilNr;
    maxWidth = imageView.bounds.size.width;
    anzahl=[[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:2]intValue];
    
    // Image in Originalposition bringen
    [UIView beginAnimations:@"reset" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:imageView cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [imageView setTransform:CGAffineTransformMakeRotation(0)];
    [UIView commitAnimations];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // zeichnet eine Kreis
    
    CGRect rect= CGRectMake (1,1,imageView.frame.size.width-2,imageView.frame.size.height-2);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, rect);
    //    CGContextDrawPath(context, kCGPathFillStroke); // Or kCGPathFill
    //    CGContextDrawPath(context, kCGPathFill); // Or kCGPathFill
    CGContextStrokePath(context);
    
    CGRect rect2= CGRectMake (2,2,imageView.frame.size.width-4,imageView.frame.size.height-4);
    CGContextSetLineWidth(context,0);
    CGContextSetRGBFillColor(context, 1, 0.6, 0.6, 0); // keine Füllfarbe !!!!
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, rect2);
    CGContextDrawPath(context, kCGPathFillStroke); // Or kCGPathFill
    //    CGContextDrawPath(context, kCGPathFill); // Or kCGPathFill
    //CGContextStrokePath(context);
    
    CGFloat centerX=imageView.frame.size.width/2;
    CGFloat centerY=imageView.frame.size.height/2;
    CGFloat radius=imageView.frame.size.width/2-2;
    
    //    NSLog(@"cx %f  cy %f  radius %f",centerX,centerY,radius);
    
    [self drawMultiSegments:context centerX:centerX centerY:centerY radius:radius count:anzahl];
    
    if ([[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:3 vorgabeText:@"1"]isEqualToString:@"1"]) {
        // In der Mitte Grün ausmalen
        CGRect rect4= CGRectMake ([self mySize:30],[self mySize:30],imageView.frame.size.width-[self mySize:60],imageView.frame.size.height-[self mySize:60]);
        
        CGContextSetLineWidth(context,0);
        CGContextSetRGBFillColor(context, 0.0, 0.6, 0.0, 1);
        CGContextBeginPath(context);
        CGContextAddEllipseInRect(context, rect4);
        CGContextDrawPath(context, kCGPathFillStroke); // Or kCGPathFill
    }
    
    
    [self drawTextSegments:context centerX:centerX centerY:centerY radius:radius count:anzahl];
    
    
    [self drawWhiteLineSegments:context centerX:centerX centerY:centerY radius:radius count:anzahl];
    
    
    
    if ([[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:4 vorgabeText:@"1"]isEqualToString:@"1"]) {
        // In der Mitte gelb ausmalen
        CGRect rect3= CGRectMake ([self mySize:90],[self mySize:90],imageView.frame.size.width-[self mySize:180],imageView.frame.size.height-[self mySize:180]);
        CGContextSetLineWidth(context,0);
        CGContextSetRGBFillColor(context, 1, 1.0, 0.0, 1);
        CGContextBeginPath(context);
        CGContextAddEllipseInRect(context, rect3);
        CGContextDrawPath(context, kCGPathFillStroke); // Or kCGPathFill
    }
    
    // In der Mitte schwarzer Punkt
    CGRect rect5= CGRectMake ([self mySize:135],[self mySize:135],imageView.frame.size.width-[self mySize:270],imageView.frame.size.height-[self mySize:270]);
    CGContextSetLineWidth(context,0);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, rect5);
    CGContextDrawPath(context, kCGPathFillStroke); // Or kCGPathFill
    
    // In der Mitte schwarzer Kreis
    CGRect rect6= CGRectMake ([self mySize:130],[self mySize:130],imageView.frame.size.width-[self mySize:260],imageView.frame.size.height-[self mySize:260]);
    CGContextSetLineWidth(context,1.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, rect6);
    CGContextStrokePath(context);
    
    if ([[aconBasis11 getVariableProfilNr:aktivesProfil feldNr:5 vorgabeText:@"1"]isEqualToString:@"1"]) {
        [self drawWheelCrossBlack:context centerX:centerX centerY:centerY radius:radius count:anzahl];
    }
    
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


+(void)gluecksradZeichnen:(UIImageView*)imageView aktivesProfil:(int)aktivesProfil
{
    
    NSLog(@"gluecksradZeichnen %i",aktivesProfil);
    WheelDraw *myWheelDraw=[[WheelDraw alloc]init];
    [myWheelDraw doGluecksradZeichnen:imageView aktivesProfil:aktivesProfil];
    
}


@end
