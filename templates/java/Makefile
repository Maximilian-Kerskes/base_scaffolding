.PHONY: all build test run clean

all: test

build:
	mvn package

test:
	mvn test

run:
	mvn compile
	java -cp target/classes com.project_name.App

clean:
	mvn clean
