//
//  wheelToolbox.h
//  MyWheel
//
//  Created by Christian Pohanka on 12.08.13.
//  Copyright (c) 2013 PIU-PRINTEX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>




@interface NSObject (WheelToolbox)

//-(id) jsmAccociatedObjectForKey: (NSString*) key;
//-(void) setJsmAccociatedObject: (id) object forKey: (NSString*) key;

-(int)getFive;

@end


@interface WheelToolbox : NSObject

-(int)getOne;


@end


@interface NSString (AconToolBoxString)

-(int)getTwo;

@end

@interface AconToolBoxString : NSString

@end
