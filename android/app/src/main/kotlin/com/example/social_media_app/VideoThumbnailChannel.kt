package com.example.social_media_app

import android.content.Context
import android.graphics.Bitmap
import android.media.MediaMetadataRetriever
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream
import java.io.ByteArrayOutputStream

class VideoThumbnailChannel(private val context: Context, private val channel: MethodChannel) {

    init {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "file" -> {
                    val videoPath = call.argument<String>("video") ?: ""
                    val timeMs = call.argument<Int>("timeMs") ?: 0
                    val maxHeight = call.argument<Int>("maxh") ?: 0
                    val maxWidth = call.argument<Int>("maxw") ?: 0
                    val format = call.argument<Int>("format") ?: 0

                    val thumbnailPath = generateThumbnail(videoPath, timeMs, maxHeight, maxWidth, format)
                    result.success(thumbnailPath)
                }
                "data" -> {
                    val videoPath = call.argument<String>("video") ?: ""
                    val timeMs = call.argument<Int>("timeMs") ?: 0
                    val maxHeight = call.argument<Int>("maxh") ?: 0
                    val maxWidth = call.argument<Int>("maxw") ?: 0
                    val format = call.argument<Int>("format") ?: 0

                    val thumbnailData = generateThumbnailData(videoPath, timeMs, maxHeight, maxWidth, format)
                    result.success(thumbnailData)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun generateThumbnail(videoPath: String, timeMs: Int, maxHeight: Int, maxWidth: Int, format: Int): String? {
        val retriever = MediaMetadataRetriever()
        retriever.setDataSource(videoPath)
        val bitmap = retriever.getFrameAtTime(timeMs.toLong(), MediaMetadataRetriever.OPTION_CLOSEST_SYNC)

        if (bitmap != null) {
            // Resize bitmap
            val scaledBitmap = Bitmap.createScaledBitmap(bitmap, maxWidth, maxHeight, true)

            // Save to file
            val file = File(context.cacheDir, "thumbnail.${if (format == 1) "webp" else "png"}")
            val outputStream = FileOutputStream(file)
            scaledBitmap.compress(if (format == 1) Bitmap.CompressFormat.WEBP else Bitmap.CompressFormat.PNG, 100, outputStream)
            outputStream.close()

            return file.absolutePath
        }

        return null
    }

    private fun generateThumbnailData(videoPath: String, timeMs: Int, maxHeight: Int, maxWidth: Int, format: Int): ByteArray? {
        val retriever = MediaMetadataRetriever()
        retriever.setDataSource(videoPath)
        val bitmap = retriever.getFrameAtTime(timeMs.toLong(), MediaMetadataRetriever.OPTION_CLOSEST_SYNC)

        if (bitmap != null) {
            // Resize bitmap
            val scaledBitmap = Bitmap.createScaledBitmap(bitmap, maxWidth, maxHeight, true)

            // Convert to byte array
            val byteArrayOutputStream = ByteArrayOutputStream()
            scaledBitmap.compress(if (format == 1) Bitmap.CompressFormat.WEBP else Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
            return byteArrayOutputStream.toByteArray()
        }

        return null
    }
}
