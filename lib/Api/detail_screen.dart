import 'package:flutter/material.dart';
import 'package:tot/Api/model.dart';
import 'package:tot/Constants/const.dart';
import '../data.dart';

class DetailScreen extends StatelessWidget {
  final DogModel dogs;
  const DetailScreen({super.key, required this.dogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite, color: Colors.pink),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dogs.title.toString(), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),

            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(dogs.imageUrl.toString(), height: 250, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            buildNormalText('Breed', 18),
            const SizedBox(height: 8),
            buildPinkContainer(dogs.breed.toString(), "Images/dog.png"),
            buildNormalText('Life Span', 18),
            const SizedBox(height: 8),
            buildPinkContainer(dogs.lifeSpan.toString(), "Images/heart.png"),
            buildNormalText('Origin', 18),
            const SizedBox(height: 8),
            buildPinkContainer(dogs.origin.toString(), "Images/loc.png"),
            const SizedBox(height: 24),
            buildNormalText('Description', 18),
            const SizedBox(height: 8),
            buildTextSubTitleVariation1(dogs.description.toString())
          ],
        ),
      ),
    );
  }
}