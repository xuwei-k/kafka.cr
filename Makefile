LINK_FLAGS = --link-flags "-static"
BIN_SRCS = src/bin/*.cr
PROGS = kafka-error kafka-heartbeat kafka-metadata kafka-offset kafka-ping kafka-topics

.PHONY : all build clean test spec test-compile-bin bin
.PHONY : ${PROGS}

all: build

build: bin ${PROGS}

bin:
	@mkdir -p bin

kafka-error: src/bin/error.cr
	crystal build --release $^ -o bin/$@ ${LINK_FLAGS}

kafka-heartbeat: src/bin/heartbeat.cr
	crystal build --release $^ -o bin/$@ ${LINK_FLAGS}

kafka-metadata: src/bin/metadata.cr
	crystal build --release $^ -o bin/$@ ${LINK_FLAGS}

kafka-offset: src/bin/offset.cr
	crystal build --release $^ -o bin/$@ ${LINK_FLAGS}

kafka-ping: src/bin/ping.cr
	crystal build --release $^ -o bin/$@ ${LINK_FLAGS}

kafka-topics: src/bin/topics.cr
	crystal build --release $^ -o bin/$@ ${LINK_FLAGS}

test: test-compile-bin spec

spec:
	crystal spec -v

test-compile-bin:
	@for x in src/bin/*.cr ; do\
	  crystal build "$$x" -o /dev/null ;\
	done

clean:
	@rm -rf bin tmp
