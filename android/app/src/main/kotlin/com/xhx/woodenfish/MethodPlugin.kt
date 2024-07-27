package com.xhx.woodenfish

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import com.umeng.commonsdk.UMConfigure
import com.xhx.woodenfish.AppInfo.getAppChannelId
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MethodPlugin : MethodChannel.MethodCallHandler, FlutterPlugin, ActivityAware {


    private var activity: Activity? = null
    private var channel: MethodChannel? = null
    private val FLUTTERPLUGIN = "com.xhx.woodenfish/plugin"
    private var flutterResult: MethodChannel.Result? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (flutterResult == null) {
            flutterResult == result
        }
        when (call.method) {
            "isAgree" -> {
                UMConfigure.submitPolicyGrantResult(activity, true)
                result.success("isAgree")
            }

            "share" -> {
                val textIntent = Intent(Intent.ACTION_SEND)
                textIntent.type = "text/plain"
                textIntent.putExtra(
                    Intent.EXTRA_TEXT,
                    "https://play.google.com/store/apps/details?id=com.xhx.woodenfishs"
                )
                activity?.startActivity(Intent.createChooser(textIntent, "分享"))
            }

            "googlePlay" -> {
                var googlePlay = "com.android.vending"
                when (getAppChannelId(activity!!)) {
                    "huawei" -> {
                        googlePlay = "com.huawei.appmarket"
                    }
                    "google" -> {
                        googlePlay = "com.android.vending"
                    }
                    "xiaomi" -> {
                        googlePlay = "com.xiaomi.market"
                    }
                }
                try {
                    val uri = Uri.parse("market://details?id=" + BuildConfig.APPLICATION_ID)
                    val intent = Intent(Intent.ACTION_VIEW, uri)
                    intent.setPackage(googlePlay)
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    activity?.startActivity(intent)
                } catch (e: Exception) {
                }
            }

            "getVersionName" -> {
                try {
                    val packageManager: PackageManager = activity?.packageManager!!
                    val packageInfo: PackageInfo =
                        packageManager.getPackageInfo(activity?.packageName!!, 0)
                    val versionName = packageInfo.versionName
                    result.success(versionName)
                } catch (e: PackageManager.NameNotFoundException) {
                    e.printStackTrace()
                }
            }

            "getVersionCode" -> {
                try {
                    val packageManager: PackageManager = activity?.packageManager!!
                    val packageInfo: PackageInfo =
                        packageManager.getPackageInfo(activity?.packageName!!, 0)
                    val versionCode = packageInfo.versionCode
                    result.success(versionCode)
                } catch (e: PackageManager.NameNotFoundException) {
                    e.printStackTrace()
                }
            }

            "getAppChannelId" -> {
                result.success(getAppChannelId(activity!!))
            }

        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, FLUTTERPLUGIN)
        channel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }


}