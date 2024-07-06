import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/loading_bar.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets_indicator.dart';
import 'package:social_media_app/core/widgets/app_related/rotated_icon.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/post_attributes_select.dart';
import 'package:social_media_app/features/post/presentation/widgets/hashtags/select_hashtag.dart';
import 'package:social_media_app/features/post/presentation/widgets/hashtags/selected_hashtags.dart';
import 'package:social_media_app/features/post/presentation/widgets/post_feeds_options.dart';
import 'package:social_media_app/features/post/presentation/widgets/post_location/post_location.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, required this.locationBloc});
  final LocationBloc locationBloc;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _descriptionController = TextEditingController();
  final _hashtagcontroller = TextEditingController();
  final _selectTagsCubit = GetIt.instance<SelectTagsCubit>();
  final PageController _pageController = PageController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 1000));
  final ValueNotifier<List<AssetEntity>> _selectedAssets = ValueNotifier([]);

  @override
  void dispose() {
    _descriptionController.dispose();
    _hashtagcontroller.dispose();
    _selectTagsCubit.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final locationState = widget.locationBloc.state;
              final selectedHashtags = _selectTagsCubit.state;
              final appUser = context.read<AppUserBloc>().appUser!;
              context.read<CreatePostBloc>().add(CreatePostClickEvent(
                  isCommentOff: isCommentOff.value,
                  userFullName: appUser.fullName ?? '',
                  postPics: _selectedAssets.value,
                  creatorUid: appUser.id,
                  username: appUser.userName ?? '',
                  description: _descriptionController.text.trim().isEmpty
                      ? null
                      : _descriptionController.text.trim(),
                  userProfileUrl: appUser.profilePic,
                  hashtags: selectedHashtags is SelectdTagsSuccess
                      ? selectedHashtags.tags
                      : [],
                  latitude: null,
                  location: null,
                  longitude: null
                  // latitude: locationState is LocationSuccess
                  //     ? locationState.latitue
                  //     : null,
                  // longitude: locationState is LocationSuccess
                  //     ? locationState.longitude
                  //     : null,
                  // location: locationState is LocationSuccess
                  //     ? locationState.locationName
                  //     : null

                  ));
            },
            icon: const RotatedIcon(
              icon: Icons.send_outlined,
            ),
          ),
        ],
        title: const Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if (state is CreatePostFailure) {
              Messenger.showSnackBar(message: state.errorMsg);
            }
            if (state is CreatePostSuccess) {
              context.read<GetUserPostsBloc>().add(GetUserPostsrequestedEvent(
                  uid: context.read<AppUserBloc>().appUser!.id));
              Navigator.pop(context);
              Messenger.showSnackBar(message: 'success');
            }
          },
          builder: (context, state) {
            if (state is CreatePostLoading) {
              return const LoadingBar();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectedAssetsPageView(
                    isPost: true,
                    pageController: _pageController,
                    selectedAssets: _selectedAssets),
                Center(
                  child: SelectedAssetsIndicator(
                      isPost: true,
                      pageController: _pageController,
                      selectedAssets: _selectedAssets),
                ),
                PostAttributesSelect(
                    selectedAssets: _selectedAssets,
                    descriptionController: _descriptionController),
                AppSizedBox.sizedBox20H,
                SelectedHashtags(selectTagsCubit: _selectTagsCubit),
                SelectHashtag(
                    selectTagsCubit: _selectTagsCubit,
                    debouncer: _debouncer,
                    hashtagcontroller: _hashtagcontroller),
                AppSizedBox.sizedBox10H,
                PostLocation(locationBloc: widget.locationBloc),
                AppSizedBox.sizedBox10H,
                const PostFeedsOptions(
                    icon: Icons.person_add_alt_outlined, text: 'Tag People'),
                AppSizedBox.sizedBox10H,
                const PostFeedsOptions(
                    icon: Icons.visibility_outlined, text: 'Audience'),
                const PostFeedsOptions(
                    isComment: true,
                    icon: Icons.comment,
                    text: 'Turn off Comment'),
              ],
            );
          },
        ),
      ),
    );
  }
}
