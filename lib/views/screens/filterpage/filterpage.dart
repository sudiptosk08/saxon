import 'package:flutter/material.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  SfRangeValues _values = const SfRangeValues(0, 1000);
  bool isChecked = false;
  // ignore: prefer_typing_uninitialized_variables
  var selectIndex;
  // ignore: prefer_typing_uninitialized_variables
  var brandIndex;
  // ignore: prefer_typing_uninitialized_variables
  var selectColorIndex;
  List<Map<String, dynamic>> myOrder = [
    {"text": "XS"},
    {"text": "M"},
    {"text": "L"},
    {"text": "XL"},
  ];
  List<Map<String, dynamic>> brand = [
    {"text": "Zara"},
    {"text": "Nike"},
    {"text": "Pata"},
  ];
  List<Map<String, dynamic>> colors1 = [
    {"color1": KColor.blue},
    {"color1": KColor.red},
    {"color1": KColor.green},
    {"color1": KColor.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      appBar: AppBar(
        backgroundColor: KColor.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: KColor.appBarTitle,
          ),
          iconSize: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.times,
              color: KColor.appBarTitle,
            ),
            iconSize: 20,
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(KSize.getWidth(context, 11)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: KSize.getWidth(context, 17)),
                child: Text("Filter", style: KTextStyle.headline4.copyWith(color: KColor.bodyTitle)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: KSize.getWidth(context, 18), top: KSize.getWidth(context, 18)),
                    child: Text(
                      "PRICE RANGE",
                      style: KTextStyle.subtitle2.copyWith(
                        color: KColor.drawerItem,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(KSize.getWidth(context, 4)),
                    child: SfRangeSlider(
                      min: 0,
                      max: 1000,
                      values: _values,
                      interval: 20,
                      showTicks: false,
                      showLabels: false,
                      enableTooltip: true,
                      tooltipShape: const SfPaddleTooltipShape(),

                      //tooltipTextFormatterCallback: ,
                      minorTicksPerInterval: 1,
                      onChanged: (SfRangeValues values) {
                        setState(() {
                          _values = values;
                        });
                      },
                      activeColor: KColor.primary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: KSize.getWidth(context, 18), top: KSize.getWidth(context, 15), right: KSize.getWidth(context, 18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BRANDS",
                      style: KTextStyle.subtitle2.copyWith(
                        color: KColor.drawerItem,
                      ),
                    ),
                    Text(
                      "Select All",
                      style: KTextStyle.subtitle2.copyWith(color: KColor.accentColor, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ...List.generate(
                      brand.length,
                      (index) => Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectIndex = index;
                                    //newChecked = false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: KSize.getWidth(context, 18), top: KSize.getWidth(context, 12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(KSize.getWidth(context, 5)),
                                        child: Text(
                                          brand[index]['text'],
                                          style: KTextStyle.bodyText2.copyWith(
                                            color: selectIndex == index ? KColor.primary : KColor.accentColor,
                                          ),
                                        ),
                                      ),
                                      selectIndex == index
                                          ? Padding(
                                              padding: EdgeInsets.only(right: KSize.getWidth(context, 25)),
                                              child: const Icon(
                                                Icons.check,
                                                color: KColor.primary,
                                              ))
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: KSize.getWidth(context, 18), right: KSize.getWidth(context, 18)),
                                child: const Divider(
                                  color: KColor.accentColor,
                                  thickness: 0.6,
                                  height: 3,
                                  endIndent: 2,
                                  indent: 1,
                                ),
                              )
                            ],
                          ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, top: 20, right: 18),
                child: Text(
                  "SIZES",
                  style: KTextStyle.subtitle2.copyWith(color: KColor.drawerItem),
                ),
              ),
              Row(children: [
                ...List.generate(
                    myOrder.length,
                    (index) => Padding(
                        padding: const EdgeInsets.only(left: 18.5, top: 15),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                brandIndex = index;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 52,
                              width: 53,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: brandIndex == index ? KColor.primary : KColor.grey200,
                              ),
                              child: Text(
                                myOrder[index]['text'],
                                style: KTextStyle.bodyText2.copyWith(color: brandIndex == index ? KColor.white : KColor.black),
                              ),
                            )))),
              ]),
              Padding(
                padding: EdgeInsets.only(left: 18, top: 20, right: 18),
                child: Text(
                  "COLOR",
                  style: KTextStyle.subtitle2.copyWith(color: KColor.drawerItem),
                ),
              ),
              Row(children: [
                ...List.generate(
                    colors1.length,
                    (index) => Padding(
                        padding: const EdgeInsets.only(left: 18.5, top: 15),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectColorIndex = index;
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 52,
                                width: 53,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: colors1[index]['color1'],
                                ),
                                child: selectColorIndex == index
                                    ? const Icon(
                                        Icons.check,
                                        color: KColor.white,
                                      )
                                    : Container())))),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: KSize.getHeight(context, 15),
          right: KSize.getHeight(context, 15),
          top: KSize.getHeight(context, 5),
          bottom: KSize.getHeight(context, 5),
        ),
        child: KButton(
          getWidth: KSize.getWidth(context, 180),
          getHeight: KSize.getHeight(context, 55),
          containerColor: KColor.primary,
          borderColor: KColor.primary,
          kbuttonTap: () {},
          txtcolor: KColor.white,
          text: "Apply",
        ),
      ),
    );
  }
}
