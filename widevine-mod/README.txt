Copy libwidevinecdm.so from ChromeOS rootfs
(/opt/google/chrome) to the gmp-widevinecdm/<version>/ -folder
(that has the manifest.json)

hopefully check that the version is correct - I just
ran
strings libwidevinecdm.so | grep 4.10
but eg. compare to what desktop x86_64 firefox has
installed and i guess you can find it -
if it has changed, change the version in the
folder name, in the config below and in the
manifest.json

close firefox

install these files to the firefox profile directory:
cp -a gmp-widevinecdm ~/.mozilla/firefox/<id>./default/

start firefox, open about:config and put in these via right click menu New:

Name					Type	Value
-
media.gmp-manager.updateEnabled		boolean false
media.gmp-widevinecdm.version		string	4.10.1303.0
media.gmp-widevinecdm.abi		string	arm-eabi-gcc3
media.gmp-widevinecdm.visible		boolean true
media.gmp-widevinecdm.enabled		boolean true
media.gmp-widevinecdm.forceSupported	boolean true

and then change this already existing entry (search for it):
media.eme.enabled			boolean true

restart firefox

hope for the best
