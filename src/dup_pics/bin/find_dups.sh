
echo -e '----------------------------------------------'
echo -e '---[ find duplicate pics in photo library ]---'
echo -e '----------------------------------------------'
echo '(1) change to the photo library directory'
cd "$HOME/Pictures/Photos Library.photoslibrary"

echo '(2) compute an md5 hash for each of the jpg files ... this can take a few minutes'
[[ ! -d $HOME/dup_pics/data ]] && mkdir $HOME/dup_pics/data
find . -name *.jpg -exec openssl md5 '{}' \; > $HOME/dup_pics/data/md5.list

echo '(3) get rid of the "noise" in the hash file'
awk -f $HOME/dup_pics/bin/scrub_md5_list.awk $HOME/dup_pics/data/md5.list > $HOME/dup_pics/data/file.hashes

echo '(4) slip into sql and load database with the hash data'
sqlite3 <<-EOF
	create table ftable ( hash varchar, fname varchar );
	.separator "\t"
	.import $HOME/dup_pics/data/file.hashes ftable

	select 'number of rows imported:' || count(1) from ftable;

	.save $HOME/dup_pics/data/hashdb.sqlite3
	.exit
EOF

$HOME/dup_pics/bin/run_report.sh
