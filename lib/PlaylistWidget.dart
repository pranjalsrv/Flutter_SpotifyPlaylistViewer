import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  final String name;
  final IconData iconLocation;
  final String author;
  final bool isSelected;

  const Playlist(
      {Key key,
      @required this.name,
      @required this.iconLocation,
      @required this.author,
      @required this.isSelected})
      : assert(name != null),
        assert(iconLocation != null),
        assert(author != null),
        assert(isSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!isSelected)
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 10, bottom: 0, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50)),
          padding:
              const EdgeInsets.only(top: 28, bottom: 25, right: 40, left: 50),
          height: 95,
          child: Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*2*/
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      author,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                iconLocation,
                color: Colors.red[500],
              ),
            ],
          ),
        ));
    else{
      return Padding(
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 0, right: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.8),
                borderRadius: BorderRadius.circular(50)),
            padding:
            const EdgeInsets.only(top: 28, bottom: 25, right: 40, left: 50),
            height: 95,
            child: Row(
              children: [
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        author,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                /*3*/
                Icon(
                  iconLocation,
                  color: Colors.red[500],
                ),
              ],
            ),
          ));
    }
  }
}
