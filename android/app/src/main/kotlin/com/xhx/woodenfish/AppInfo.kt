package com.xhx.woodenfish

import android.content.Context
import android.content.pm.PackageManager

object AppInfo {
    fun getAppVersionCode(context: Context): String {
        var versioncode = 0
        try {
            val pm = context.packageManager
            val pi = pm.getPackageInfo(context.packageName, 0)
            versioncode = pi.versionCode
        } catch (e: Exception) {
        }
        return versioncode.toString() + ""
    }

    fun getAppChannelId(context: Context): String {
        val appInfo = context.packageManager!!.getApplicationInfo(context.packageName, PackageManager.GET_META_DATA)
        return appInfo.metaData.getString("UMENG_CHANNEL").toString()
    }
}