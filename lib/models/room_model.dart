class Room {
  final String id;
  final String name;
  final String type; // 'Free' or 'Premium'
  final String amenities;
  final int capacity;
  final String status; // 'Available' or 'Booked'
  final String imageUrl;
  final String location;

  Room({
    required this.id,
    required this.name,
    required this.type,
    required this.amenities,
    required this.capacity,
    required this.status,
    required this.imageUrl,
    required this.location,
  });

  bool get isPremium => type == 'Premium';
}

// Mock Data
final List<Room> mockRooms = [
  Room(
    id: '1',
    name: 'Quiet Study Desk',
    type: 'Free',
    amenities: 'WiFi, Power',
    capacity: 1,
    status: 'Available',
    imageUrl: 'https://images.unsplash.com/photo-1599719032228-48fe3b6f60f7?w=600&h=400&fit=crop',
    location: '3rd Floor, Quiet Zone',
  ),
  Room(
    id: '2',
    name: 'Classroom 101',
    type: 'Free',
    amenities: 'Projector, Whiteboard',
    capacity: 25,
    status: 'Booked',
    imageUrl: 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=600&h=400&fit=crop',
    location: '2nd Floor, East Wing',
  ),
  Room(
    id: '3',
    name: 'Soundproof Pod A',
    type: 'Premium',
    amenities: 'Acoustic Walls, 4K Monitor',
    capacity: 4,
    status: 'Available',
    imageUrl: 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=600&h=400&fit=crop',
    location: '4th Floor, Innovation Hub',
  ),
  Room(
    id: '4',
    name: 'Media Lab',
    type: 'Premium',
    amenities: 'Editing Workstation, Green Screen',
    capacity: 8,
    status: 'Available',
    imageUrl: 'https://images.unsplash.com/photo-1497215842519-e21cc028cb29?w=600&h=400&fit=crop',
    location: '5th Floor, Media Center',
  ),
];
