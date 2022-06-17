class Note {
  final int orderNumber;
  final int line;
  NoteState state = NoteState.ready;
  NoteColor color = NoteColor.black;

  Note(this.orderNumber, this.line);
}

enum NoteState { ready, tapped, missed }
enum NoteColor { black, transparent }
