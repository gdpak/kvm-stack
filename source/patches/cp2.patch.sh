cat > /tmp/glanceclient_common_httpy.patch <<EOF
--- http.py     2014-12-11 20:58:56.000000000 +0000
+++ /tmp/http.py        2016-01-11 10:06:46.175100000 +0000
@@ -72,8 +72,9 @@
             compression = kwargs.get('ssl_compression', True)

             if not compression:
-                self.session.mount("glance+https://", https.HTTPSAdapter())
-                self.endpoint = 'glance+' + self.endpoint
+                #self.session.mount("glance+https://", https.HTTPSAdapter())
+                self.session.mount("https://", https.HTTPSAdapter())
+                #self.endpoint = 'glance+' + self.endpoint

                 self.session.verify = (
                     kwargs.get('cacert', requests.certs.where()),
@@ -168,6 +169,8 @@
             chunk = body
             while chunk:
                 chunk = body.read(CHUNKSIZE)
+                if chunk == '':
+                    break
                 yield chunk

         data = kwargs.pop("data", None)
EOF
cd /usr/lib/python2.7/dist-packages/glanceclient/common
patch < /tmp/glanceclient_common_httpy.patch

service nova-compute restart

