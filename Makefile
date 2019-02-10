default:
dependencies:
	sudo apt-get update && sudo apt-get install build-essential

	git clone https://github.com/yurydelendik/wasmception.git 
	cd wasmception && make
	
	git clone https://github.com/poemm/pywebassembly.git 

	curl https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly 
	# add it to your path
	rustup target add wasm32-unknown-unknown 
	
	echo ${HOME}
	cd ${HOME}
	wget https://github.com/WebAssembly/binaryen/archive/1.37.35.tar.gz -O ${HOME}/binaryen-1.37.35.tar.gz
	tar xvf binaryen-1.37.35.tar.gz
	cd binaryen-1.37.35 && cmake . && make

	cargo install wasm-gc
	cargo install chisel
	
prepare:
	$(MAKE) -f utils/node.mk
	$(MAKE) -f utils/clang.mk

slug.tgz: prepare
	utils/Dockerfile
	docker build -t tmp -f utils/Dockerfile .
	id=`docker create tmp` && \
	   docker cp $$id:slug.tgz slug.tgz && \
	   docker rm $$id
	tar czfv slug.tgz ./app

publish: slug.tgz
	$(MAKE) -f utils/pub.mk

clean:
	rm -rf app/node app/clang app/sysroot
	rm -rf slug.tgz
	rm -rf downloads

.PHONY: default prepare publish clean
