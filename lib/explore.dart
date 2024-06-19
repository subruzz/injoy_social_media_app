import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/textfields/text_field.dart';

class ExplorePage extends StatelessWidget {
  final _searchController = TextEditingController();

  ExplorePage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomTextField(
                    prefixIcon: Icons.search,
                    controller: _searchController,
                    showPrefixIcon: true,
                    showSuffixIcon: false,
                    hintText: 'Search ...',
                    obsecureText: false),
                AppSizedBox.sizedBox10H,
                const TabBar(
                  indicatorColor: Colors.red,
                  dividerColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.person)),
                    Tab(icon: Icon(Icons.explore)),
                    Tab(
                        icon: Icon(
                      Icons
                          .access_alarm, // This is the Material icon for hashtag
                    )),
                    Tab(icon: Icon(Icons.location_on_outlined)),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      PeopleSearch(),
                      Icon(Icons.directions_transit),
                      Icon(Icons.directions_bike),
                      Icon(Icons.directions_bike),
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

class PeopleSearch extends StatelessWidget {
  const PeopleSearch({super.key});

  @override
  Widget build(BuildContext context) {
        return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suggested for you',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.red,
                size: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}
