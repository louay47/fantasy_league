class Player {
  int _playerID;
  String _firstName;
  String _lastName;
  String _position;
  int _team = 1;
  double _price = 0.0;
  int _points = 0;
  int _pointsWeek = 0;
  int _appearances = 0;
  int _subAppearances = 0;
  int _goals = 0;
  int _assists = 0;
  int _cleanSheets = 0;
  int _motms = 0;
  int _ownGoals = 0;
  int _redCards = 0;
  int _yellowCards = 0;
  bool _isFresher = false;
  String _image = "assets/shirt1.png";

  Player(this._playerID, this._firstName, this._lastName, this._position,
      this._team, this._price, this._points, this._pointsWeek,
      this._appearances, this._subAppearances, this._goals, this._assists,
      this._cleanSheets, this._motms, this._ownGoals, this._redCards,
      this._yellowCards, this._isFresher) {

    if (_position == ("Goalkeeper")) {
      this._image = "assets/goal.png";
    } else {
      this._image = "assets/shirt1.png";
    }

  }

   Player.fromJson(Map<String, dynamic> json) {

    _playerID = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _position = json['position'];
    _appearances = json['appearences'];
    _goals = json['goals'];
    _assists = json['assists'];
    _cleanSheets = json['clean_sheets'];
    _redCards = json['red_cards'];
    _yellowCards = json['yellow_cards'];
    _team = json['image'];
    if (_position == ("Goalkeeper")) {
      this._image = "assets/goal.png";
    } else {
      switch(_team.toString()) {
        case "980": {  this._image = "assets/shirt980.png"; }
        break;

        case "988": {  this._image = "assets/shirt988.png"; }
        break;

        case "986": {  this._image = "assets/shirt986.png";}
        break;

        case "990": {  this._image = "assets/shirt990.png"; }
        break;

        case "990": {  this._image = "assets/shirt984.png"; }
        break;
        case "983": {  this._image = "assets/shirt983.png"; }
        break;
        case "991": {  this._image = "assets/shirt991.png"; }
        break;

        case "981": {  this._image = "assets/shirt981.png"; }
        break;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._playerID;
    data['first_name'] = this._firstName;
    data['last_name'] = this._lastName;
    data['position'] = this._position;
    data['appearences'] = this._appearances;
    data['goals'] = this._goals;
    data['assists'] = this._assists;
    data['clean_sheets'] = this._cleanSheets;
    data['red_cards'] = this._redCards;
    data['yellow_cards'] = this._yellowCards;
    data['image'] = this._team;
    return data;
  }
  Player.empty() {
    this.image = "assets/shirt_blank.png";
    this.firstName = "first";
    this.lastName = "last";
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  bool get isFresher => _isFresher;

  set isFresher(bool value) {
    _isFresher = value;
  }

  int get yellowCards => _yellowCards;

  set yellowCards(int value) {
    _yellowCards = value;
  }

  int get redCards => _redCards;

  set redCards(int value) {
    _redCards = value;
  }

  int get ownGoals => _ownGoals;

  set ownGoals(int value) {
    _ownGoals = value;
  }

  int get motms => _motms;

  set motms(int value) {
    _motms = value;
  }

  int get cleanSheets => _cleanSheets;

  set cleanSheets(int value) {
    _cleanSheets = value;
  }

  int get assists => _assists;

  set assists(int value) {
    _assists = value;
  }

  int get goals => _goals;

  set goals(int value) {
    _goals = value;
  }

  int get subAppearances => _subAppearances;

  set subAppearances(int value) {
    _subAppearances = value;
  }

  int get appearances => _appearances;

  set appearances(int value) {
    _appearances = value;
  }

  int get pointsWeek => _pointsWeek;

  set pointsWeek(int value) {
    _pointsWeek = value;
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get teamAsString {
    String _suffix;
    switch (team) {
      case 1:
        _suffix = 'st';
        break;
      case 2:
        _suffix = 'nd';
        break;
      case 3:
        _suffix = 'rd';
        break;
      default:
            _suffix = 'th';
    }
    return _team.toString() + _suffix;
  }

  int get team => _team;

  set team(int value) {
    _team = value;
  }

  String get position => _position;

  set position(String value) {
    _position = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  int get playerID => _playerID;

  set playerID(int value) {
    _playerID = value;
  }

  String get fullName => _firstName + " " + _lastName;
}