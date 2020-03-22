import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';

void main() async {
  NetworkHelper nHelper=NetworkHelper();
  nHelper.fetchStateDataList();
  nHelper.printStatesData();
  print(nHelper.statesData.last.indianCases);
}

class NetworkHelper {
  String url = "https://www.mohfw.gov.in/";
  List<State> statesData = [];

  printStatesData() => statesData.forEach((state) {
        print(
            "SatetName:${state.name} indainCases:${state.indianCases} foreignCases:${state.foreignCases} cured:${state.cured} deaths:${state.death} ");
      });

  Future<Document> getDocument() async {
    Client client = Client();
    Response response = await client.get(url);

    Document documents = parse(response.body);

    return documents;
  }

  fetchStateDataList() async {
    Document document = await getDocument();
    List<Element> table = document.getElementsByTagName("tbody");
    var rows = table[1].getElementsByTagName("tr");
    print(
        "total number of rows are ${rows.length} that mneans total states are ${rows.length - 1}");

    for (int i = 0; i < rows.length - 1; i++) {
      var rowData = rows[i].getElementsByTagName("td");
      statesData.add(State(
          name: rowData[1].text,
          cured: int.parse(rowData[4].text),
          death: int.parse(rowData[5].text),
          foreignCases: int.parse(rowData[3].text),
          indianCases: int.parse(rowData[2].text)));
    }
  }
}

class State {
  String name;
  int indianCases;
  int foreignCases;
  int cured;
  int death;
  State(
      {this.cured, this.death, this.foreignCases, this.indianCases, this.name});
}
