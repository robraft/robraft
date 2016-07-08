
echo '(4a) slip into sql and create a report of the duplicate files'
sqlite3 /Users/mmarone/dup_pics/data/hashdb.sqlite3 <<-EOF
	.separator "\t"

	.output /Users/mmarone/dup_pics/dup_files_report.txt
	select x.tally,
	       f.hash,
	       f.fname
	  from ftable f,
	       (select count(hash) as tally, hash
		  from ftable
		 group by hash
		having tally > 1) as x
	 where f.hash = x.hash
	 order by x.tally desc,
	          f.hash,
		  f.fname;

	.exit

EOF

echo '(5) see report of dup files in '~/dup_pics/dup_files_report.txt''
