import 'package:flutter/material.dart';
import '../../../models/user/user.dart';
import '../widgets/header_widget.dart';
import '../widgets/list_item.dart';

class MainList extends StatelessWidget {
  MainList({super.key});

  final List<User> users = [
    User(id: 'user1', name: 'Виктор Власов'),
    User(id: 'user2', name: 'Саша Алексеев'),
    User(id: 'user3', name: 'Петр Жаринов'),
    User(id: 'user4', name: 'Алина Жукова'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          HeaderWidget(
            title: 'Чаты',
            onSearchChanged: (String value) {
            },
            onSearchSubmitted: (String value) {
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListItem(user: users[index]);
              },
              childCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
