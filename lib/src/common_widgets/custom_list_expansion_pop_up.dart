import 'dart:convert';
import 'dart:developer';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomExpansionListTexts extends StatefulWidget {
  CustomExpansionListTexts({super.key, this.getLocationsresponse, this.onTap});
  GetLocations? getLocationsresponse;
  final Function? onTap;
  @override
  State<CustomExpansionListTexts> createState() =>
      CustomExpansionListTextsState();
}

class CustomExpansionListTextsState extends State<CustomExpansionListTexts> {
  //late Future<http.Response> _responseFuture;
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;

  @override
  void initState() {
    super.initState();
    //final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    //Uri.https(url);
    // _responseFuture = http.get(url);
  }

  // Search Widget
  Widget searchWidget() {
    return SearchWidget(
      controller: _searchCtrl,
      hintText: Constants.searchHintText,
      textInputFieldKey: Keys.searchInputField,
      leadingIcon: AppIcon.searchIcon,
      border: borderColor,
      isEnabled: false,
      focusChange: (bool focus) {
        if (focus) {
          borderColor = AppColors.navigationSkybluecolor;
        } else {
          borderColor = AppColors.textgreyThemecolor;
        }
        setState(() {});
      },
      onSubmit: (String txt) {
        if (txt.trim().length >= 15) {
        } else {
          //Show error message for validations
        }
        _searchCtrl.text = txt;
      },
    );
  }

  Widget expansionListWidget() {
    print(widget.getLocationsresponse!.west);
    if (widget.getLocationsresponse != null && widget.getLocationsresponse!.west != null) {
      return Expanded(
          child:
              //FutureBuilder(
              // future: _responseFuture,
              // builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
              //   if (!response.hasData) {
              //     return const Center(
              //       child: const Text('Loading...'),
              //     );
              //   } else if (response.data?.statusCode != 200) {
              //     return const Center(
              //       child: const Text('Error loading data'),
              //     );
              //   } else {
              // List<dynamic> json = JSON.decode(response.data?.body);
              // List<dynamic> json = jsonDecode(response.data!.body);

              MyExpansionTileList(widget.getLocationsresponse, widget.onTap)
          //}
          //},

          // ),
          );
    } else {
      return const Expanded(
        child: Center(
          child: Text(
            Constants.nodata,
            style: Styles.textStyleRegularGrey16,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Center(
        child: Container(
      height: height / 1.5,
      width: width - 50,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
          borderRadius: circularBorderRadius10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                              AppIcon.closeicon) //Icon(Icons.cancel)
                          )),
                ),
                // (widget.getLocationsresponse != null && widget.getLocationsresponse!.west != null) 
                // ? searchWidget() : Container(),
                expansionListWidget()
              ]),
        ),
      ),
    ));
  }
}

class MyExpansionTileList extends StatefulWidget {
  MyExpansionTileList(this.response, this.onTap);
  GetLocations? response;
  final Function? onTap;
  @override
  State<MyExpansionTileList> createState() => MyExpansionTileListState();
}

class MyExpansionTileListState extends State<MyExpansionTileList> {
  int selectedindex = -1;
  String selectedtitle = '';
  // List<Widget> _getChildren() {
  //   List<Widget> children = [];
  //   response?.west?.forEach((element) {
  //     children.add(
  //       MyExpansionTile(element.id ?? 0, element.name ?? '','West'),
  //     );
  //   });
  //   return children;
  // }

  @override
  Widget build(BuildContext context) {
    //   return ListView(
    //     children: _getChildren(),
    //   );
    // }
    return ListView(
      // key: Key(selectedtitle.toString()),
      // initiallyExpanded: selectedtitle == title,
      children: <Widget>[
        _buildPlayerModelList(widget.response!.west, 'West', context),
        _buildPlayerModelList(widget.response!.south, 'South', context),
        _buildPlayerModelList(
            widget.response!.northEast, 'North East', context),
        _buildPlayerModelList(widget.response!.mumbai, 'Mumbai', context),
      ],
    );
  }

  Widget _buildPlayerModelList(
      List<Mumbai>? items, String title, BuildContext context) {
    return ExpansionTile(
        trailing: SizedBox.shrink(),
        key: GlobalKey(),
        initiallyExpanded: selectedtitle == title,
        onExpansionChanged: (value) {
          if (value == true) {
            selectedtitle = title;
            selectedindex = -1;
            setState(() {});
          } else {
            selectedtitle = '';
            selectedindex = -1;
            setState(() {});
          }
        },
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        children: _buildOperationsFromSecurity(context, items, title));
  }

  List<Widget> _buildOperationsFromSecurity(
      BuildContext context, List<Mumbai>? items, String stitle) {
    List<Widget> children = [];

    for (int i = 0; i < items!.length; i++) {
      Mumbai drawerItem = items[i];
      children.add(
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Container(
            // decoration: const BoxDecoration(
            //   //                    <-- BoxDecoration
            //   border: Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
            // ),
            child: ExpansionTile(
              key: Key(i.toString()),
              initiallyExpanded: selectedindex == i,
              onExpansionChanged: (value) {
                if (value == true) {
                  selectedindex = i;
                  setState(() {});
                } else {
                  selectedindex = -1;
                  setState(() {});
                }
              },
              //col: Colors.transparent,
              expandedAlignment: Alignment.centerLeft,
              trailing: const SizedBox.shrink(),
              title: ListTile(
                title: Text(
                  drawerItem.name ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.customFontSemiBoldFamily,
                      fontWeight: FontWeight.w600,
                      color: ((i == selectedindex) && (stitle == selectedtitle))
                          ? AppColors.navigationSkybluecolor
                          : AppColors.textgreyThemecolor),
                  // style: Styles.textStyleBlack16,
                ),
                onTap: () => _onExpansionSelectItem(i, context, items),
              ),

              childrenPadding: EdgeInsets.only(left: 20), //children padding
              //children: _expansionbuildDrawerChildren(context)
            ),
          ),
        ),
      );
    }

    return children;
  }

  _onExpansionSelectItem(
      int index, BuildContext context, List<Mumbai>? items) async {

    selectedindex = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    Mumbai? drawerItem = items?[index];
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
    widget.onTap!(drawerItem);
    Navigator.of(context).pop();

    setState(() {});
  }
}
// class MyExpansionTile extends StatefulWidget {
//   final int id;
//   final String name;
//   final String titleName;

//   MyExpansionTile(this.id, this.name,this.titleName);
//   @override
//   State createState() =>  MyExpansionTileState();
// }

// class MyExpansionTileState extends State<MyExpansionTile> {
//   late PageStorageKey _key;
//   //late Future<http.Response> _responseFuture;
//   late int _lastSelectedItem = 0;
//   late int selectedTile = -1;
 

//   @override
//   void initState() {
//     super.initState();
//     // final url =
//     //     Uri.parse("https://jsonplaceholder.typicode.com/posts/${widget.id}");

//     // _responseFuture = http.get(url);
//   }

//   @override
//   Widget build(BuildContext context) {
//     _key = PageStorageKey('${widget.id}');
//     return 
//         Theme(
//             data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//             child: Container(
//               // decoration: BoxDecoration(
//               //   //                    <-- BoxDecoration
//               //   border: Border(
//               //       bottom: BorderSide(color: AppColors.dividelineGreycolor)),
//               // ),
//               child: ExpansionTile(
//                initiallyExpanded: widget.name == selectedTile ? true : false,
//                 key: _key,
//                 onExpansionChanged: ((newState) {
//                   if (newState)
//                   {
//                  selectedTile = widget.id;
//                     setState(() {
                      
//                     });
//                   }
//                   else
//                   {
//                     selectedTile = -1;
//                     setState(() {
                      
//                     });
//                   }
                
//                 }),
//                 trailing: const SizedBox.shrink(),
//                 childrenPadding: const EdgeInsets.only(left: 20), //children padding
//                 title: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
//                   child: Text(
//                     widget.titleName.toString(),
//                     style: const TextStyle(
//                         fontSize: 16,
//                         fontFamily: Constants.customFontSemiBoldFamily,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textgreyThemecolor),
//                     // style: Styles.textStyleBlack16,
//                   ),
//                 ), //Text(widget.title),
//                 children: <Widget>[
//                   // FutureBuilder(
//                   //   future: _responseFuture,
//                   //   builder: (BuildContext context,
//                   //       AsyncSnapshot<http.Response> response) {
//                   //     if (!response.hasData) {
//                   //       return const Center(
//                   //         child: const Text('Loading...'),
//                   //       );
//                   //     } else if (response.data?.statusCode != 200) {
//                   //       return const Center(
//                   //         child: const Text('Error loading data'),
//                   //       );
//                   //     } else {
//                         // List<dynamic> json = JSON.decode(response.data?.body);
//                         // dynamic json = jsonDecode(response.data!.body);
//                         // List<Widget> reasonList = [];
//                         // json.forEach((element) {
//                         //   reasonList.add(new ListTile(
//                         //     dense: true,
//                         //     title: new Text(element['title']),
//                         //   ));
//                         // });
//                          Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 30.0, right: 10),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     _lastSelectedItem = widget.id;
//                                     setState(() {});
//                                   },
//                                   child: Text(
//                                     widget.name,
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontFamily:
//                                             Constants.customFontSemiBoldFamily,
//                                         fontWeight: FontWeight.w600,
//                                         color: _lastSelectedItem == widget.id
//                                             ? AppColors.navigationSkybluecolor
//                                             : AppColors.textgreyThemecolor),
//                                     // style: Styles.textStyleBlack16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                        // );
//                       //}
//                     //},
//                   )
//                 ],
//               ),
//             ),
      
//     );
//   }
// }
