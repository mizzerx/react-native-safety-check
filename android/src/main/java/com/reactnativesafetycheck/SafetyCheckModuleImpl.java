package com.reactnativesafetycheck;

import android.app.AlertDialog;
import android.content.Context;
import android.os.Build;

import com.facebook.react.bridge.Callback;
import com.scottyab.rootbeer.RootBeer;

/**
 * This is where the module implementation lives The exposed methods can be defined in the `turbo`
 * and `legacy` folders
 */
public class SafetyCheckModuleImpl {
  private SafetyCheckModuleImpl() {}

  public static final String NAME = "SafetyCheck";

  private static boolean isEmulator() {
    return (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
        || Build.FINGERPRINT.startsWith("generic") || Build.FINGERPRINT.startsWith("unknown")
        || Build.HARDWARE.contains("goldfish") || Build.HARDWARE.contains("ranchu")
        || Build.MODEL.contains("google_sdk") || Build.MODEL.contains("Emulator")
        || Build.MODEL.contains("Android SDK built for x86")
        || Build.MANUFACTURER.contains("Genymotion") || Build.PRODUCT.contains("sdk_google")
        || Build.PRODUCT.contains("google_sdk") || Build.PRODUCT.contains("sdk")
        || Build.PRODUCT.contains("sdk_x86") || Build.PRODUCT.contains("vbox86p")
        || Build.PRODUCT.contains("emulator") || Build.PRODUCT.contains("simulator");
  }

  private static boolean isRooted(Context context) {
    RootBeer rootBeer = new RootBeer(context);

    if (isEmulator()) {
      return false;
    }

    return rootBeer.isRooted();
  }

  public static void check(Context context, Callback callback) {
    callback.invoke(!isRooted(context), isEmulator());
  }

  public static void closeApp(double timeOut) {
    try {
      Thread.sleep((long) timeOut);
    } catch (InterruptedException e) {
      Log.e(NAME, "Error while closing app", e);
      Thread.currentThread().interrupt();
    }
    android.os.Process.killProcess(android.os.Process.myPid());
    System.exit(1);
  }
}
