import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_info_msg.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';

class StatusDeletePopup extends StatelessWidget {
  const StatusDeletePopup({super.key, required this.deleteStatus});
  final VoidCallback deleteStatus;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteStatusBloc, DeleteStatusState>(
      listener: (context, state) {
        if (state is StatusDeleteLoading) {
          Navigator.pop(context);
          Messenger.showSnackBar(message: AppIngoMsg.statusDeleting);
        }
      },
      child: PopupMenuButton(
        child: const Icon(Icons.more_horiz),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap:deleteStatus,
              child: const Text('Delete'),
            ),
          ];
        },
      ),
    );
  }
}
