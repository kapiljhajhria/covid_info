import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';

void main() async {
  NetworkHelper nHelper=NetworkHelper();
  await nHelper.fetchStateDataList();
  nHelper.printStatesData();
  print(nHelper.statesData.last.indianCases);
}

class NetworkHelper {
  String url = "https://www.mohfw.gov.in/";
  List<CountryState> statesData = [];
  bool get hasData=>statesData.isNotEmpty;
  bool fetchedData=false;
  printStatesData() => statesData.forEach((state) {
    print(
            "SatetName:${state.name} indainCases:${state.indianCases} foreignCases:${state.foreignCases} cured:${state.cured} deaths:${state.death} ");
    int totalIndianCases = statesData.fold(
        0, (sum, next) => sum + next.indianCases);
//  int totalIndianCases = statesData.forEach((state)=>totalNotIndianCases+=int.parse(state['totalCasesIndian'])); //working
    int totalNotIndianCases = statesData.fold(
        0, (sum, next) => sum + next.foreignCases);
    int totalCured =
    statesData.fold(0, (sum, next) => sum + next.cured);
    int totalDeath =
    statesData.fold(0, (sum, next) => sum + next.death);
    print("stats as of ${DateTime.now().toLocal()} total number of cases: ${totalNotIndianCases+totalIndianCases} Indian:$totalIndianCases Foreign:$totalNotIndianCases Total Death so far: $totalDeath and totla cured so far are $totalCured");

  });

  Future<Document> getDocument() async {
    Client client = Client();
    Response response = await client.get(url);

    Document documents = parse(response.body);

    return documents;
  }

  Future<bool> fetchStateDataList() async {
    Document document = await getDocument();
    List<Element> table = document.getElementsByTagName("tbody");
    var rows = table[1].getElementsByTagName("tr");
    print(
        "total number of rows are ${rows.length} that mneans total states are ${rows.length - 1}");

    for (int i = 0; i < rows.length - 1; i++) {
      var rowData = rows[i].getElementsByTagName("td");
      statesData.add(CountryState(
          name: rowData[1].text,
          cured: int.parse(rowData[4].text),
          death: int.parse(rowData[5].text),
          foreignCases: int.parse(rowData[3].text),
          indianCases: int.parse(rowData[2].text)));
    }
    return statesData.isNotEmpty;
  }
}

class CountryState {
  String name;
  int indianCases;
  int foreignCases;
  int cured;
  int death;
  CountryState(
      {this.cured, this.death, this.foreignCases, this.indianCases, this.name});
}
