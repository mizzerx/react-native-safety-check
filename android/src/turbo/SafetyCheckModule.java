package com.reactnativesafetycheck;

import androidx.annotation.NonNull;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;

public class SafetyCheckModule extends NativeSafetyCheckSpec {
  public static final String NAME = SafetyCheckModuleImpl.NAME;
  private final ReactApplicationContext reactContext;

  SafetyCheckModule(ReactApplicationContext context) {
    super(context);
    this.reactContext = context;
  }

  @Override
  @NonNull
  public String getName() {
    return SafetyCheckModuleImpl.NAME;
  }

  @Override
  @ReactMethod
  public void check(Callback callback) {
    callback.invoke(
      SafetyCheckModuleImpl.isEmulator(), SafetyCheckModuleImpl.isRooted(reactContext));
  }

  @Override
  @ReactMethod
  public void closeApp(int timeOut) {
    SafetyCheckModuleImpl.closeApp(timeOut);
  }
}
