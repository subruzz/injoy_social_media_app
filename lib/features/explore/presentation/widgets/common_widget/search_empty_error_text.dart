import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';

class ExploreFieldMessages extends StatelessWidget {
  const ExploreFieldMessages({super.key, this.query, this.isError = false});
  final String? query;

  final bool isError;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomAppPadding(
      padding: AppPadding.medium,
      child: CustomText(
        text:    isError ? l10n!.somethingWentWrong : l10n!.noResultFound('"$query"'),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
      ),
    );
  }
}
