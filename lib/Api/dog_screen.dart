import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tot/Api/detail_screen.dart';
import 'package:tot/Api/model.dart';
import '../data.dart';

class DogsPage extends StatefulWidget {
  const DogsPage({super.key});

  @override
  State<DogsPage> createState() => _DogsPageState();
}


class _DogsPageState extends State<DogsPage> {
  List<DogModel> dogsList = [];
  List<DogModel> filteredDogs = [];
  final TextEditingController searchController = TextEditingController();

  // Fetch Data from API
  Future<void> getDogsData() async {
    final response = await http.get(Uri.parse("https://v2i0n0a3y.github.io/dogs/vinay.json"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      dogsList.clear();
      filteredDogs.clear(); // Clear previous data
      for (Map<String, dynamic> index in data) {
        dogsList.add(DogModel.fromJson(index));
      }

      setState(() {
        filteredDogs = List.from(dogsList); // Copy data to filteredDogs
      });
    }
  }

  // Filter Search Results
  void filterDog(String query) {
    List<DogModel> results = [];
    if (query.isEmpty) {
      results = dogsList;
    } else {
      results = dogsList
          .where((dog) =>
      dog.title!.toLowerCase().contains(query.toLowerCase()) ||
          dog.breed!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredDogs = results;
    });
  }

  @override
  void initState() {
    super.initState();
    getDogsData(); // Fetch data on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: Icon(Icons.sort, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite, color: Colors.pink),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1('Dogyee Dons!'),
                  buildTextSubTitleVariation1('Life is better with the Dogs...'),
                  SizedBox(height: 8),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: kBoxShadow,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[700]),
                      onChanged: filterDog, // Call search function on change
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Dogs",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
            Expanded(
              child: filteredDogs.isEmpty
                  ? Center(child:buildTextNut2("Sorry! No Data Available..",Colors.red),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: filteredDogs.length,
                itemBuilder: (context, index) {
                  var item = filteredDogs[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(dogs: item),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 8),
                      height: 140,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: kBoxShadow,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 117,
                            width: 117,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: kBoxShadow,
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(item.imageUrl.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildRecipeTitle(item.title.toString()),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle_sharp,
                                          color: Colors.green, size: 18),
                                      SizedBox(width: 5),
                                      buildTextSubTitleVariation1(item.breed.toString()),
                                      SizedBox(width: 2),

                                    ],
                                  ),
                                  buildTextSubTitleVariation3(item.origin.toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
