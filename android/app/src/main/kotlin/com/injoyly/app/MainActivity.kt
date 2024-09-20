package com.injoyly.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL_VIDEO_THUMBNAIL = "plugins.justsoft.xyz/video_thumbnail"
    private val CHANNEL_TOAST = "com.example.social_media_app/toast"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize the video thumbnail channel
        val videoThumbnailChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_VIDEO_THUMBNAIL)
        VideoThumbnailChannel(this, videoThumbnailChannel)
        // Initialize the toast channel
        val toastChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_TOAST)
        ToastHandler(this, toastChannel)

    }
}
