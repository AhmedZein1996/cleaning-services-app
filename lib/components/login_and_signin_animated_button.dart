import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isAnimating = true;
//enum to declare 3 state of button
enum ButtonState { init, submitting, completed }
enum appState {
  Test,
  Real,
}

class ButtonWidget extends StatefulWidget {
  appState stateOfApp;
  final title;
  final Function onPressed;
  ButtonWidget(
      {Key? key,
      this.title,
      required this.onPressed,
      this.stateOfApp = appState.Test})
      : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;
    return Container(
      alignment: Alignment.center,

      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          onEnd: () => setState(() {
                isAnimating = !isAnimating;
              }),
          width: state == ButtonState.init ? buttonWidth * .8 : 60,
          height: 57,
          // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
          child: isInit ? buildButton() : circularContainer(isDone)),
    );
  }

  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        onPressed: widget.stateOfApp == appState.Test
            ? () => widget.onPressed()
            : () async {
                // here when button is pressed
                // we are changing the state
                // therefore depending on state our button UI changed.
                setState(() {
                  state = ButtonState.submitting;
                });
                //await 2 sec // you need to implement your server response here.
                await Future.delayed(const Duration(seconds: 2));
                setState(() {
                  state = ButtonState.completed;
                });
                await Future.delayed(
                    // ignore: prefer_const_constructors
                    Duration(seconds: 2));
                setState(() {
                  state = ButtonState.init;
                });
              },
        child: Text(widget.title),
      );
// this is custom Widget to show rounded container
// here is state is submitting, we are showing loading indicator on container then.
// if it completed then showing a Icon.
  Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
