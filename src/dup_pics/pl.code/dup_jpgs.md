#_dup_jpgs
('PT Mono’ Regular 12)

'''shell
$ pwd
/Users/mmarone/Pictures/Photos Library.photoslibrary

$ find . -name *.jpg -exec openssl md5 '{}' \; > ~/jpg.hashes

$ wc -l jpg.hashes 
   19206 jpg.hashes

$ head jpg.hashes
MD5(./Masters/2011/09/04/20110904-084957/0105091203.jpg)= 2a32308b5648f765f4eab8bf6bd852fe

$ awk '{ str = substr($1, 5, length($1)-6);
       printf "%s\t%s\n", $2, str }' jpg.hashes > jpg.hashes.list
'''

