import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manguha/domain/use_cases/archive_note_use_case.dart';
import 'package:manguha/domain/use_cases/copy_note_use_case.dart';
import 'package:manguha/domain/use_cases/delete_note_use_case.dart';
import 'package:manguha/domain/use_cases/get_all_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/get_all_notes_use_case.dart';
import 'package:manguha/domain/use_cases/get_archived_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/get_archived_notes_use_case.dart';
import 'package:manguha/domain/use_cases/get_deleted_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/get_deleted_notes_use_case.dart';
import 'package:manguha/domain/use_cases/get_note_use_case.dart';
import 'package:manguha/domain/use_cases/get_pinned_notes_by_query_use_case.dart';
import 'package:manguha/domain/use_cases/get_pinned_notes_use_case.dart';
import 'package:manguha/domain/use_cases/load_gallery_image_use_case.dart';
import 'package:manguha/domain/use_cases/move_note_to_trash_use_case.dart';
import 'package:manguha/domain/use_cases/pin_note_use_case.dart';
import 'package:manguha/domain/use_cases/restore_note_from_trash_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_as_pdf_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_as_txt_use_case.dart';
import 'package:manguha/domain/use_cases/save_note_use_case.dart';
import 'package:manguha/domain/use_cases/search_use_case.dart';
import 'package:manguha/domain/use_cases/unarchive_note_use_case.dart';
import 'package:manguha/domain/use_cases/unpin_note_use_case.dart';

class DomainLayer extends StatelessWidget {
  final Widget child;

  const DomainLayer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (c) => SearchNoteUseCase()),
        RepositoryProvider(create: (c) => GetNoteUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetAllNotesUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetAllNotesByQueryUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetPinnedNotesUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetPinnedNotesByQueryUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetArchivedNotesUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetArchivedNotesByQueryUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetDeletedNotesUseCase(c.repository())),
        RepositoryProvider(create: (c) => GetDeletedNotesByQueryUseCase(c.repository())),
        RepositoryProvider(create: (c) => LoadGalleryImageUseCase()),
        RepositoryProvider(create: (c) => LoadGalleryImageUseCase()),
        RepositoryProvider(create: (c) => CopyNoteUseCase()),
        RepositoryProvider(create: (c) => SaveNoteUseCase(c.repository())),
        RepositoryProvider(create: (c) => ArchiveNoteUseCase(c.repository())),
        RepositoryProvider(create: (c) => UnarchiveNoteUseCase(c.repository())),
        RepositoryProvider(create: (c) => MoveNoteToTrashUseCase(c.repository())),
        RepositoryProvider(create: (c) => RestoreNoteFromTrashUseCase(c.repository())),
        RepositoryProvider(create: (c) => DeleteNoteUseCase(c.repository())),
        RepositoryProvider(create: (c) => PinNoteUseCase(c.repository())),
        RepositoryProvider(create: (c) => UnpinNoteUseCase(c.repository())),
        RepositoryProvider(create: (_) => SaveNoteAsTxtUseCase()),
        RepositoryProvider(create: (_) => SaveNoteAsPdfUseCase()),
      ],
      child: child,
    );
  }
}
