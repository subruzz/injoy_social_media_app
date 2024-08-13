import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/common/overlay_loading_holder.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/status/presentation/widgets/common/status_app_bar.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_multiple_status/multiple_status_input_bar.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets_indicator.dart';
import '../../../../core/widgets/messenger/messenger.dart';
import '../../../media_picker/presenation/pages/crop_image_page.dart';

class CreateMutlipleStatusPage extends StatefulWidget {
  const CreateMutlipleStatusPage(
      {super.key,
      required this.assets,
      this.isChat = false,
      this.getMessageCubit});
  final List<SelectedByte> assets;
  final bool isChat;
  final GetMessageCubit? getMessageCubit;

  @override
  State<CreateMutlipleStatusPage> createState() =>
      _CreateMutlipleStatusPageState();
}

class _CreateMutlipleStatusPageState extends State<CreateMutlipleStatusPage> {
  final PageController _pageController = PageController();
  final TextEditingController _captionController = TextEditingController();
  List<String> _captions = [];
  int _pageIndex = 0;
  final ValueNotifier<List<SelectedByte>> _selectedAssets = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
    _selectedAssets.value = widget.assets;
    // Initializing captions list with empty strings
    _captions = List.generate(widget.assets.length, (index) => '');
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    //controller will listen to change and update here
    //this for selecting different captions for differnt images
    _pageIndex = _pageController.page!.round();
    _captionController.text = _captions[_pageIndex];
  }

  void _onCaptionChanged(String value) {
    _pageIndex = _pageController.page!.round();
    // Updating the caption for the current page
    _captions[_pageIndex] = value;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: StatusAppBar(
        isChat: widget.isChat,
        suffixPressed: () async {
          if (widget.assets[_pageIndex].mediaType == MediaType.video) {
            return;
          }

          final croppedImage =
              await cropImage(widget.assets[_pageIndex].selectedFile!);
          //! use valuenotifier instead of setstate
          setState(() {
            widget.assets[_pageIndex].selectedFile = croppedImage;
          });
        },
        isTextStatus: false,
      ),
      body: BlocConsumer<StatusBloc, StatusState>(
        listenWhen: (previousState, state) {
          return state is StatusCreateLoading ||
              state is StatusCreateFailure ||
              state is StatusCreateSuccess;
        },
        listener: (context, state) {
          if (state is StatusCreateFailure) {
            Messenger.showSnackBar(message: l10n!.statusHiccupError);
          }
          if (state is StatusCreateSuccess) {
            Messenger.showSnackBar(message:l10n!.statusPostedSuccess);
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              //shows the selected assets
              SelectedAssetsSection(
                  pageController: _pageController,
                  selectedAssets: _selectedAssets.value),
              //shows the pageview indicator
              SelectedAssetsIndicator(
                  pageController: _pageController,
                  selectedAssets: _selectedAssets.value),
              //input bar for adding caption
              MultipleStatusInputBar(
                l10n: l10n!,
                isChat: widget.isChat,
                captionController: _captionController,
                alreadySelected: _selectedAssets.value,
                captions: _captions,
                onCaptionChanged: _onCaptionChanged,
              ),
              if (state is StatusCreateLoading)
                const OverlayLoadingHolder(
                  wantWhiteLoading: true,
                )
            ],
          );
        },
      ),
    );
  }
}
