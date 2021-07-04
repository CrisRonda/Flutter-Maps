part of 'helpers.dart';

showAlert(
    {required BuildContext context,
    required String title,
    required String content,
    List<Widget>? actions}) {
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            content: Text(content),
            actions: actions ?? [],
          ));
}
