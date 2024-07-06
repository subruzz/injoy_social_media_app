import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';

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
                    Tab(icon: FaIcon(FontAwesomeIcons.hashtag)),
                    Tab(icon: Icon(Icons.location_on_outlined)),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      PeopleSearch(),
                      const Icon(Icons.directions_transit),
                      HashtagList(),
                      LocationList()
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
  PeopleSearch({super.key});
  final List<Map<String, String>> suggestions = [
    {
      'name': 'Alexandra',
      'image':
          'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg',
    },
    {
      'name': 'Dasha Taran',
      'image':
          'https://img.freepik.com/premium-photo/there-is-cat-that-is-sitting-ledge-chinese-garden-generative-ai_900396-35755.jpg',
    },
    {
      'name': 'Rohan Philips',
      'image':
          'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suggested for you',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.red,
                size: 40,
              )
            ],
          ),
        ),
        SizedBox(height: 20), // Add some space between the text and the cards
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SuggestedCard(
                  name: suggestions[index]['name']!,
                  imageUrl: suggestions[index]['image']!,
                ),
              );
            },
          ),
        ),
        AppSizedBox.sizedBox20H,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'People near you',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Icon(
              Icons.keyboard_double_arrow_right,
              color: Colors.red,
              size: 40,
            )
          ],
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SuggestedCard(
                  name: suggestions[index]['name']!,
                  imageUrl: suggestions[index]['image']!,
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class SuggestedCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const SuggestedCard({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class HashtagList extends StatelessWidget {
  final List<Map<String, String>> hashtags = [
    {
      'hashtag': '#flutter',
      'posts': '2.1M posts',
    },
    {
      'hashtag': '#Dart',
      'posts': '2.1M posts',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      itemCount: hashtags.length,
      itemBuilder: (context, index) {
        final hashtag = hashtags[index];
        return HashtagListItem(
          hashtag: hashtag['hashtag']!,
          posts: hashtag['posts']!,
        );
      },
    );
  }
}

class HashtagListItem extends StatelessWidget {
  final String hashtag;
  final String posts;

  const HashtagListItem({
    Key? key,
    required this.hashtag,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.pink,
            radius: 24,
            child: Text(
              '#',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hashtag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                posts,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LocationList extends StatelessWidget {
  final List<Map<String, String>> hashtags = [
    {
      'name': 'Trivandrum',
      'posts': '2.1M posts',
    },
    {
      'name': 'Kollam',
      'posts': '2.1M posts',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      itemCount: hashtags.length,
      itemBuilder: (context, index) {
        final hashtag = hashtags[index];
        return HashtagListItem(
          hashtag: hashtag['name']!,
          posts: hashtag['posts']!,
        );
      },
    );
  }
}

class LocationListItem extends StatelessWidget {
  final String location;
  final String posts;

  const LocationListItem({
    Key? key,
    required this.location,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          const CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 24,
              child: Icon(Icons.location_on_outlined)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                posts,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
