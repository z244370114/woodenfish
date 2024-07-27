package com.xhx.woodenfish

import android.app.Application
import com.umeng.commonsdk.UMConfigure

class MyApp : Application() {

    override fun onCreate() {
        super.onCreate()
        UMConfigure.preInit(this, "63b91145ba6a5259c4e3e8b6", AppInfo.getAppChannelId(this))
    }

}