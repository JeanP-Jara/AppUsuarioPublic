import 'dart:io';

import 'package:app_all_one/Model/UserClass.dart';
import 'package:app_all_one/Pages/Drawer/Drawer.dart';
import 'package:app_all_one/Pages/List/user.dart';
import 'package:app_all_one/Pages/Offline/userOffline.dart';
import 'package:app_all_one/data/bd.dart';
import 'package:flutter/material.dart';

class ListPersonOffline extends StatefulWidget {
  const ListPersonOffline({Key? key}) : super(key: key);

  @override
  State<ListPersonOffline> createState() => _ListPersonOfflineState();
}

class _ListPersonOfflineState extends State<ListPersonOffline> {

  List<User> _users = [];

  List<User> _foundedUsers = [];
  bool showBarSearch = false;

  @override
  void initState() {
    super.initState();
    getUsers();

  }

  void getUsers() async {
    _users = await BD.getUser();
    setState(() {
      _foundedUsers = _users;
    });
  }

  onSearch(String search){
    setState(() {
      _foundedUsers = _users.where((user) => user.name.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !showBarSearch,
        elevation: 0,
        centerTitle: true,
        leading: showBarSearch ? IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Open shopping cart',
          onPressed: () {
            setState(() {
              showBarSearch = !showBarSearch;
            });
          },
        ): null,
        title: showBarSearch ? Container(
          height: MediaQuery.of(context).size.height*5/100,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                //prefixIcon: Icon(Icons.arrow_back),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Buscar usuarios..."
            ),
          ),
        ): const Text("Usuarios"),

        actions: !showBarSearch ? [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                showBarSearch = !showBarSearch;
              });
            },
          ),
        ] : [],
      ),
      drawer: const Drawer(
        child: DrawerAll(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const UserOfflineEdit();
              },
            ),
          ).then((value) => getUsers());
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: _foundedUsers.isNotEmpty  ? ListView.builder(
          itemCount: _foundedUsers.length,
          itemBuilder: (context, index) {
            return userComponent(user: _foundedUsers[index]);
          },
        ): const Center(
          child: Text("Sin resultados..."),
        ),
      ),
    );
  }

  userComponent({required User user}) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Usuario(user: user, offline: true,);
            },
          ),
        );
      },
      onLongPress: (){
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return UserOfflineEdit(user: user);
            },
          ),
        ).then((value) => getUsers());
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: [
                    SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: user.image == "" ? const Icon(Icons.person) : Image.file(File(user.image), fit: BoxFit.cover,),
                        )
                    ),
                    const SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, /*style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500)*/),
                          const SizedBox(height: 5,),
                          Text(user.username,
                              style: TextStyle(color: Colors.grey[500])),
                        ]
                    )
                  ]
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    user.isFollowedByMe = !user.isFollowedByMe;
                  });
                },
                child: AnimatedContainer(
                    height: 35,
                    width: 110,
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: user.isFollowedByMe ? Colors.blue[700] : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: user.isFollowedByMe ? Colors.transparent : Colors
                              .grey.shade700,)
                    ),
                    child: Center(
                        child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow',
                            style: TextStyle(
                                color: user.isFollowedByMe ? Colors.white : Colors
                                    .white))
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
