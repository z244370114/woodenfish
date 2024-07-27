class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (json == null) {
      return null;
    }
    // else if (T.toString() == 'DatasModel') {
    //   return DatasModel.fromJson(json) as T;
    // }
    else {
      return json;
    }
  }
}
