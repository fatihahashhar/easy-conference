import 'package:easyconference/Screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easyconference/common_widget/conference_builder.dart';
import 'package:easyconference/models/conference.dart';
import 'package:easyconference/pages/conference_form_page.dart';
import 'package:easyconference/services/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Conference>> _getConference() async {
    return await _databaseService.conference_info();
  }

  Future<void> _onConferenceDelete(Conference conference) async {
    await _databaseService.deleteConferenceInfo(conference.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conference List'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            ConferenceBuilder(
              future: _getConference(),
              onEdit: (value) {
                {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => ConferenceFormPage(conference: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }
              },
              onDelete: _onConferenceDelete,
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => const ConferenceFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addConferenceInfo',
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
            const SizedBox(height: 24.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              child: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
