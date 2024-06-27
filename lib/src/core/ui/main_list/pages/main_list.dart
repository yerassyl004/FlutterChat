import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/list_item.dart';

class MainList extends StatelessWidget {
  const MainList({super.key});

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
                return ListItem(index: index);
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
