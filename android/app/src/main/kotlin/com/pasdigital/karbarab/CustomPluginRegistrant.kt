package com.pasdigital.karbarab
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
object CustomPluginRegistrant {
  fun registerWith(registry:PluginRegistry) {
    if (alreadyRegisteredWith(registry))
    {
      return
    }
    FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
    FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"))
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"))
  }
  private fun alreadyRegisteredWith(registry:PluginRegistry):Boolean {
    val key = FirebaseCloudMessagingPluginRegistrant::class.java!!.getCanonicalName()
    if (registry.hasPlugin(key))
    {
      return true
    }
    registry.registrarFor(key)
    return false
  }
}