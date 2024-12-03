import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(TixIDApp());
}

class TixIDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color(0xFF001a3b),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_splash.jpg', // Ensure this asset exists
                height: screenHeight * 0.9,
                width: screenWidth * 1,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Soft background color for the screen
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            // To handle overflow when keyboard appears
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Bold and bright color
                  ),
                ),
                SizedBox(height: 40),
                // Email Field with underline style
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    labelStyle:
                        TextStyle(color: Colors.black), // Adjusted color
                    prefixIcon: Icon(Icons.person,
                        color: Colors.black), // Changed to person icon
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                // Password Field with underline style and default +62
                TextField(
                  controller: passwordController
                    ..text = '+62', // Set the default value
                  decoration: InputDecoration(
                    labelText: "Nomor Telpon",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.phone,
                        color: Colors.black), // Changed to phone icon
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  obscureText:
                      false, // since this is for phone number, we should not obscure the text
                  keyboardType: TextInputType
                      .phone, // Set the keyboard type for phone number
                ),
                SizedBox(height: 30),
                // Login Button with custom styling (now directly connects to Dashboard)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent, // Updated this to backgroundColor
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Sign Up prompt for users without an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to SignUp screen
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // List to store booked tickets
  List<Map<String, String>> bookedTickets = [];

  // Handle navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Pages for the app
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(), // Assuming you have a HomePage widget
      BioskopMenu(), // Assuming you have a BioskopMenu widget
      TicketMenu(onBook: (title, image) {
        // Add the booked movie to the list
        setState(() {
          bookedTickets.add({"title": title, "image": image});
        });
      }),
      TicketKuMenu(bookedTickets: bookedTickets),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(
              icon: Icon(Icons.theaters), label: "Bioskops"),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_rounded), label: "Tickets"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_rounded), label: "Tiketku"),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Categories
  final List<String> categories = [
    "Semua Film",
    "XXI",
    "CGV",
    "Cinepolis",
    "Watchlist"
  ];

  // Movie posters for each category
  final Map<String, List<String>> categoryPosters = {
    "Semua Film": [
      'Assets/Coco.jpg',
      'Assets/film-moana-2_169.jpeg',
      'Assets/shaun.jpg',
      'Assets/johnwick.jpg',
      'Assets/SW.jpg',
      'Assets/soul.jpg',
      'Assets/Ambatman.jpg',
    ],
    "XXI": [
      'Assets/Ambatman.jpg',
      'Assets/shaun.jpg',
      'Assets/johnwick.jpg',
    ],
    "CGV": [
      'Assets/shaun.jpg',
      'Assets/soul.jpg',
    ],
    "Cinepolis": [
      'Assets/Coco.jpg',
      'Assets/SW.jpg',
    ],
    "Watchlist": [
      'Assets/Ambatman.jpg',
      'Assets/soul.jpg',
    ],
  };

  // Selected category
  String selectedCategory = "Semua Film";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari di TIX ID",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Make the entire body scrollable vertically
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and Ad Banner Section
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                  ), // Location pin icon
                  SizedBox(width: 8.0), // Space between the icon and text
                  Text(
                    "JAKARTA",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),

            // Carousel Slider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height *
                          0.4, // Adjust height dynamically
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction:
                          0.9, // Ensure slight overlap for center focus
                    ),
                    items: [
                      'Assets/Coco.jpg',
                      'Assets/film-moana-2_169.jpeg',
                      'Assets/shaun.jpg',
                      'Assets/johnwick.jpg',
                      'Assets/SW.jpg',
                      'Assets/soul.jpg',
                    ].map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width *
                                0.9, // 90% of screen width
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                            ),
                            child: ClipRRect(
                              // Rounded corners
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit
                                    .cover, // Fill container while preserving aspect ratio
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  // Add image below the slider
                  SizedBox(
                      height:
                          20.0), // Add spacing between the slider and the image
                  Image.asset(
                    'Assets/gtw.png', // Replace with your image path
                    width: MediaQuery.of(context).size.width *
                        1, // 80% of screen width, // Adjust height dynamically
                    fit: BoxFit
                        .cover, // Scale and crop the image to fit the container
                  ),
                ],
              ),
            ),

            // Category List (Clickable)
            Container(
              height: 50.0,
              color: Colors.grey[200],
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) {
                  return _categoryItem(category);
                }).toList(),
              ),
            ),

            // Movie Posters based on selected category
            _sectionHeader("Movies in $selectedCategory"),
            _moviePosterSlider(categoryPosters[selectedCategory]!),

            // Spotlight Card Section
            _spotlightCard(),

            // TIX Now Section
            _tixNowList(),
          ],
        ),
      ),
    );
  }

  // Category Item (Clickable with Border for Selected Category)
  Widget _categoryItem(String title) {
    bool isSelected = title == selectedCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title; // Update the selected category
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
                    bottom: BorderSide(
                        color: Colors.blue,
                        width: 2)) // Blue border for selected category
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.blue
                    : Colors.black, // Change color if selected
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Section Header
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }

  // Movie Poster Slider (Horizontal Scrollable List)
  Widget _moviePosterSlider(List<String> posters) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection:
            Axis.horizontal, // This makes it scrollable horizontally
        itemCount: posters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                posters[index], // Display each poster
                width: 150, // Width of each image
                height: 200, // Height of each image
                fit: BoxFit.cover, // Ensures the image covers the space well
              ),
            ),
          );
        },
      ),
    );
  }

  // Spotlight Card (Featured movie section)
  Widget _spotlightCard() {
    final List<Map<String, String>> spotlightData = [
      {
        'image': 'assets/johnwick.jpg',
        'title': 'Weekly Box Office',
        'description': 'Top 10 films trending in theaters this week.',
      },
      {
        'image': 'assets/shaun.jpg',
        'title': 'Exclusive Premiere',
        'description':
            'Catch the exclusive premiere of the latest blockbuster.',
      },
      {
        'image': 'SW.jpg',
        'title': 'Behind the Scenes',
        'description': 'Discover the making of your favorite movies.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Spotlight",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: spotlightData.map((spotlight) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                            child: Image.asset(
                              spotlight['image']!,
                              height: 120.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              spotlight['title']!,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              spotlight['description']!,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _spotlightSection(BuildContext context) {
    // Spotlight movie data
    final List<Map<String, String>> spotlightMovies = [
      {
        'title': 'Avatar: The Way of Water',
        'image': 'Assets/avatar.jpg', // Replace with actual asset paths
      },
      {
        'title': 'The Batman',
        'image': 'Assets/batman.jpg',
      },
      {
        'title': 'Inception',
        'image': 'Assets/inception.jpg',
      },
      {
        'title': 'Interstellar',
        'image': 'Assets/interstellar.jpg',
      },
      {
        'title': 'The Matrix',
        'image': 'Assets/matrix.jpg',
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spotlight Title
          Text(
            "Spotlight",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0), // Space between title and content

          // Spotlight Movies (Column Layout)
          Container(
            height: screenWidth * 0.6, // Adjust height relative to screen width
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: spotlightMovies.length,
              itemBuilder: (context, index) {
                final movie = spotlightMovies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Movie Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          movie['image']!,
                          width: screenWidth * 0.6, // 60% of screen width
                          height: screenWidth * 0.4, // Landscape aspect ratio
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0), // Space between image and title

                      // Movie Title
                      Text(
                        movie['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // TIX Now Section (List of news headlines or tickets)
  Widget _tixNowList() {
    // Simulated movie news data
    final List<Map<String, String>> movieNews = [
      {
        'title': 'Bohemian Rhapsody by Queen',
        'subtitle': 'An epic movie from legendary band queen',
        'image': 'Assets/bohemian.jpg',
      },
      {
        'title': 'Christopher Nolan\'s Oppenheimer Wins Big',
        'subtitle': 'Oppenheimer bags multiple awards at the Oscars.',
        'image': 'Assets/openh.jpg',
      },
      {
        'title': 'Pixar\'s Soul Sequel Confirmed',
        'subtitle': 'The sequel to Soul is in production and expected soon.',
        'image': 'Assets/soul.jpg',
      },
      {
        'title': 'Dune Part 2: What to Expect',
        'subtitle': 'Dune Part 2 will continue the epic sci-fi saga.',
        'image': 'Assets/dune.jpg',
      },
      {
        'title': 'Ambawick 1',
        'subtitle': 'The most successful film in Ngawi',
        'image': 'Assets/ambawick.jpg',
      },
    ];

    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Text(
            "TIX Now",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0), // Space between title and list

          // News List Section
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: movieNews.length,
            itemBuilder: (context, index) {
              final news = movieNews[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                leading: SizedBox(
                  width:
                      screenWidth * 0.2, // Adjust width relative to screen size
                  height: screenWidth * 0.2, // Maintain aspect ratio
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // Round corners
                    child: Image.asset(
                      news['image']!,
                      fit: BoxFit.cover, // Ensures the image scales properly
                    ),
                  ),
                ),
                title: Text(
                  news['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(news['subtitle']!),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Bioskop Menu
class BioskopMenu extends StatefulWidget {
  @override
  _BioskopMenuState createState() => _BioskopMenuState();
}

class _BioskopMenuState extends State<BioskopMenu> {
  final List<String> bioskopList = [
    "Bioskop 1",
    "Bioskop 2",
    "Bioskop 3",
    "Bioskop 4",
    "Bioskop 5",
    "Bioskop 6",
    "Bioskop 7",
    "Bioskop 8",
    "Bioskop 9",
  ]; // Adding more bioskops for demonstration

  bool showBanner = true; // Flag to track whether to show the banner

  // Location click handler
  void _onLocationTap() {
    // Open a dialog or a screen to select location
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pilih Lokasi"),
          content: Text("Here you can choose your location."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Bioskop click handler
  void _onBioskopTap(String bioskopName) {
    // Open a detail screen or take action based on selected bioskop
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You selected $bioskopName")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari di TIX ID",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container for location (JAKARTA) with location pin icon
          GestureDetector(
            onTap: _onLocationTap, // Make location clickable
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on), // Location pin icon
                  SizedBox(width: 8.0), // Space between the icon and text
                  Text(
                    "JAKARTA",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),

          // Banner reminder section above the bioskop list
          if (showBanner)
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.yellow[100],
              child: Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.orange),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      "Tambahkan Bioskop favorit Anda! Jangan lupa untuk menambahkan bioskop kesayangan Anda.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showBanner =
                            false; // Hide the banner when the button is pressed
                      });
                    },
                    child: Text("Paham"),
                  ),
                ],
              ),
            ),

          // Add Image placeholder (we removed mboh.png)
          SizedBox(
              height:
                  20.0), // Space between the banner and the list of theaters

          // Row for bioskop list title and arrow button (decorative)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bioskop List",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(
                  Icons.arrow_forward, // Arrow icon for decoration
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          // List of bioskop
          Expanded(
            child: ListView.builder(
              itemCount: bioskopList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onBioskopTap(bioskopList[index]),
                  child: ListTile(
                    leading: Icon(Icons.theaters),
                    title: Text(bioskopList[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//  class TicketMenu extends StatelessWidget {
//   final List<String> wishlist = ["Movie A", "Movie B", "Movie C"];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: wishlist.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.all(8.0),
//           child: ListTile(
//             leading: Icon(Icons.favorite, color: Colors.red),
//             title: Text(wishlist[index]),
//             trailing: Icon(Icons.arrow_forward_ios),
//           ),
//         );
//       },
//     );
//   }
// }

// // Tiket Ku Menu with Booked Tickets
// class TicketKuMenu extends StatelessWidget {
//   final List<String> bookedTickets = ["Booked Movie 1", "Booked Movie 2"];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: bookedTickets.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.all(8.0),
//           child: ListTile(
//             leading: Icon(Icons.check_circle, color: Colors.green),
//             title: Text(bookedTickets[index]),
//             trailing: Icon(Icons.arrow_forward_ios),
//           ),
//         );
//       },
//     );
//   }
// }

class TicketMenu extends StatefulWidget {
  final Function(String, String) onBook;

  TicketMenu({required this.onBook});

  @override
  _TicketMenuState createState() => _TicketMenuState();
}

class _TicketMenuState extends State<TicketMenu> {
  final List<Map<String, String>> moviesSedangTayang = [
    {
      "title": "Ambatman",
      "image": "assets/Ambatman.jpg",
      "genre": "Action, Comedy"
    },
    {"title": "John Wick", "image": "assets/johnwick.jpg", "genre": "Action"},
    {"title": "Coco", "image": "assets/Coco.jpg", "genre": "Action, Adventure"},
  ];

  final List<Map<String, String>> moviesAkanTayang = [
    {"title": "Star Wars", "image": "assets/SW.jpg", "genre": "Action"},
    {
      "title": "Moana",
      "image": "assets/film-moana-2_169.jpeg",
      "genre": "Cartoon"
    },
    {"title": "Open Heimer", "image": "assets/openh.jpg", "genre": "Action"},
  ];

  String currentCategory =
      "Sedang Tayang"; // Default category is "Sedang Tayang"

  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600
        ? 3
        : 2; // 3 columns for wide screens, 2 columns for narrow screens

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Tickets'),
      ),
      body: Column(
        children: [
          // Section for clickable categories
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sedang Tayang Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentCategory = "Sedang Tayang";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Sedang Tayang",
                      style: TextStyle(
                        color: currentCategory == "Sedang Tayang"
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: currentCategory == "Sedang Tayang"
                            ? TextDecoration.underline
                            : TextDecoration.none, // Underline if selected
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Akan Tayang Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentCategory = "Akan Tayang";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Akan Tayang",
                      style: TextStyle(
                        color: currentCategory == "Akan Tayang"
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: currentCategory == "Akan Tayang"
                            ? TextDecoration.underline
                            : TextDecoration.none, // Underline if selected
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Display movies based on selected category
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Display movies in grid format based on currentCategory
                  currentCategory == "Sedang Tayang"
                      ? MovieGrid(
                          movies: moviesSedangTayang, onBook: widget.onBook)
                      : MovieGrid(
                          movies: moviesAkanTayang, onBook: widget.onBook),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<Map<String, String>> movies;
  final Function(String, String) onBook;

  MovieGrid({required this.movies, required this.onBook});

  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600
        ? 3
        : 2; // 3 columns for wide screens, 2 columns for narrow screens

    return GridView.builder(
      shrinkWrap: true, // Ensures it only takes as much space as it needs
      physics:
          NeverScrollableScrollPhysics(), // Disable scrolling inside the GridView
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Number of items per row
        crossAxisSpacing: 10.0, // Space between columns
        mainAxisSpacing: 10.0, // Space between rows
        childAspectRatio: 0.75, // Aspect ratio for each item (height vs width)
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie image
              Image.asset(
                movies[index]['image']!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    movies[index]['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(movies[index]['genre']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      onBook(movies[index]['title']!, movies[index]['image']!);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TicketKuMenu extends StatelessWidget {
  final List<Map<String, String>> bookedTickets;

  TicketKuMenu({required this.bookedTickets});

  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600
        ? 3
        : 2; // 3 columns for wide screens, 2 columns for narrow screens

    return Scaffold(
      appBar: AppBar(title: Text("Tiket Ku")),
      body: bookedTickets.isEmpty
          ? Center(
              child: Text(
                "No Tickets Booked Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Display booked tickets in a grid format
                  GridView.builder(
                    shrinkWrap:
                        true, // Ensures it only takes as much space as it needs
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling inside the GridView
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Number of items per row
                      crossAxisSpacing: 10.0, // Space between columns
                      mainAxisSpacing: 10.0, // Space between rows
                      childAspectRatio:
                          0.75, // Aspect ratio for each item (height vs width)
                    ),
                    itemCount: bookedTickets.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Movie image
                            Image.asset(
                              bookedTickets[index]['image']!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  bookedTickets[index]['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
