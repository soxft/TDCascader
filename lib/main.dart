import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int choose = 0;
  List<MockData> mockData = [];
  String msg = 'wait for data...';

  void init() {
    msg = 'fetching data...';
    setState(() {});
    Dio().get('https://jsonplaceholder.typicode.com/albums').then((value) {
      final data = value.data as List<dynamic>;

      mockData = data.map((e) => MockData.fromJson(e)).toList();
      msg = 'fetch data success';
      setState(() {});
    }).catchError((error) {
      msg = 'fetch data error: $error';
      setState(() {});
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(msg),
            const Padding(padding: EdgeInsets.all(8)),
            Text('choose: ${mockData.firstWhere((element) => element.id == choose, orElse: () => MockData.empty()).title}'),
            const Padding(padding: EdgeInsets.all(8)),
            TDButton(
              onTap: () {
                Future.delayed(const Duration(seconds: 1), init);
                Navigator.of(context).push(
                  TDSlidePopupRoute(
                    modalBarrierColor: TDTheme.of(context).fontGyColor2,
                    slideTransitionFrom: SlideTransitionFrom.top,
                    builder: (context) {
                      return TDPopupBottomDisplayPanel(
                        title: '标题',
                        hideClose: true,
                        child: TDSideBar(
                          height: 300,
                          value: choose,
                          children: mockData
                              .map(
                                (e) => TDSideBarItem(
                                  label: e.title,
                                  value: e.id,
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              )
                              .toList(),
                          onSelected: (value) {
                            choose = value;
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              text: 'Click Me!',
            ),
          ],
        ),
      ),
    );
  }
}

class MockData {
  final int id;
  final String title;
  MockData({
    required this.id,
    required this.title,
  });

  factory MockData.fromJson(Map<String, dynamic> json) {
    return MockData(
      id: json['id'],
      title: json['title'],
    );
  }

  factory MockData.empty() {
    return MockData(id: 0, title: 'null');
  }
}
