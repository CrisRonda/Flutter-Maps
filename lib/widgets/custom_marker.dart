part of 'widtgets.dart';

class CustomMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final searchLocationBloc = BlocProvider.of<SearchLocationBloc>(context);

    return Stack(
      children: [
        _backButton(searchLocationBloc),
        Center(
          child: Transform.translate(
              offset: Offset(0, -20),
              child: BounceInDown(
                from: 200,
                duration: Duration(seconds: 2),
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: Theme.of(context).primaryColorDark,
                ),
              )),
        ),
        Positioned(
          bottom: 20,
          left: 40,
          child: FadeInUp(
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
          ),
        )
      ],
    );
  }

  Positioned _backButton(SearchLocationBloc searchLocationBloc) {
    return Positioned(
      child: FadeInLeft(
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()=> searchLocationBloc.add(OnDisableSelectLocation()),
          ),
        ),
      ),
      top: 50,
      left: 16,
    );
  }
}
