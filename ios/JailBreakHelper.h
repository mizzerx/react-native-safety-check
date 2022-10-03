//
//  JailBreakHelper.h
//  SafetyCheck
//
//  Created by Vu Hung on 02/10/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef JailBreakHelper_h
#define JailBreakHelper_h

@interface JailBreakHelper : NSObject

- (bool)isSimulator;
- (bool)isJailBroken;

@end

#endif /* JailBreakHelper_h */
