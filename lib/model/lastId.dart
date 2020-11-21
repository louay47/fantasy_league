class LastId {
  int id;

  LastId(this.id);

  static LastId _lastId ;

  LastId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
      print ("parse iddd");
    create(id);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,

      };


  static LastId get() {
    if (_lastId == null) {
      throw "User is null";
    }
    return _lastId;
  }

  static void create(int uid) {
    if (_lastId == null) {
      _lastId = new LastId(uid);
      print(_lastId.id);
    }
  }
}