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
    imageUrl: 'https://images.unsplash.com/photo-1486946255434-2466348c2166?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHN0dWR5JTIwZGVza3xlbnwwfHwwfHx8MA%3D%3D',
    location: '3rd Floor, Quiet Zone',
  ),
  Room(
    id: '2',
    name: 'Classroom 101',
    type: 'Free',
    amenities: 'Projector, Whiteboard',
    capacity: 25,
    status: 'Booked',
    imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=800&q=80',
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
    imageUrl: 'https://images.unsplash.com/photo-1758336716950-370f54b7a43f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHNvdW5kcHJvb2Z8ZW58MHx8MHx8fDA%3D',
    location: '5th Floor, Media Center',
  ),
  Room(
    id: '5',
    name: 'Lecture Hall B',
    type: 'Free',
    amenities: 'Projector, 50 Seats, Mic',
    capacity: 50,
    status: 'Booked',
    imageUrl: 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=600&h=400&fit=crop',
    location: 'Ground Floor, Main Block',
  ),
];
