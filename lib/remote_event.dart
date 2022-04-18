abstract class RemoteEvent2 {}

class IncrementEvent2 extends RemoteEvent2 {
  IncrementEvent2(this.increment2);
  final int increment2;
}

class DecrementEvent2 extends RemoteEvent2 {
  DecrementEvent2(this.decrement2);
  final int decrement2;
}

abstract class RemoteEvent {}


// event tăng âm lượng, user muốn tăng lên bao nhiêu thì truyền vào biến increment
class IncrementEvent extends RemoteEvent {
  IncrementEvent(this.increment);

  final int increment;
}

// event giảm âm lượng, user muốn giảm bao nhiêu thì truyền vào biến decrement
class DecrementEvent extends RemoteEvent {
  DecrementEvent(this.decrement);

  final int decrement;
}

// event mute
class MuteEvent extends RemoteEvent {}
