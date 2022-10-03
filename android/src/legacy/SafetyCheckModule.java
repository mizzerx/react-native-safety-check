package com.reactnativesafetycheck;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class SafetyCheckModule extends ReactContextBaseJavaModule {
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

  @ReactMethod
  public void check(Callback callback) {
    callback.invoke(
        SafetyCheckModuleImpl.isRooted(reactContext), SafetyCheckModuleImpl.isEmulator());
  }

  @ReactMethod
  public void closeApp(int timeOut) {
    SafetyCheckModuleImpl.closeApp(timeOut);
  }
}
