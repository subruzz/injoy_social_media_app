import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/welcome_card/common_widgets/welcome_card_msg.dart';
import '../widgets/welcome_card/common_widgets/welcome_user_card.dart';

class WelcomeCard extends StatefulWidget {
  const WelcomeCard({super.key, required this.allUsers});
  final List<PartialUser> allUsers;
  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  final PageController pageController = PageController(viewportFraction: 0.8);
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const WelcomeCardMessage(),
      Expanded(
        child: PageView.builder(
          onPageChanged: (index) {
            _indexNotifier.value = index;
          },
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          itemCount: widget.allUsers.length,
          itemBuilder: (context, index) {
            return Center(
              child: WelcomeUserCard(
                index: index,
                user: widget.allUsers[index],
                isActive: _indexNotifier,
              ),
            );
          },
        ),
      )
    ]);
  }
}
