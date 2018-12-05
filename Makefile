graalversion = graalvm-ce-1.0.0-rc9
graalbaseurl = https://github.com/oracle/graal/releases/download/vm-1.0.0-rc9 
graalvmsha256 = 39ae49285044352b7ead2a4277cb286f5a3be84611b849e8f21b86f37205bb61
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
	rm $(graalpackage)
