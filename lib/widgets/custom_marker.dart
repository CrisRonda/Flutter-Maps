part of 'widtgets.dart';

class CustomMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        _backButton(),
        Center(
          child: Transform.translate(
              offset: Offset(0, -37),
              child: Icon(
                Icons.location_on,
                size: 40,
                color: Theme.of(context).primaryColorDark,
              )),
        ),
        Positioned(
          bottom: 70,
          left: 40,
          child: MaterialButton(
            minWidth: width - 120,
            color: Colors.black,
            onPressed: () {},
            splashColor: Colors.transparent,
            elevation: 0,
            shape: StadiumBorder(),
            child: Text(
              "Confirmar destino",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Positioned _backButton() {
    return Positioned(
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.black,
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      top: 50,
      left: 16,
    );
  }
}
