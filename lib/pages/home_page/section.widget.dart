import 'package:cap_sahagun/pages/home_page/const.tables.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section(
      {Key key, this.imagePath, this.title, this.description, this.onTap})
      : super(key: key);

  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap;

  static const _height = 120.0;
  @override
  Widget build(BuildContext context) {
    // final media = MediaQuery.of(context);
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  imagePath,
                  height: _height * 1,
                  // fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        description ?? fakeDescription,
                        overflow: TextOverflow.fade,
                        // maxLines: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
