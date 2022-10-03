//
//  JailBreakHelper.mm
//  SafetyCheck
//
//  Created by Vu Hung on 02/10/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

#import "JailBreakHelper.h"

@implementation JailBreakHelper

- (NSArray*)suspiciousAppsPathToCheck {
    return @[
        @"/Applications/Cydia.app",
        @"/Applications/blackra1n.app",
        @"/Applications/FakeCarrier.app",
        @"/Applications/Icy.app",
        @"/Applications/IntelliScreen.app",
        @"/Applications/MxTube.app",
        @"/Applications/RockApp.app",
        @"/Applications/SBSettings.app",
        @"/Applications/WinterBoard.app"
    ];
}

- (NSArray*)suspiciousSystemPathsToCheck {
    return @[
        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
        @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
        @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
        @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
        @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        @"/bin/bash",
        @"/bin/sh",
        @"/etc/apt",
        @"/etc/ssh/sshd_config",
        @"/private/var/lib/apt",
        @"/private/var/lib/cydia",
        @"/private/var/mobile/Library/SBSettings/Themes",
        @"/private/var/stash",
        @"/private/var/tmp/cydia.log",
        @"/usr/bin/sshd",
        @"/usr/libexec/sftp-server",
        @"/usr/sbin/sshd",
        @"/var/cache/apt",
        @"/var/lib/apt",
        @"/var/lib/cydia",
        @"/var/log/syslog",
        @"/var/tmp/cydia.log",
    ];
}

- (bool)hasCydiaInstalled {
    UIApplication *application = [UIApplication sharedApplication];
    
    return  [application canOpenURL:[NSURL URLWithString:@"cydia://"]];
}

- (bool)isContainsSuspiciousApps {
    NSArray *suspiciousApps = [self suspiciousAppsPathToCheck];
    
    for (NSString *appPath in suspiciousApps) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:appPath]) {
            return true;
        }
    }
    
    return false;
}

- (bool)isSuspiciousSystemPathsExists {
    NSArray *suspiciousPaths = [self suspiciousSystemPathsToCheck];
    
    for (NSString *path in suspiciousPaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return true;
        }
    }
    
    return false;
}

- (bool)canEditSystemFiles {
    NSString *stringToWrite = @"Jailbreak Test";
    NSError *error;
    
    [stringToWrite writeToFile:@"/private/JailbreakTest.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error == nil) {
        //Device is jailbroken
        return true;
    } else {
        return false;
    }
}

- (bool)isSimulator {
#if TARGET_OS_SIMULATOR
    return true;
#else
    return false;
#endif
}

- (bool)isJailBroken {
    if ([self isSimulator]) {
        return false;
    }
    
    if ([self hasCydiaInstalled]) {
        return true;
    }
    
    if ([self isContainsSuspiciousApps]) {
        return true;
    }
    
    if ([self isSuspiciousSystemPathsExists]) {
        return true;
    }
    
    if ([self canEditSystemFiles]) {
        return true;
    }
    
    return false;
}

@end
