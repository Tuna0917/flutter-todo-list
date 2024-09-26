import 'package:todo_list/models/todo.dart';

// deprecated
class TodoDefault {
  List<Todo> dummyTodos = [
    Todo(id: 1, title: '플러터 공부 시작하기', description: '뽕봅플을 읽어봅시다.'),
    Todo(id: 2, title: '서점 가기', description: '책을 사야해. 책. 많은 책. 더 많은 책.'),
    Todo(id: 3, title: '도서관 정복하기', description: '도서관에선 정숙. 내 머리는 정적.'),
    Todo(id: 4, title: '고추장 짜글이 끓이기', description: '맛있게 끓여봅시다.'),
  ];

  List<Todo> getTodos() {
    return dummyTodos;
  }

  Todo getTodo(int id) {
    return dummyTodos[id];
  }

  int getLastId() {
    return dummyTodos[dummyTodos.length - 1].id ?? dummyTodos.length;
  }

  Todo addTodo(Todo td) {
    Todo newTodo = Todo(
      // id: dummyTodos.length + 1, // 이러면 id 겹칠 수 있는데?
      id: getLastId() + 1,
      title: td.title,
      description: td.description,
    );
    dummyTodos.add(newTodo);
    return newTodo;
  }

  bool updateTodo(Todo td) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == td.id) {
        dummyTodos[i] = td;
        return true;
      }
    }
    return false;
  }

  bool deleteTodo(int id) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == id) {
        dummyTodos.removeAt(i);
        return true;
      }
    }
    return false;
  }
}
