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

const SafetyCheck = SafetyCheckModule
  ? SafetyCheckModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return SafetyCheck.multiply(a, b);
}
