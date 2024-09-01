import 'dart:io';

import 'package:app_all_one/Model/UserClass.dart';
import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  const Usuario({Key? key, required this.user, required this.offline}) : super(key: key);
  final User user;
  final bool offline;
  @override
  State<Usuario> createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: widget.offline ? FileImage(File(widget.user.image)) as ImageProvider : NetworkImage(widget.user.image),
              ),
              SizedBox(height: 10,),
              Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                widget.user.username
              ),
              SizedBox(height: 20,),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(backgroundImage: widget.offline ? FileImage(File(widget.user.image)) as ImageProvider : NetworkImage(widget.user.image),),
                      title: Text(widget.user.name),
                      subtitle: Text(widget.user.username),
                    ),
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: FadeInImage(
                        image: NetworkImage("https://raw.githubusercontent.com/MarcusNg/flutter_instagram_feed_ui_redesign/master/assets/images/post0.jpg"),
                        placeholder: AssetImage('assets/default_placeholder.png'),
                        fit: BoxFit.fitWidth,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('assets/default_placeholder.png'),
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: null, icon: Icon(Icons.favorite_border, size: 30,),),
                                Text(widget.user.name.length.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)
                              ],
                            ),
                            SizedBox(width: 20,),
                            Row(
                              children: [
                                IconButton(onPressed: null, icon: Icon(Icons.chat_bubble_outline, size: 30,),),
                                Text(widget.user.name.length.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)
                              ],
                            )
                          ],
                        ),
                        IconButton(onPressed: null, icon: Icon(Icons.bookmark_border, size: 30,),),
                      ],
                    )
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(backgroundImage: widget.offline ? FileImage(File(widget.user.image)) as ImageProvider : NetworkImage(widget.user.image),),
                      title: Text(widget.user.name),
                      subtitle: Text(widget.user.username),
                    ),
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                      ),
                      child: FadeInImage(
                        image: NetworkImage("https://raw.githubusercontent.com/MarcusNg/flutter_instagram_feed_ui_redesign/master/assets/images/post1.jpg"),
                        placeholder: AssetImage('assets/default_placeholder.png'),
                        fit: BoxFit.fitWidth,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('assets/default_placeholder.png'),
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: null, icon: Icon(Icons.favorite_border, size: 30,),),
                                Text(widget.user.name.length.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)
                              ],
                            ),
                            SizedBox(width: 20,),
                            Row(
                              children: [
                                IconButton(onPressed: null, icon: Icon(Icons.chat_bubble_outline, size: 30,),),
                                Text(widget.user.name.length.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)
                              ],
                            )
                          ],
                        ),
                        IconButton(onPressed: null, icon: Icon(Icons.bookmark_border, size: 30,),),
                      ],
                    )
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
