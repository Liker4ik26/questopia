import 'package:flutter/material.dart';
import 'package:questopia/core/common/main/widgets/main_navigation_bar.dart';
import '../../app/navigation/routes.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: MainNavigationBar(
        currentIndex: child.currentIndex,
        onChanged: (ind) {
          child.goBranch(
            ind,
            initialLocation: true,
          );
        },
      ),
    );
  }
}
