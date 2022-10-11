#import "SafetyCheck.h"

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNSafetyCheckSpec.h"
#endif

@implementation SafetyCheck
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(check:(RCTResponseSenderBlock)callback)
{
    JailBreakHelper *jailBreakHelper = [[JailBreakHelper alloc] init];
    bool isJailBroken = [jailBreakHelper isJailBroken];
    bool isSimulator = [jailBreakHelper isSimulator];

    callback(@[@(!isJailBroken), @(isSimulator)]);
}

RCT_EXPORT_METHOD(closeApp:(int)timeOut)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeOut * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSafetyCheckSpecJSI>(params);
}
#endif

@end
