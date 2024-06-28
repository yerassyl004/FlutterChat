import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;

  const HeaderWidget({
    super.key,
    required this.title,
    this.onSearchChanged,
    this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 72),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CupertinoSearchTextField(
            onChanged: onSearchChanged,
            onSubmitted: onSearchSubmitted,
          ),
        ),
      ),
    );
  }
}
