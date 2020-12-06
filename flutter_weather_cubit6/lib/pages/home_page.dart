import 'package:flutter/material.dart';
import 'search_page.dart';
import 'setting_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                // search 의 검색 결과를 가져온다.
                final city = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchPage();
                    },
                  ),
                );
                print('city: $city');
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Text(
              'London',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2020-12-06T15:00:00',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '15℃',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  children: [
                    Text(
                      'maxTemp: 17℃',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'minTemp: 10℃',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Light Cloud',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
              ),
            )
          ],
        ));
  }
}
