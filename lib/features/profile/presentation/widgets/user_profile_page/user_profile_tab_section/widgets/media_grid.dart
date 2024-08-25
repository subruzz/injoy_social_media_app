import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/mulitple_post_indicator.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';

import '../../../../../../../core/utils/routes/tranistions/hero_dialog.dart';
import '../../../../../../bottom_nav/presentation/web/popup_container_web.dart';
import '../../../../../../explore/presentation/widgets/all_post_view.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({
    super.key,
    this.isMe = false,
    this.showOnlyOne = false,
    required this.medias,
    this.isShorts = false,
    this.isEdit = false,
  });
  final List<PostEntity> medias;
  final bool isEdit;
  final bool isShorts;
  final bool isMe;
  final bool showOnlyOne;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: AppPadding.small,
        itemCount: medias.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: isShorts ? .5 : 1),
        itemBuilder: (context, index) {
          final media = medias[index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                if (isThatTabOrDeskTop) {
                  Navigator.of(context).push(HeroDialogRoute(
                    builder: (context) => PopupContainerWeb(
                      isShorts: media.isThatvdo,
                      post: media,
                    ),
                  ));
                  return;
                }
                if (isShorts || media.isThatvdo) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoReelPage(
                        isMyShorts: isMe,
                        showOne: showOnlyOne,
                        short: showOnlyOne ? media : null,
                        index: index,
                        reels: medias),
                  ));
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AllPostView(
                        post: showOnlyOne ? media : null,
                        showOnlyOne: showOnlyOne,
                        initialIndex: index,
                        posts: medias,
                        isMyposts: isMe);
                  },
                ));
              },
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: MulitplePostOrShortsIndicator(
                    showIndicator: media.postImageUrl.length > 1,
                    isThatShorts: media.isThatvdo,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl: isShorts || media.isThatvdo
                          ? media.extra ?? ''
                          : medias[index].postImageUrl[0],
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )),
            ),
          );
        });
  }
}
