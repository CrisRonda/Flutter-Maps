part of 'widtgets.dart';

class ButtonCenterLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final userLocationBloc = BlocProvider.of<UserLocationBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade700,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            mapBloc.returnInitialLocation(userLocationBloc.state.location!);
          },
          icon: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
