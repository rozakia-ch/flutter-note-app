import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  const NoteCard({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const Color black = Color(0xFFfdffb6);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 9,
                  style: const TextStyle(
                    fontSize: 14,
                    wordSpacing: 1.25,
                    letterSpacing: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
