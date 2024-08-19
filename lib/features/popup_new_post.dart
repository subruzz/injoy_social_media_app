import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/web_design_const.dart';
import 'package:social_media_app/core/services/assets/asset_services.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/app_related/app_bar_common_icon.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import '../core/common/models/partial_user_model.dart';
import 'profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';

class PopupNewPostWeb extends StatefulWidget {
  const PopupNewPostWeb({super.key});

  @override
  State<PopupNewPostWeb> createState() => _PopupNewPostWebState();
}

class _PopupNewPostWebState extends State<PopupNewPostWeb> {
  final ValueNotifier<List<Uint8List>> _selectedPostImages = ValueNotifier([]);
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final _captionController = TextEditingController();

  @override
  void dispose() {
    _selectedPostImages.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _jumpToFirstPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOfScreen = MediaQuery.of(context).size;
    final isSmallScreen = sizeOfScreen.width < 750;
    final me = context.read<AppUserBloc>().appUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: const [AppBarCommonIcon()],
      ),
      backgroundColor: Colors.black38,
      body: GestureDetector(
        onTap: () {},
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: borderColor, width: 3),
            ),
            width:  sizeOfScreen.width * 0.8,
            height: sizeOfScreen.height * 0.8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const   Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create New Post',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _selectedPostImages,
                        builder: (context, value, child) {
                          return value.isNotEmpty
                              ? Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.read<CreatePostBloc>().add(
                                          CreatePostClickEvent(
                                            postImgesFromWeb: _selectedPostImages.value,
                                            postPics: const [],
                                            creatorUid: me.id,
                                            userFullName: me.fullName ?? '',
                                            username: me.userName ?? "",
                                            isCommentOff: false,
                                            description: _captionController.text.trim(),
                                            userProfileUrl: me.profilePic,
                                            isReel: false,
                                            hashtags: [],
                                            latitude: null,
                                            longitude: null,
                                            location: null,
                                          ),
                                        );
                                      },
                                      child: BlocConsumer<CreatePostBloc, CreatePostState>(
                                        builder: (context, state) {
                                          if (state is CreatePostLoading) {
                                            return const CircularLoading();
                                          }
                                          return const Text(
                                            'Post',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                        listener: (context, state) {
                                          if (state is CreatePostSuccess) {
                                            Navigator.pop(context);
                                            context.read<GetUserPostsBloc>().add(
                                              GetUserPostsrequestedEvent(
                                                user: PartialUser(
                                                  id: me.id,
                                                  userName: me.userName,
                                                  fullName: me.fullName,
                                                  profilePic: me.profilePic,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const EmptyDisplay();
                        },
                      )
                    ],
                  ),
                ),
                Divider(color: const Color.fromARGB(255, 34, 1, 1)),
                Expanded(
                  child: isSmallScreen
                      ? Column(
                          children: [
                            Expanded(
                              child: ValueListenableBuilder<List<Uint8List>>(
                                valueListenable: _selectedPostImages,
                                builder: (context, images, _) {
                                  if (images.isEmpty) {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            List<Uint8List>? selectedImages = await AssetServices.pickMultipleImagesAsBytes();
                                            if (selectedImages == null) return;
                                            _selectedPostImages.value = selectedImages;
                                            _jumpToFirstPage(); // Ensure this is called after the PageView is built
                                          } catch (e) {
                                            // Handle errors
                                            print('Error selecting images: $e');
                                          }
                                        },
                                        child: ColoredBox(
                                          color: Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Select Image',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Stack(
                                      children: [
                                        PageView.builder(
                                          controller: _pageController,
                                          itemCount: images.length,
                                          onPageChanged: _onPageChanged,
                                          itemBuilder: (context, index) {
                                            return Image.memory(fit: BoxFit.cover, images[index]);
                                          },
                                        ),
                                        if (_currentIndex > 0)
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: GestureDetector(
                                              child: Icon(Icons.arrow_back),
                                              onTap: () {
                                                _pageController.previousPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                            ),
                                          ),
                                        if (_currentIndex < images.length - 1)
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: GestureDetector(
                                              child: Icon(Icons.arrow_forward),
                                              onTap: () {
                                                _pageController.nextPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                controller: _captionController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Add caption',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ValueListenableBuilder<List<Uint8List>>(
                                valueListenable: _selectedPostImages,
                                builder: (context, images, _) {
                                  if (images.isEmpty) {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            List<Uint8List>? selectedImages = await AssetServices.pickMultipleImagesAsBytes();
                                            if (selectedImages == null) return;
                                            _selectedPostImages.value = selectedImages;
                                            _jumpToFirstPage(); // Ensure this is called after the PageView is built
                                          } catch (e) {
                                            // Handle errors
                                            print('Error selecting images: $e');
                                          }
                                        },
                                        child: ColoredBox(
                                          color: Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Select Image',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Stack(
                                      children: [
                                        PageView.builder(
                                          controller: _pageController,
                                          itemCount: images.length,
                                          onPageChanged: _onPageChanged,
                                          itemBuilder: (context, index) {
                                            return Image.memory(images[index]);
                                          },
                                        ),
                                        if (_currentIndex > 0)
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: GestureDetector(
                                              child: Icon(Icons.arrow_back),
                                              onTap: () {
                                                _pageController.previousPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                            ),
                                          ),
                                        if (_currentIndex < images.length - 1)
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: GestureDetector(
                                              child: Icon(Icons.arrow_forward),
                                              onTap: () {
                                                _pageController.nextPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                            VerticalDivider(),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.black,
                                height: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: TextField(
                                    controller: _captionController,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Add caption',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
