import { TurboModule, TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  check: (
    callback: (isSafe: boolean, isVirtualDevice: boolean) => void
  ) => void;
  closeApp: (timeOut: number) => void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('SafetyCheck');
