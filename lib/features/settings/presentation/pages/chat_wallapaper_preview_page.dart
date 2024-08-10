import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'dart:io';

import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/overlay_loading_holder.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';

class WallpaperPreviewPage extends StatelessWidget {
  final File imageFile;

  const WallpaperPreviewPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        title: 'Preview',
        showLeading: true,
      ),
      body: BlocConsumer<ChatWallapaperCubit, ChatWallapaperState>(
        listener: (context, state) {
          if (state is ChatWallapaperStored) {
            Messenger.showSnackBar(message: 'New chat wallapapper set');
            Navigator.pop(context);
            Navigator.pop(context);
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
                    const WallapaperPreviewChatBubble(),
                    AppSizedBox.sizedBox15H,
                    const WallapaperPreviewChatBubble(
                      left: false,
                      text: 'If so set wallapaper and enjoy!',
                    )
                  ],
                ),
              ),
              // Set wallpaper button
              Positioned(
                left: 0,
                right: 0,
                bottom: 32.h,
                child: Center(
                    child: CustomButton(
                        width: null,
                        radius: AppBorderRadius.small,
                        onClick: () {
                          context
                              .read<ChatWallapaperCubit>()
                              .storechatWallapaper(imageFile);
                        },
                        child: const Text('Set Wallapaper'))),
              ),
              if (state is ChatWallapaperLoading) const OverlayLoadingHolder()
            ],
          );
        },
      ),
    );
  }
}

class WallapaperPreviewChatBubble extends StatelessWidget {
  const WallapaperPreviewChatBubble(
      {super.key,
      this.left = true,
      this.text = 'Hey Do you like this wallapaper?'});
  final bool left;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: left ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: AppPadding.all(13),
        decoration: BoxDecoration(
          color: left
              ? AppDarkColor().secondaryBackground
              : AppDarkColor().buttonBackground,
          borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(8),
              bottomRight: const Radius.circular(8),
              topRight: Radius.circular(left ? 8 : 0),
              topLeft: Radius.circular(left ? 0 : 8)),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
