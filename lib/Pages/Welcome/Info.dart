import 'package:app_all_one/Pages/List/ListPerson.dart';
import 'package:app_all_one/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageImdicator(){
    List<Widget> list = [];
    for(int i = 0; i < _numPages; i++){
      list.add(i == _currentPage ? _indicator(true) : _indicator(false) );
    }
    return list;
  }

  Widget _indicator(bool isActivite){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActivite ? 24 : 16,
      decoration: BoxDecoration(
        color: isActivite ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3594DD),
                  Color(0xFF4563DB),
                  Color(0xFF5036D5),
                  Color(0xFF5B16D0)
                ]
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*5/100,),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){

                        },
                      child: const Text(
                        constants.OMITIR,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 550,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page){
                      setState(() {
                        print(page);
                        _currentPage = page;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage("assets/onboarding0.png"),
                                height: MediaQuery.of(context).size.height/2.5,
                                width: MediaQuery.of(context).size.height/2.5,
                              ),
                            ),
                            const SizedBox(height: 30,),
                            const Text(
                              'Obtén una nueva experiencia de imaginación.',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Aplicación demo.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage("assets/onboarding1.png"),
                                height: MediaQuery.of(context).size.height/2.5,
                                width: MediaQuery.of(context).size.height/2.5,
                              ),
                            ),
                            const SizedBox(height: 30,),
                            const Text(
                              'Obtén una nueva experiencia de imaginación.',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Aplicación demo.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage("assets/onboarding2.png"),
                                height: MediaQuery.of(context).size.height/2.5,
                                width: MediaQuery.of(context).size.height/2.5,
                              ),
                            ),
                            const SizedBox(height: 30,),
                            const Text(
                              'Obtén una nueva experiencia de imaginación.',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Aplicación demo.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                !(_currentPage == _numPages - 1) ?
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                  child: Column(
                    children: [
                      Padding(
                        padding:  const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, children: _buildPageImdicator(),
                        ),
                      ),
                      _currentPage != _numPages - 1 ?
                      Align(
                        alignment: FractionalOffset.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                constants.SIGUIENTE,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ) : Text(''),

                    ],
                  ),
                ) : Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*5/100, vertical: 24),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.QR);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 8
                          )
                      ),
                      child: const Text(constants.BTN_INICIAR, style: TextStyle( fontSize: 16.0,),)
                  ),
                ),

              ],
            ),
          ),
      ),
    );
  }
}
