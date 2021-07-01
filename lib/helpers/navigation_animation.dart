part of 'helpers.dart';

Route navigationFadeIn(BuildContext context, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 440),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad)),
          child: child);
    },
  );
}
