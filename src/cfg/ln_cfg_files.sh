# make soft links from $HOME to files in cfg dir
cfg=gh/rr/src/cfg
cd $HOME/$cfg
ln -sf shell_config_main bash_profile
ln -sf shell_config_main profile

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
