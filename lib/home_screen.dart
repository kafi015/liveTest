import 'package:flutter/material.dart';
import 'package:livetaskostad/model.dart';
import 'package:livetaskostad/network_utils.dart';
import 'package:livetaskostad/snackbar_message.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiModel apiModel = ApiModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  bool inProgress = false;
  int start = 0;
  int end = 20;

  Future<void> getAllData() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils().getMethod(
        'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=$end.');

    if (response != null) {
      apiModel = ApiModel.fromJson(response);
    } else {
      showSnackBarMessage(
          MyApp.globalKey.currentContext!, 'Unable to fetch api! Try again!');
    }

    inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: inProgress
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: apiModel.data!.length,
              itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(apiModel.data![index].title ?? ''),
                      subtitle: Text(apiModel.data![index].body ?? ''),
                    );

              }),
    );
  }
}
