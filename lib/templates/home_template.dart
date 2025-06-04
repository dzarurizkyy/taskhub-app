import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskhub_app/models/note.dart';
import 'package:taskhub_app/bloc/class/note_bloc.dart';
import 'package:taskhub_app/bloc/event/note_event.dart';
import 'package:taskhub_app/bloc/state/note_state.dart';
import 'package:taskhub_app/widgets/tabbar/note_tabbar.dart';
import 'package:taskhub_app/widgets/header/home_page_header.dart';
import 'package:taskhub_app/widgets/bottom/navigation_bar_bottom.dart';

class Home extends StatelessWidget {
  final String name;
  final String gender;

  Home({super.key, required this.name, required this.gender});

  final _isSearchController = StreamController<bool>.broadcast();
  final _selectedTabController = StreamController<int>.broadcast();
  final _searchController = TextEditingController();
  final _priority = ["All", "High", "Medium", "Low"];

  void _handleSearch(BuildContext context, String value, List<Note> notes) {
    if (value.isNotEmpty) {
      _isSearchController.add(true);
      context.read<NoteBloc>().add(SearchNote(value));
    } else {
      _isSearchController.add(false);
      context.read<NoteBloc>().add(FetchNotes());
    }
  }

  @override
  Widget build(BuildContext context) {
  

    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoading) {
          
          return Scaffold(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            body: Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(1000, 32, 180, 224),
              ),
            ),
          );
        } else if (state is NoteLoaded) {
          return StreamBuilder<bool>(
            initialData: false,
            stream: _isSearchController.stream,
            builder: (context, isSearchSnapshot) {
              return StreamBuilder<int>(
                initialData: 0,
                stream: _selectedTabController.stream,
                builder: (context, tabIndexSnapshot) {
                  final isSearch = isSearchSnapshot.data!;
                  final selectedTabIndex = tabIndexSnapshot.data!;
                  return DefaultTabController(
                    length: _priority.length,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(isSearch ? 180 : 220),
                        child: HomePageHeader(
                          name: name,
                          gender: gender,
                          time: DateTime.now(),
                          controller: _searchController,
                          handler: (val) => _handleSearch(
                            context,
                            val,
                            state.notes,
                          ),
                          isSearch: isSearch,
                          priority: _priority,
                          onTabChanged: (index) {
                            _selectedTabController.add(index);
                          },
                        ),
                      ),
                      body: NoteTabbar(
                        isSearch: isSearch,
                        notes: state.notes,
                        selectedTabIndex: selectedTabIndex,
                      ),
                      extendBody: true,
                      bottomNavigationBar: BottomNavbar(),
                      backgroundColor: const Color.fromRGBO(252, 250, 250, 1),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is NoteError) {
          return SizedBox(
            child: Text(state.message),
          );
        }
        return Text("Hello $state");
      },
    );
  }
}
