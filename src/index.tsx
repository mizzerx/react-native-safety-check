import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-safety-check' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

// @ts-expect-error
const isTurboModuleEnabled = global.__turboModuleProxy != null;

const SafetyCheckModule = isTurboModuleEnabled
  ? require('./NativeSafetyCheck').default
  : NativeModules.SafetyCheck;

const RTNSafetyCheck = SafetyCheckModule
  ? SafetyCheckModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function check(
  callback: (isSafe: boolean, isVirtualDevice: boolean) => void
): void {
  return RTNSafetyCheck.check(callback);
}

export function closeApp(timeOut = 0): void {
  return RTNSafetyCheck.closeApp(timeOut);
}
