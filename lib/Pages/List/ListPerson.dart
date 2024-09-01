import 'package:app_all_one/Model/UserClass.dart';
import 'package:app_all_one/Pages/Drawer/Drawer.dart';
import 'package:app_all_one/Pages/List/user.dart';
import 'package:app_all_one/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPersonView extends StatefulWidget {
  const ListPersonView({Key? key}) : super(key: key);

  @override
  State<ListPersonView> createState() => _ListPersonViewState();
}

class _ListPersonViewState extends State<ListPersonView>{

  List<User> _users = [];

  List<User> _foundedUsers = [];
  bool showBarSearch = false;

  @override
  void initState() {
    super.initState();
    getUsers();

  }

  void getUsers() async {
    final users = await FirebaseFirestore.instance.collection("users").get();
    if(users.docs.length != 0 ){
      for(var doc in users.docs){
        _users.add(User.fromJson(doc.data()));
      }
      setState(() {
        _foundedUsers = _users;
      });
    }
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
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              //prefixIcon: Icon(Icons.arrow_back),
              border: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              /*hintStyle: TextStyle(
                fontSize: 14,
                //color: Colors.grey.shade500
              ),*/
              hintText: "Buscar usuarios..."
            ),
          ),
        ): Text("Usuarios"),

        actions: !showBarSearch ? [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Open shopping cart',
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
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: _foundedUsers.length > 0  ? ListView.builder(
            itemCount: _foundedUsers.length,
            itemBuilder: (context, index) {
              return userComponent(user: _foundedUsers[index]);
            },
        ): Center(
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
              return Usuario(user: user, offline: false,);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children: [
                  Container(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(user.image),
                      )
                  ),
                  SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, /*style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)*/),
                        SizedBox(height: 5,),
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
                  duration: Duration(milliseconds: 300),
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
    );
  }
}
