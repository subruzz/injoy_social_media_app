package com.injoyly.app

import android.content.Context
import android.widget.Toast
import io.flutter.plugin.common.MethodChannel

class ToastHandler(private val context: Context, private val channel: MethodChannel) {

    init {
        // Set up the method call handler
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "showToast" -> {
                    val message = call.argument<String>("message")
                    showToast(message)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showToast(message: String?) {
        if (message != null) {
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }
    }
}
