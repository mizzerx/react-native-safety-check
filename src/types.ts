import type { TurboModule } from 'react-native';

export type CheckCallback = (
  callback: (isSafe: boolean, isVirtualDevice: boolean) => void
) => void;

export interface NativeSafetyCheckSpec extends TurboModule {
  check: (callback: CheckCallback) => void;
  closeApp: (timeOut: number) => void;
}
