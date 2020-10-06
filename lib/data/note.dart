class Note {
  static const TABLE_NAME = "notes";
  static const ID = "id";
  static const TITLE = "title";
  static const CONTENT = "content";
  static const IS_PINNED = "is_pinned";
  static const LAST_UPDATE = "lastUpdate";

  final int id;
  String title;
  String content;
  bool isPinned;
  DateTime lastUpdate;

  //TODO parse by datetimeformat
  String get dmy => "${lastUpdate.day}.${lastUpdate.month}.${lastUpdate.year}";

  String get hm => "${lastUpdate.hour}:${lastUpdate.minute}";

  Note._(this.id, this.title, this.content, this.isPinned, this.lastUpdate);

  Note.create() : this._(null, "", "", false, DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      ID: id,
      TITLE: title,
      CONTENT: content,
      IS_PINNED: isPinned,
      LAST_UPDATE: lastUpdate.millisecondsSinceEpoch,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note._(
      map[ID] as int,
      map[TITLE] as String,
      map[CONTENT] as String,
      map[IS_PINNED] as int == 1,
      DateTime.fromMillisecondsSinceEpoch(map[LAST_UPDATE]),
    );
  }
}
