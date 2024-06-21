import 'package:flutter/material.dart';
import 'package:social_media_app/features/create_status/presentation/pages/create_statsus_page.dart';
import 'package:social_media_app/view_status_page.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        padding: const EdgeInsets.only(left: 10),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(10, (index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ViewStatusPage(),
                    ));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65.0,
                        decoration: const BoxDecoration(
                          color: Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Transform.translate(
                            offset: const Offset(15, 15),
                            child: IconButton(
                              icon: const Icon(Icons.add_circle,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const StatusCreationPage(),
                                ));
                              },
                            ),
                          ),
                        ),
                      ),
                      const Text('You')
                    ],
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 65,
                    height: 65.0,
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Colors.red,
                        width: 3.0,
                      ),
                    ),
                  ),
                  const Text('Dasha')
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
