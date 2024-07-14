import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

class SearchEmptyErrorText extends StatelessWidget {
  const SearchEmptyErrorText(
      {super.key,  this.query, this.isError = false});
  final String? query;

  final bool isError;
  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      padding: AppPadding.medium,
      child: CustomText(
        isError ? 'oops,something went wrong' : 'No result found for "$query"',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
      ),
    );
  }
}
