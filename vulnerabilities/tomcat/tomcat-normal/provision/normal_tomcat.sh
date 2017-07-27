cd /home/vagrant/Downloads
mkdir web-contents
cd web-contents
curl http://192.168.33.20:8080 > tomcat-main.txt &
curl http://192.168.33.20:8080/examples/ > examples.txt &
# curl http://192.168.33.20:8080/examples/async/async0 > async0.txt &
# curl http://192.168.33.20:8080/examples/async/async1 > async1.txt &
# curl http://192.168.33.20:8080/examples/async/async2 > async2.txt &
# curl http://192.168.33.20:8080/examples/async/async3 > async3.txt &
# curl http://192.168.33.20:8080/examples/async/stockticker > stockticker.txt &
# curl http://192.168.33.20:8080/examples/servlets/nonblocking/bytecounter > bytecounter.txt &
# curl http://192.168.33.20:8080/examples/servlets/nonblocking/numberwriter > numberwriter.txt &
# curl http://192.168.33.20:8080/examples/CompressionTest > compression.txt &
# curl http://192.168.33.20:8080/examples/servlets/chat/chat > chat.txt &
curl http://192.168.33.20:8080/examples/servlets/servlet/HelloWorldExample > helloworld.txt &
# curl http://192.168.33.20:8080/examples/servlets/servlet/RequestInfoExample > requestinfo.txt &
# curl http://192.168.33.20:8080/examples/servlets/servlet/RequestParamExample > requestparam.txt & 
# curl http://192.168.33.20:8080/examples/servlets/servlet/CookieExample > cookie.txt &
# curl http://192.168.33.20:8080/examples/servlets/servlet/SessionExample > session.txt & 
# curl http://192.168.33.20:8080/examples/servletToJsp > servlettojsp.txt &

