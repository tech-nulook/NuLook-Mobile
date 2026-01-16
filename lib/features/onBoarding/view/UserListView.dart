import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  final ScrollController scrollController;
  final List images;

  const UserListView({required this.scrollController, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                '${images[index]}',
                width: 200,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
