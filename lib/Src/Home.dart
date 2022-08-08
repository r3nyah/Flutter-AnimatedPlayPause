import 'package:flutter/material.dart';
import 'package:button_animated/main.dart';
import 'package:button_animated/Src/Constant.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  bool playing = false;
  late AnimationController _playPauseAnimationController;
  late Animation<double> _topBottomAnimation;
  late AnimationController _topBottomAnimationController;
  late Animation<double> _leftRightAnimation;
  late AnimationController _leftRightAnimationController;

  @override
  void initState(){
    super.initState();

    _playPauseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _topBottomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _leftRightAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _topBottomAnimation = CurvedAnimation(
      parent: _topBottomAnimationController,
      curve: Curves.decelerate,
    ).drive(Tween<double>(begin: 5,end: -5));

    _leftRightAnimation = CurvedAnimation(
      parent: _leftRightAnimationController,
      curve: Curves.decelerate,
    ).drive(Tween<double>(begin: 5,end: -5));

    _leftRightAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _leftRightAnimationController.reverse();
      }else if(status == AnimationStatus.dismissed){
        _topBottomAnimationController.forward();
      }
    });
  }

  @override
  void dispose(){
    _playPauseAnimationController.dispose();
    _topBottomAnimationController.dispose();
    _leftRightAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = 150;
    double height = 150;

    return Scaffold(
      backgroundColor: purple,
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _topBottomAnimation,
              builder: (context, _){
                return Positioned(
                  child: Container(
                    width: width * 0.90,
                    height: height * 0.90,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          pink,
                          blue,
                        ],
                        begin: Alignment.center,
                        end: Alignment.centerLeft,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: pink.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 5
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _topBottomAnimation,
              builder: (context, _){
                return Positioned(
                  top: _topBottomAnimation.value,
                  left: _topBottomAnimation.value,
                  child: Container(
                    width: width * 0.90,
                    height: height * 0.90,
                    decoration: BoxDecoration(
                      color: pink.withOpacity(0.5),
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          pink,
                          blue,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: playing?[
                        BoxShadow(
                          color: pink.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 5
                        ),
                      ]:[

                      ],
                    )
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _leftRightAnimation,
              builder: (context,_){
                return Positioned(
                  bottom: _leftRightAnimation.value,
                  left: _leftRightAnimation.value,
                  child: Container(
                    width: width * 0.90,
                    height: height * 0.90,
                    decoration: BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          pink,
                          blue,
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: blue.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 5,
                        )
                      ]
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _leftRightAnimation,
              builder: (context, _){
                return Positioned(
                  top: _leftRightAnimation.value,
                  right: _leftRightAnimation.value,
                  child: Container(
                    width: width * 0.90,
                    height: height * 0.90,
                    decoration: BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          pink,
                          blue,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: playing?[
                        BoxShadow(
                          color: blue.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 5,
                        )
                      ]:[

                      ],
                    ),
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: (){
                playing = !playing;

                if(playing){
                  _playPauseAnimationController.forward();
                  _topBottomAnimationController.forward();

                  Future.delayed(const Duration(milliseconds: 500), (){
                    _leftRightAnimationController.forward();
                  });
                }else{
                  _playPauseAnimationController.reverse();
                  _topBottomAnimationController.stop();
                  _leftRightAnimationController.stop();
                }
              },
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _playPauseAnimationController,
                    size: 100,
                    color: white,
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