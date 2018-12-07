graalversion = graalvm-ce-1.0.0-rc10
graalbaseurl = https://github.com/oracle/graal/releases/download/vm-1.0.0-rc10 
graalvmsha256 = dba5d874fe8bc5baf8f0fc187c9e8734ca5141b4f4f8a3b5b1f84326f3fbdc6d
dirs:
	mkdir -p stamps

stamps/build: dirs 
	sudo docker build --rm -f Dockerfile --build-arg GRAALVERSION=$(graalversion) \
	--build-arg GRAALBASEURL=$(graalbaseurl) \
	--build-arg GRAALVM_SHA256=$(graalvmsha256) \
	-t markkuko/jdk8-graalvm .
	touch $@

clean:
	rm -r stamps/*
