

class Note {
  static const TABLE_NAME = "notes";
  static const ID = "id";
  static const TITLE = "title";
  static const CONTENT = "content";
  static const IS_PINNED = "is_pinned";
  static const IS_DELETED = "is_deleted";
  static const IS_ARCHIVED = "is_archived";
  static const IMAGE = "image";
  static const LAST_UPDATE = "lastUpdate";

  final int id;
  String title;
  String content;
  bool isPinned;
  bool isDeleted;
  bool isArchived;
  String image;
  DateTime lastUpdate;

  Note._(
    this.id,
    this.title,
    this.content,
    this.isPinned,
    this.isDeleted,
    this.isArchived,
    this.image,
    this.lastUpdate,
  );

  Note.create()
      : this._(
          null,
          "",
          "",
          false,
          false,
          false,
          "",
          DateTime.now(),
        );

  Map<String, dynamic> toMap() {
    return {
      ID: id,
      TITLE: title,
      CONTENT: content,
      IS_PINNED: isPinned ? 1 : 0,
      IS_DELETED: isDeleted ? 1 : 0,
      IS_ARCHIVED: isArchived ? 1 : 0,
      IMAGE: image,
      LAST_UPDATE: lastUpdate.millisecondsSinceEpoch,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note._(
      map[ID] as int,
      map[TITLE] as String,
      map[CONTENT] as String,
      map[IS_PINNED] as int == 1,
      map[IS_DELETED] as int == 1,
      map[IS_ARCHIVED] as int == 1,
      map[IMAGE] as String,
      DateTime.fromMillisecondsSinceEpoch(map[LAST_UPDATE]),
    );
  }
}
