import 'package:flutter/cupertino.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/features/status/domain/entities/color_entity.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/text_status_background_section/widgets/each_color.dart';

class EachColorRow extends StatelessWidget {
  const EachColorRow({super.key, required this.colorCubit});
  final SelectColorCubit colorCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.verticalExtraLarge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var colorData in ColorData.colorItems(colorCubit))
            Expanded(
              child: ColorSelectWidget(
                color: colorData.color,
                colorCubit: colorData.colorCubit,
              ),
            ),
        ],
      ),
    );
  }
}
