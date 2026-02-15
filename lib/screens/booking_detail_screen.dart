import 'package:flutter/material.dart';
import '../models/room_model.dart';

class BookingDetailScreen extends StatefulWidget {
  final Room room;

  const BookingDetailScreen({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _purposeController;
  DateTime? _selectedDate;
  String? _selectedDuration;
  final List<String> _durations = ['1 Hour', '2 Hours', '4 Hours'];

  @override
  void initState() {
    super.initState();
    _purposeController = TextEditingController();
  }

  @override
  void dispose() {
    _purposeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleConfirmBooking() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking confirmed for ${widget.room.name}!'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      // After showing confirmation, either pop the route if possible
      // or reset the form (useful for embedded/side-by-side layouts).
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          // Reset the form fields
          _formKey.currentState?.reset();
          setState(() {
            _purposeController.clear();
            _selectedDate = null;
            _selectedDuration = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking successful.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
        elevation: 0,
      ),
      body: isLandscape
          ? _buildLandscapeLayout()
          : _buildPortraitLayout(),
    );
  }

  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Image
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.room.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Room Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Premium Badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.room.name,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    if (widget.room.isPremium)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'Premium',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Location
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      widget.room.location,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Capacity
                Row(
                  children: [
                    Icon(Icons.people, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Capacity: ${widget.room.capacity} people',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Amenities
                Row(
                  children: [
                    Icon(Icons.devices, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Amenities: ${widget.room.amenities}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Booking Form
                _buildBookingForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        // Left: Image
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.room.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Right: Details and Form
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Premium Badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.room.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (widget.room.isPremium)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              'Premium',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                // Location
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: Colors.grey[600], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      widget.room.location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Capacity
                Row(
                  children: [
                    Icon(Icons.people, color: Colors.grey[600], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Capacity: ${widget.room.capacity} people',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Amenities
                Row(
                  children: [
                    Icon(Icons.devices, color: Colors.grey[600], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Amenities: ${widget.room.amenities}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Booking Form
                _buildBookingForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book This Room',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Purpose of Booking TextField
          TextFormField(
            controller: _purposeController,
            decoration: const InputDecoration(
              labelText: 'Purpose of Booking',
              hintText: 'e.g., Group Study, Assignment Work',
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the purpose of your booking';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Date Picker
          GestureDetector(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Select Date',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _selectedDate == null
                    ? 'Tap to select date'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Duration Dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Duration',
              prefixIcon: const Icon(Icons.timer),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: _durations.map((duration) {
              // Disable 4 Hours option for free tier
              bool isDisabled = !widget.room.isPremium && duration == '4 Hours';
              return DropdownMenuItem(
                enabled: !isDisabled,
                value: duration,
                child: Text(
                  duration,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey[400] : null,
                  ),
                ),
              );
            }).toList(),
            value: _selectedDuration,
            onChanged: (value) {
              setState(() {
                _selectedDuration = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a duration';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _handleConfirmBooking,
              icon: const Icon(Icons.check),
              label: const Text('Confirm Booking'),
            ),
          ),
        ],
      ),
    );
  }
}
