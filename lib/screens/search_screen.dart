import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/screens/result_screens.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchTextController = TextEditingController();


  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Find a movie...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: TextStyle(color: Colors.white, fontSize: 18),
      autofocus: true,
    );
  }

  Widget _buildClearLeading() {
    return InkWell(
      onTap: () {
        _searchTextController.clear();
      },
      child: Icon(Icons.clear, color: Colors.white),
    );
  }

  List<Widget> _buildSearchActions() {
    return [
      IconButton(
        onPressed: () {
          var searchWord = _searchTextController.text;
          if (searchWord.length > 0)
            Get.to(() => ResultScreen(searchWord: searchWord), preventDuplicates: false);
        },
        icon: Icon(Icons.search, color: Colors.white),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: _buildClearLeading(),
        title: _buildSearchField(),
        actions: _buildSearchActions(),
      ),
      body: Center(
        child: Text('Type the name of the movie'),
      ),
    );
  }
}
