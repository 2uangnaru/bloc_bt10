import 'package:bloc/remote_bloc.dart';
import 'package:bloc/remote_event.dart';
import 'package:bloc/remote_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc(); // khởi tạo bloc  <=== new

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child:  StreamBuilder<RemoteState2>( // sử dụng StreamBuilder để lắng nghe Stream <=== new
                  stream: bloc.stateController2.stream, // truyền stream của stateController2 vào để lắng nghe <=== new
                  initialData: bloc.state2, // giá trị khởi tạo chính là kenh hiện tại <=== new
                  builder: (BuildContext context, AsyncSnapshot<RemoteState2> snapshot) {
                    return Text('kenh hiện tại: ${snapshot.data?.kenh}');// update UI <=== new
                  },
                )
            ),

            Container(
           child:  StreamBuilder<RemoteState>( // sử dụng StreamBuilder để lắng nghe Stream <=== new
          stream: bloc.stateController.stream, // truyền stream của stateController vào để lắng nghe <=== new
          initialData: bloc.state, // giá trị khởi tạo chính là volume 70 hiện tại <=== new
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Text('Âm lượng hiện tại: ${snapshot.data?.volume}');// update UI <=== new
          },
        ),),

          ]
        ),
      ),

      floatingActionButton:
       Column(
           mainAxisAlignment: MainAxisAlignment.end,
         children: [
           Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                 Padding(padding: EdgeInsets.all(30)),
                 FloatingActionButton(
                   onPressed: () => bloc.eventController2.sink.add(IncrementEvent2(1)), // add event <=== new
                   child: Text("+1"),
                 ),
                 FloatingActionButton(
                   onPressed: () => bloc.eventController2.sink.add(DecrementEvent2(1)), // add event <=== new
                   child: Text("-1"),
                 ),
               ]
           ),

           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            Padding(padding: EdgeInsets.all(30)),
             FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(IncrementEvent(5)), // add event <=== new
            child: Icon(Icons.volume_up),
           ),
             FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(DecrementEvent(10)), // add event <=== new
            child: Icon(Icons.volume_down),
          ),
             FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(MuteEvent()), // add event <=== new
            child: Icon(Icons.volume_mute),
          )
       ]
      ),
    ]
       )
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose(); // dispose bloc <=== new
  }
}
