
echo -e '----------------------------------------------'
echo -e '---[ find duplicate pics in photo library ]---'
echo -e '----------------------------------------------'
echo '(1) change to the photo library directory'
cd "/Users/mmarone/Pictures/Photos Library.photoslibrary"

echo '(2) create a hash of each of the jpg files ... this can take a few minutes'
find . -name *.jpg -exec openssl md5 '{}' \; > ~/dup_pics/data/md5.list

echo '(3) get rid of the "noise" in the hash file'
awk -f ~/dup_pics/bin/scrub_md5_list.awk ~/dup_pics/data/md5.list > ~/dup_pics/data/file.hashes

echo '(4) slip into sql and load database with hash data'
sqlite3 <<-EOF
	create table ftable ( hash varchar, fname varchar );
	.separator "\t"
	.import /Users/mmarone/dup_pics/data/file.hashes ftable

	select 'number of rows imported:' || count(1) from ftable;

	.save /Users/mmarone/dup_pics/data/hashdb.sqlite3
	.exit
EOF

/Users/mmarone/dup_pics/bin/run_report.sh
