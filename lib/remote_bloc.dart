import 'dart:async';
import 'remote_event.dart';
import 'remote_state.dart';

class RemoteBloc {
  var state = RemoteState(70); // init giá trị khởi tạo của RemoteState. Giả sử TV ban đầu có âm lượng 70
  var state2 = RemoteState2(20);
  // tạo 2 controller
  // 1 cái quản lý event, đảm nhận nhiệm vụ nhận event từ UI
  final eventController = StreamController<RemoteEvent>();
  final eventController2 = StreamController<RemoteEvent2>();
  // 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  final stateController = StreamController<RemoteState>();
  final stateController2 = StreamController<RemoteState2>();

  RemoteBloc() {
    eventController2.stream.listen((RemoteEvent2 event2) {
      if (event2 is IncrementEvent2) {
        // nếu eventController vừa add vào 1 IncrementEvent thì chúng ta xử lý tăng kenh
        state2 = RemoteState2(state2.kenh + event2.increment2);
      } else if (event2 is DecrementEvent2) {
        // xử lý giảm kenh
        state2 = RemoteState2(state2.kenh - event2.decrement2);
      }

      // add state mới vào stateController để bên UI nhận được
      stateController2.sink.add(state2);
    });


    // lắng nghe khi eventController push event mới
    eventController.stream.listen((RemoteEvent event) {
      // người ta thường tách hàm này ra 1 hàm riêng và đặt tên là: mapEventToState
      // đúng như cái tên, hàm này nhận event xử lý và cho ra output là state

      if (event is IncrementEvent) {
        // nếu eventController vừa add vào 1 IncrementEvent thì chúng ta xử lý tăng âm lượng
        state = RemoteState(state.volume + event.increment);
      } else if (event is DecrementEvent) {
        // xử lý giảm âm lượng
        state = RemoteState(state.volume - event.decrement);
      } else {
        // xử lý mute
        state = RemoteState(0);
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    }
    );
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() {
    stateController.close();
    eventController.close();
  }
}
