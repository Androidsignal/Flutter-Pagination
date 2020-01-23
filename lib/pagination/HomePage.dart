import 'package:flutter/material.dart';
import 'package:google_maps/Constants.dart';
import 'package:google_maps/pagination/DataParser.dart';
import 'package:google_maps/pagination/UserModel.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  bool isLoading = true;
  bool isPageLoad = false;

  List<UserModel> categoryList = new List<UserModel>();

  @override
  void initState() {
    if (isLoading) {
      callApiForData(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lazy Load Large List"),
      ),
      body: layout(),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget layout() {
    if (isLoading == false) {
      if (isPageLoad != null && isPageLoad) {
        callApiForData(page.toString());
      }
      return Container(
        child: _buildList(),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildList() {
    return LazyLoadScrollView(
      onEndOfPage: () {
        page = page + 1;
        isPageLoad = true;
        setState(() {});
      },
      scrollOffset: 150,
      child: ListView.builder(
        itemCount: isPageLoad ? categoryList.length + 1 : categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          if (isPageLoad == true && index == categoryList.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Card(
            child: new ListTile(
              title: Text((categoryList[index].email.toString() +
                  "    =>" +
                  index.toString())),
              subtitle: Text((categoryList[index].phone.toString())),
              onTap: null,
            ),
          );
        },
      ),
    );
  }

  Future callApiForData(page) async {
    try {
      Map result = await Dataparser.getCategoryList(
          "https://staging.imastudent.com/api/categories/IncludeProductsFromSubcategories?CategoryId=" +
              10.toString() +
              "&page=" +
              page.toString() +
              "&pageSize=11");
      Constants.progressDialog(true, context);
      if (!result["isError"]) {
        Constants.progressDialog(false, context);
        if (isLoading) {
          categoryList = result["value"];
        } else if (isPageLoad) {
          categoryList.addAll(result["value"]);
        }
      } else {
        String msg = result["value"];
        Constants.progressDialog(false, context);
      }
    } catch (e) {
      print(e);
    }

    isLoading = false;
    isPageLoad = false;
    setState(() {});
  }
}
