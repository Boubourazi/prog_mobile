import 'package:velocity_x/velocity_x.dart';

//Store
class GlobalStore extends VxStore {
  List<String> campus = ["Anglet", "Pau", "Mont de Marsan"];
  int currentCampus = 0;
}

//Mutations
class ChangeCurrentCampus extends VxMutation<GlobalStore> {
  final int value;
  ChangeCurrentCampus(this.value);

  @override
  perform() {
    store!.currentCampus = value;
  }
}
