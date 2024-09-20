// import 'package:flutter/material.dart';

// import '../textfields/custom_textform_field.dart';

// class SearchFieldForExplore extends StatelessWidget {
//   const SearchFieldForExplore({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return     CustomTextField(
//                     onChanged: (value) {
//                       _debouncer.run(() {
//                         _isTextEntered.value = value.isNotEmpty;
//                         _performSearch();
//                       });
//                     },
//                     // prefixIcon: Icons.search,
//                     controller: _searchController,
//                     hintText: '${l10n!.search} ...',
//                   );
//   }
// }
