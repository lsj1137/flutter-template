/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about color picker function.
Dependency documents:
https://pub.dev/packages/file_picker
https://pub.dev/packages/audioplayers
*/

Color pickerColor = const Color(0xff808080);
Color color = const Color(0xffffffff);

// pick color dialog
void pickColor(BuildContext context) {
  pickerColor = color;
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlidePicker(
                indicatorSize: Size(MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.height * 0.2),
                sliderSize: Size(MediaQuery.of(context).size.width * 0.64,
                    MediaQuery.of(context).size.height * 0.06),
                pickerColor: pickerColor,
                onColorChanged: mode == 1 ? changeColor1 : changeColor2,
                colorModel: ColorModel.rgb,
                enableAlpha: false,
                displayThumbColor: false,
                showParams: false,
                showIndicator: true,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.check_rounded,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
      );
    },
  );
}
