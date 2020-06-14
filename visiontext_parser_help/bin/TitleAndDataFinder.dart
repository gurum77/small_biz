class TitleAndDataFinder{
  
  List<String> _textLines;
  String _title;
  String _data;

  TitleAndDataFinder(List<String> textLines)
  {
    _textLines  = textLines;
  }
  
  // text를 포함하는 textline 찾기
  bool FindByIncludingText(String includingText){

    
    for(var line in _textLines)
    {
      if(line.contains(includingText))
      {
  
        return true;
      }
    }

    return false;
  }
}