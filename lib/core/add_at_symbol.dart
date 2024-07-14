String addAtSymbol(String? username) {
  if (username == null) '';
  return '@$username';
}

String addHashSymbol(String username) {
  return '#$username';
}
