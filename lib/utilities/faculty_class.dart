class Faculty {
  final int id;
  final String name;
  Faculty(this.id, this.name);

  static List<Faculty> fromAPI(Map facultyList){
    List<Faculty> facList = [];
    for (int i=1;i<facultyList.length;i++) {
      Map fac = facultyList['$i'];
      Faculty f = Faculty(fac['fac_id'], fac['fac_name']);
      facList.add(f);
    }
    return facList;
  }

}