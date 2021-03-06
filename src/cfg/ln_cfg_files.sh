# make soft links from $HOME to files in cfg dir (upd for shell_config rename)
cfg=gh/rr/src/cfg
cd $HOME/$cfg
ln -sf shell_config bash_profile
ln -sf shell_config profile

cd $HOME
for fname in $cfg/* ; do
	shortname=${fname##$cfg/}
	prefix=${shortname:0:3}
	## don't make links for she* files
	if [[ "$prefix" != "she" ]] ; then
		ln -sf $fname .$shortname
	fi
done

# vim: set sw=2 ts=2 sts=2 noexpandtab :
