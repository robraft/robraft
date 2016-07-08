{
  hash = substr($0, length($0)-31, 32);
  fname = substr($0, 6, length($0)-40);
  printf "%s\t%s%s\n", hash, ENVIRON["PWD"], fname;
}
