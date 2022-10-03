import { TurboModuleRegistry } from 'react-native';
import type { NativeSafetyCheckSpec } from './types';

export default TurboModuleRegistry.getEnforcing<NativeSafetyCheckSpec>(
  'SafetyCheck'
);
