import { NativeModules, Platform } from 'react-native';
import type { CheckCallback } from './types';

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

export function check(callback: CheckCallback): void {
  return SafetyCheck.check(callback);
}

export function closeApp(timeOut = 0): void {
  return SafetyCheck.closeApp(timeOut);
}

export * from './types';
