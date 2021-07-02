part of 'widtgets.dart';

class CustomFloattingActionButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const CustomFloattingActionButton({this.icon= Icons.my_location, required this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade700,
        maxRadius: 25,
        child: IconButton(
          onPressed: ()=> this.onPressed(),
          icon: Icon(
            this.icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
