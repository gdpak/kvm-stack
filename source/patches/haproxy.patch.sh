cat > /tmp/haproxy.patch <<EOF
--- /tmp/haproxy.cfg    2016-01-11 10:27:37.799243679 +0000
+++ /etc/haproxy/haproxy.cfg    2016-01-11 10:09:18.751326067 +0000
@@ -40,7 +40,7 @@
   mode  tcp
   balance  roundrobin
   option  abortonclose
-#  server 192.168.100.133 192.168.100.133:9292 check inter 10s rise 2 fall 3
+  server 192.168.100.133 192.168.100.133:9292 check inter 10s rise 2 fall 3
   server 192.168.100.134 192.168.100.134:9292 check inter 10s rise 2 fall 3

 listen glance-registry
EOF
cd /etc/
patch < /tmp/glanceclient_common_httpy.patch

service glance-api restart
service glance-registry restart
service glance-common restart

