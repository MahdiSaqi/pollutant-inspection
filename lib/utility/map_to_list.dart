
import '../models/base_definitionDTO.dart';

class MapConvertor
{
  static const String noneSelection='بدون انتخاب';
  static List<Map<String, dynamic>> MapToList(List<BaseDefinitionDTO> items)
  {
    var res =  <Map<String,dynamic>>{};
    res.add({'value': '0', 'title': noneSelection, 'id': '-1'});
    var x = 1;
    for(int i=0;i<items.length;i++) {
      res.add( {'value': x.toString(), 'title': items[i].title, 'id': items[i].id});
      x++;
    }
    return res.toList();
  }
}

