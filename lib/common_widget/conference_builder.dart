import 'package:flutter/material.dart';
import 'package:easyconference/models/conference.dart';
import 'package:easyconference/services/database_service.dart';

class ConferenceBuilder extends StatelessWidget {
  const ConferenceBuilder({
    Key? key,
    required this.future,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);
  final Future<List<Conference>> future;
  final Function(Conference) onEdit;
  final Function(Conference) onDelete;

  Future<String> getAreaType(int id) async {
    final DatabaseService databaseService = DatabaseService();
    final area = await databaseService.area(id);
    return area.area;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conference>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final area = snapshot.data![index];
              return _buildConferenceCard(area, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildConferenceCard(Conference conference, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              alignment: Alignment.center,
              child: const Icon(Icons.post_add_rounded, size: 35.0),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conference.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  FutureBuilder<String>(
                    future: getAreaType(conference.areaId),
                    builder: (context, snapshot) {
                      return Text(' ${snapshot.data}');
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => onEdit(conference),
              child: Container(
                height: 40.0,
                width: 40.0,
                alignment: Alignment.center,
                child: Icon(Icons.edit, color: Colors.purple[800]),
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => onDelete(conference),
              child: Container(
                height: 40.0,
                width: 40.0,
                alignment: Alignment.center,
                child: Icon(Icons.delete, color: Colors.brown[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
