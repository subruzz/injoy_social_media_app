import 'package:flutter/cupertino.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/text_status_background_section/widgets/content_input_field.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/text_status_background_section/widgets/each_color_row.dart';

class CreateTextStatusBackground extends StatelessWidget {
  const CreateTextStatusBackground(
      {super.key, required this.colorCubit, required this.captionController});
  final SelectColorCubit colorCubit;
  final TextEditingController captionController;
  @override
  //shows the background based on the color selected
  Widget build(BuildContext context) {
    return Container(
      color: colorCubit.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
                child: TextStatusInputField(
                    controller: captionController,
                  )),
          ),
           EachColorRow(colorCubit: colorCubit,),
        ],
      ),
    );
  }
}
