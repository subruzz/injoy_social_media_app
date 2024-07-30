import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';

class WallpaperPreviewPage extends StatelessWidget {
  final File imageFile;

  const WallpaperPreviewPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<ChatWallapaperCubit, ChatWallapaperState>(
        listener: (context, state) {
          if (state is ChatWallapaperStored) {
            context.read<ChatWallapaperCubit>().getChatWallapaper();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Display the selected wallpaper
              Positioned.fill(
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
              // Chat preview overlay
              Positioned(
                left: 16,
                right: 16,
                top: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppDarkColor().secondaryBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Hey how are you?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppDarkColor().buttonBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Set wallpaper for dark theme',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Set wallpaper button
              Positioned(
                left: 0,
                right: 0,
                bottom: 32,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<ChatWallapaperCubit>()
                          .storechatWallapaper(imageFile);
                    },
                    child: Text('Set wallpaper'),
                  ),
                ),
              ),
              if (state is ChatWallapaperLoading)
                Container(
                  color: Colors.black.withOpacity(.5),
                  child: const Center(
                    child: CircularLoadingGrey(),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
