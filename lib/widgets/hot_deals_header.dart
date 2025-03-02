import 'package:flutter/material.dart';

class HotDealsHeader extends StatelessWidget {
  const HotDealsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Hot deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
            ],
          ),
          Row(
            children: [
              _buildTimeBox(context, '02'),
              _buildTimeSeparator(),
              _buildTimeBox(context, '12'),
              _buildTimeSeparator(),
              _buildTimeBox(context, '00'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(BuildContext context, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildTimeSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
