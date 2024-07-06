import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/animated/animated_border.dart';
import 'package:social_media_app/core/widgets/animated/border_widget.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/status/create_status_button.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/pages/view_status_page.dart';

import '../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../core/widgets/user_profile.dart';
import '../../../../status/presentation/pages/create_status_page.dart';

class MyStatusView extends StatefulWidget {
  const MyStatusView({super.key});

  @override
  State<MyStatusView> createState() => MyStatusViewState();
}

class MyStatusViewState extends State<MyStatusView> {
  bool isAnimating = false;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser!;
    return BlocBuilder<GetMyStatusBloc, GetMyStatusState>(
      builder: (context, state) {
        return Padding(
          padding: AppPadding.only(left: 25, right: 15),
          child: Column(
            children: [
              // BlocListener<StatusBloc, StatusState>(
              //   listenWhen: (previous, current) => mounted,
              //   listener: (context, state) {
              //     if (state is StatusCreateLoading) {
              //       setState(() {
              //         isAnimating = true;

              //         _animationController?.repeat();
              //       });
              //     } else {
              //       setState(() {
              //         isAnimating = false;
              //         _animationController?.reset();
              //       });
              //     }
              //     if (state is StatusCreateSuccess) {
              //       Messenger.showSnackBar(
              //           message: AppSuccessMsg.statusCreatedSuccess);
              //     }
              //   },
              //   child:
              AnimatedLoadingBorder(
                cornerRadius: 50,
                borderColor: const Color.fromARGB(255, 255, 0, 85),
                borderWidth: 10,
                controller: (animationController) {
                  _animationController = animationController;
                  if (isAnimating) {
                    _animationController?.repeat();
                  } else {
                    _animationController?.stop();
                  }
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomPaint(
                      painter: StatusDottedBordersWidget(
                        isLoading: isAnimating,
                        numberOfStories: state is GetMyStatusSuccess
                            ? state.myStatus.length
                            : 0,
                        isMe: true,
                        spaceLength: 6,
                        images:
                            state is GetMyStatusSuccess ? state.myStatus : [],
                        uid: context.read<AppUserBloc>().appUser!.id,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            if (state is GetMyStatusSuccess &&
                                state.myStatus.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewStatusPage(
                                  isMe: true,
                                  index: 0,
                                  myStatues: state.myStatus,
                                ),
                              ));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const StatusCreationPage(),
                              ));
                            }
                          },
                          child: Hero(
                            tag: user.id,
                            child: CircularUserProfile(
                              profile: user.profilePic,
                            ),
                          )),
                    ),
                    if (!isAnimating) const CreateStatusButton()
                  ],
                ),
              ),
              AppSizedBox.sizedBox5H,
              const Text('You')
            ],
          ),
        );
      },
    );
  }
}
