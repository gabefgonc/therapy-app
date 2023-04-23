String limitStringSize(String str, int size) {
  StringBuffer buffer = StringBuffer();
  if (str.length > size) {
    buffer.write('${str.substring(0, size)}...');
  } else {
    buffer.write(str);
  }
  return buffer.toString();
}
