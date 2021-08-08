import 'package:flutter/material.dart';
import 'detailPage.dart';
import 'addImage.dart';
import 'timelineWebView.dart';

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'images/16.jpg',
    location: 'Lake Kawaguchi, Japan',
    photographer: 'Martin Andres',
    title: 'Traveling',
    details:
        'This image was taken during a party in New York on new years eve. Quite a colorful shot.',
  ),
  ImageDetails(
    imagePath: 'images/17.jpg',
    location: 'Antelope Canyon, Arizona',
    photographer: 'Abraham Costa',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/18.jpg',
    location: 'Arashiyama Bamboo Grove, Japan',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/1.jpg',
    location: 'Pamukkale, Turkey',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/4.jpg',
    location: 'Luna park Desenzano Del Garda',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/6.jpg',
    location: 'Villa San Toma, Venice, Italy',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/7.jpg',
    location: 'Konark Sun Temple',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/8.jpg',
    location: 'Eiffel Tower, Paris',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/9.jpg',
    location: 'Burj Al Arab',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/10.jpg',
    location: 'Machu Picchu, Peru',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/11.jpg',
    location: 'Antarctica',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/12.jpg',
    location: 'Halong Bay, Vietnam',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/13.jpg',
    location: 'Lake Tekapo, New Zealand',
    photographer: 'Jamie Bryan',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/15.jpg',
    location: 'Taj Mahal, Agra, India',
    photographer: 'Matthew',
    title: 'Traveling',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/14.jpg',
    location: 'Ambala, 133001, India',
    photographer: 'Martin Sawyer',
    title: 'Home',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),

            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebViewTimeline()));
              },
              child: Text(
                'TimeLine',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              style: TextButton.styleFrom(primary: Colors.orange),
            ),

            // Text(
            //   'TimeLine',
            //   style: TextStyle(
            //     fontSize: 35,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.white,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  backgroundColor: Colors.deepOrangeAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddImage()));
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              imagePath: _images[index].imagePath,
                              title: _images[index].title,
                              photographer: _images[index].photographer,
                              location: _images[index].location,
                              details: _images[index].details,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _images.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageDetails {
  final String imagePath;
  final String location;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    @required this.imagePath,
    @required this.location,
    @required this.photographer,
    @required this.title,
    @required this.details,
  });
}
