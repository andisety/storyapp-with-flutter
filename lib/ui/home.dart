import 'package:flutter/material.dart';
import 'package:story_app/model/model.dart';

import '../repository/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ListStory>> listStory;
  final Repository repository = Repository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listStory = repository.getStory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("oke"),
      ),
    );
  }
}
