#!/bin/sh

cd /app

if [ -z "${BMC_IP}" ] || [ -z "${BMC_USER}" ] || [ -z "${BMC_PASS}" ]; then
	echo "ERROR: BMC IP, Username, and Password must be provided."
	exit 1
fi

COOKIE=$(curl -s "http://${BMC_IP}/rpc/WEBSES/create.asp" --raw --data "WEBVAR_USERNAME=${BMC_USER}&WEBVAR_PASSWORD=${BMC_PASS}" -o - | sed -n "s/.*'SESSION_COOKIE'\s*:\s*'\([^']*\)'.*/\1/p")
echo "Cookie: ${COOKIE}"

curl -s -b Cookie=SessionCookie="${COOKIE}" http://$BMC_IP/Java/jviewer.jnlp -o jviewer.jnlp
TOKEN=$(grep "<argument>.*</argument>" jviewer.jnlp | sed -n '3p' | sed 's/<argument>\(.*\)<\/argument>/\1/')
echo "Token: ${TOKEN}"

echo "Starting JViewer..."
exec /usr/lib/jvm/java-1.8-openjdk/bin/java \
	-Djava.library.path=$PWD/libs \
	-cp JViewer.jar \
	com.ami.kvm.jviewer.JViewer \
	$BMC_IP 7578 $TOKEN 0 255 EN $COOKIE
