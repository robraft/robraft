
echo '(4a) slip into sql and create a report of the duplicate files'
sqlite3 $HOME/dup_pics/data/hashdb.sqlite3 <<-EOF
	.separator "\t"
	.header on

	.output $HOME/dup_pics/dup_files_report.txt
	/* limit dup fname to 1 per "collision" */
	/*
	SELECT f.hash,
	       f.fname
	  FROM ftable f
	 WHERE f."ROWID" IN (
	 	SELECT min(ft."ROWID")
		  FROM ftable as ft
		 WHERE ft.hash = f.hash
		 GROUP by ft.hash
		HAVING count(ft.hash) > 1
		ORDER BY ft.fname
		)
	 ORDER BY f.hash, f.fname;

	select x.tally,
	       f.hash,
	       f.fname
	  from ftable f,
	       (select count(hash) as tally, hash
		  from ftable
		 group by hash
		having tally > 1) as x
	 where f.hash = x.hash
	   and f.fname like '%Master%'
	 order by x.tally desc,
	          f.hash,
		  f.fname;
	  */

	/* original report */
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

echo "(5) see report of dup files in '$HOME/dup_pics/dup_files_report.txt'"
