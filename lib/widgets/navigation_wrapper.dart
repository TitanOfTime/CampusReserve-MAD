import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/bookings_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/booking_detail_screen.dart';
import '../models/room_model.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({Key? key}) : super(key: key);

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;
  Room? _selectedRoom;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (_selectedRoom != null) {
      return _buildDetailView();
    }

    if (isLandscape) {
      return _buildLandscapeLayout();
    } else {
      return _buildPortraitLayout();
    }
  }

  Widget _buildPortraitLayout() {
    return Scaffold(
      body: _getScreenForIndex(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text('Bookings'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Profile'),
              ),
            ],
          ),
          // Main Content
          Expanded(
            child: _getScreenForIndex(_selectedIndex),
          ),
        ],
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return DashboardScreen(
          onRoomSelected: (room) {
            setState(() {
              _selectedRoom = room;
            });
          },
        );
      case 1:
        return const BookingsScreen();
      case 2:
        return _buildSearchScreen();
      case 3:
        return const ProfileScreen();
      default:
        return DashboardScreen(
          onRoomSelected: (room) {
            setState(() {
              _selectedRoom = room;
            });
          },
        );
    }
  }

  Widget _buildSearchScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Rooms'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by room name or amenities...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  // Search functionality would be implemented here
                });
              },
            ),
            const SizedBox(height: 24),
            // Filter Options
            Text(
              'Filter by Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  onSelected: (selected) {},
                  selected: true,
                ),
                FilterChip(
                  label: const Text('Free'),
                  onSelected: (selected) {},
                ),
                FilterChip(
                  label: const Text('Premium'),
                  onSelected: (selected) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Available Rooms List
            Text(
              'All Available Rooms',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockRooms.length,
              itemBuilder: (context, index) {
                final room = mockRooms[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(room.name),
                    subtitle: Text(room.location),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (room.isPremium)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Pro',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade700,
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _selectedRoom = room;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailView() {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _selectedRoom = null;
        });
        return false;
      },
      child: BookingDetailScreen(
        room: _selectedRoom!,
      ),
    );
  }
}
