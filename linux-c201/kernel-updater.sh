#!/bin/bash
set -x
set -e
shopt -s nullglob

. updater-data
OLD_HASH=$(cat updater-hash)

rm -rf upstream
git clone $UPSTREAM -b $UPSTREAM_BRANCH upstream --depth=1000
BASEDIR=$(pwd)
cd upstream/$UPSTREAM_DIR
cp config config.new
git checkout $OLD_HASH config
cp config config.old
cp config.new config


if diff -u config.old config.new > $BASEDIR/config.diff; then
	# no changes
	rm $BASEDIR/config.diff
fi

N=1
git log --reverse --format=format:%H%n $OLD_HASH..HEAD PKGBUILD | while read line;
do
	if [ -n "$line" ]; then
		git format-patch --start-number=9999 -1 $line
		mv 9999-*.patch $BASEDIR/kupdate-$N.patch
		N=$((N + 1))
	fi
done

#set the config to what it was before in the upstream so patches apply nicely
cp config config.my
cp config.old $BASEDIR/config
git rev-parse HEAD > $BASEDIR/updater-new-hash
cd $BASEDIR

for update in kupdate-*.patch; do
	echo "Applying $update"...
	if patch $PATCH_PARM < $update; then
		echo "Applied OK"
		rm -v $update
	else
		echo "Problem applying $update - resolve conflicts and exit the shell"
		bash
		rm -v $update
	fi
done
#restore my config
mv config.my config

mv updater-new-hash updater-hash

if [ -f config.diff ]; then
	echo "Configuration file changes: "
	less config.diff
fi

