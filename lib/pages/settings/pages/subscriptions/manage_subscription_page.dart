import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';

import '../../../../shared/widgets/app_bar.dart';
class ManageSubscriptionPage extends StatelessWidget {
  const ManageSubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: "Manage Subscription"),
      body: Column(
        children: [
          Text('Purchased Plan'),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Yearly Plan 5000 PKR'),
                Text('Purchased on 21-01-23 | 07:58 pm'),
              ],
            ),
          ),
          Text('As a premium member you have access to'),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                Text('Ad-free App Experience'),
                Text('Unlock Quran Stories'),
                Text('Unlock Quran Stories'),
              ],
            ),
          ),
          Text('Having an issue? Please write to us'),
          Expanded(
            child: TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your feedback here...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Submit Feedback'),
          ),
          Text('Restore Purchase'),
        ],
      )
      ,
    );
  }
}
