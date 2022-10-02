package com.reactnativesafetycheck;

import androidx.annotation.NonNull;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;

public class SafetyCheckModule extends NativeSafetyCheckSpec {
  public static final String NAME = SafetyCheckModuleImpl.NAME;

  SafetyCheckModule(ReactApplicationContext context) {
    super(context);
  }

  @Override
  @NonNull
  public String getName() {
    return SafetyCheckModuleImpl.NAME;
  }

  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @Override
  @ReactMethod
  public void multiply(double a, double b, Promise promise) {
    SafetyCheckModuleImpl.multiply(a, b, promise);
  }
}
