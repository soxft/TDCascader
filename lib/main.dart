import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const deptList = [
      {
        "label": '技术部门',
        "value": '110000',
        "children": [
          {
            "value": '110100',
            "label": '部门一',
            "children": [
              {"value": '110101', "label": '洪磊', "segmentValue": 'H'},
              {"value": '110102', "label": '洪磊2', "segmentValue": 'H'},
              {"value": '1101022', "label": '洪磊3', "segmentValue": 'H'},
              {"value": '110105', "label": '洪磊4', "segmentValue": 'H'},
              {"value": '110106', "label": '郭天1', "segmentValue": 'G'},
              {"value": '110107', "label": '郭天2', "segmentValue": 'G'},
              {"value": '110108', "label": '郭天3', "segmentValue": 'G'},
              {"value": '110109', "label": '冯笑1', "segmentValue": 'F'},
            ],
          },
          {
            "value": '110200',
            "label": '部门二',
            "children": [
              {"value": '110201', "label": '张雷1'},
              {"value": '110202', "label": '张雷2'},
              {"value": '1102022', "label": '张雷3'},
              {"value": '110205', "label": '张雷4'},
              {"value": '110206', "label": '张雷5'},
              {"value": '110207', "label": '张雷6'},
              {"value": '110208', "label": '张雷7'},
              {"value": '110209', "label": '张雷8'},
            ],
          },
        ],
      },
      {
        "label": '行政部门',
        "value": '120000',
        "children": [
          {
            "value": '120100',
            "label": '部门一',
            "children": [
              {
                "value": '120101',
                "label": '张雷1',
                "children": [
                  {"value": '12010101', "label": '张雷1-1'},
                ],
              },
              {"value": '120102', "label": '张雷2'},
              {"value": '120103', "label": '张雷3'},
              {"value": '120104', "label": '张雷4'},
              {"value": '120105', "label": '张雷5'},
              {"value": '120106', "label": '张雷6'},
              {"value": '120110', "label": '张雷7'},
              {"value": '120111', "label": '张雷8'},
              {"value": '120112', "label": '张雷9'},
            ],
          },
        ],
      },
    ];
    final deptSelect = useState<String>("");
    final deptInitData = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                TDCascader.showMultiCascader(
                  context,
                  title: '选择部门',
                  data: deptList,
                  initialData: deptInitData.value,
                  theme: 'step',
                  onChange: (List<MultiCascaderListModel> selectData) {
                    List result = [];
                    int len = selectData.length;
                    deptInitData.value = selectData[len - 1].value!;
                    selectData.forEach((element) {
                      result.add(element.label);
                    });
                    deptSelect.value = result.join('/');
                  },
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                );
              },
              child: buildSelectRow(context, deptSelect.value, '选择部门'),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildSelectRow(BuildContext context, String output, String title) {
  return Container(
    color: TDTheme.of(context).whiteColor1,
    height: 56,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: TDText(
                title,
                font: TDTheme.of(context).fontBodyLarge,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TDText(
                        output,
                        font: TDTheme.of(context).fontBodyLarge,
                        textColor: TDTheme.of(context).fontGyColor3.withOpacity(0.4),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Icon(
                        TDIcons.chevron_right,
                        color: TDTheme.of(context).fontGyColor3.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const TDDivider(
          margin: EdgeInsets.only(
            left: 16,
          ),
        )
      ],
    ),
  );
}
