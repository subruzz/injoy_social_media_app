import 'package:flutter/widgets.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/widget/select_hashtag.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/widget/selected_hashtags.dart';

class HashTagSection extends StatelessWidget {
  const HashTagSection({
    super.key,
    required this.hashTagController,
    required this.selectTagsCubit,
  });
  final TextEditingController hashTagController;
  final SelectTagsCubit selectTagsCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectedHashtags(
          selectTagsCubit: selectTagsCubit,
        ),
        SelectHashtag(
            selectTagsCubit: selectTagsCubit,
            hashtagcontroller: hashTagController),
      ],
    );
  }
}
