import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Bottom Nav',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Changed theme color
        // For Material 3:
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        // useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Titles for each screen to be displayed in the AppBar
  static const List<String> _appBarTitles = <String>[
    'Home Sweet Home',
    'Find Anything',
    'Your Messages', // New title for the new tab
    'My Profile',
  ];

  // More distinct widgets for each screen
  static final List<Widget> _widgetOptions = <Widget>[
    _buildScreenContent(Colors.lightBlue[100]!, Icons.home, 'Home Content'),
    _buildScreenContent(Colors.lightGreen[100]!, Icons.search, 'Search Results'),
    _buildScreenContent(Colors.orange[100]!, Icons.mail, 'Your Messages'), // New Screen
    _buildScreenContent(Colors.purple[100]!, Icons.person, 'Profile Details'),
  ];

  // Helper function to create styled screen content
  static Widget _buildScreenContent(Color bgColor, IconData icon, String text) {
    return Container(
      color: bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80, color: Colors.black54),
            const SizedBox(height: 20),
            Text(
              text,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if a badge should be shown on the Messages tab
    const bool hasNewMessages = true; // Simulate having new messages

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]), // Dynamic AppBar title
        backgroundColor: Theme.of(context).primaryColor, // Match theme
      ),
      body: Center( // Using Center for smooth transition between screens
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            backgroundColor: Colors.purple, // For shifting type
            icon: Icon(Icons.home,color: Colors.white),
            label: 'Home',
            //backgroundColor: Colors.blue, // For shifting type
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Colors.white),
            label: 'Search',
            backgroundColor: Colors.green, // For shifting type
          ),
          BottomNavigationBarItem(
            icon: Stack( // Using Stack to overlay a badge
              children: <Widget>[
                const Icon(Icons.mail,color: Colors.white),
                if (hasNewMessages) // Conditionally show badge
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text( // Could be a number or empty
                        '3', // Example badge content
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            label: 'Messages',
             backgroundColor: Colors.orange, // For shifting type
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded,color: Colors.white),
            label: 'Profile',
             backgroundColor: Colors.purple, // For shifting type
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary, // Use theme colors
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        // type: BottomNavigationBarType.shifting, // Uncomment if you want to see shifting effect more clearly with 4+ items
        // or want item-specific background colors
        // backgroundColor: Theme.of(context).primaryColor, // Overall background color of the bar
        // showSelectedLabels: true, // Default true
        // showUnselectedLabels: true, // Default true for fixed, false for shifting
      ),
    );
  }
}