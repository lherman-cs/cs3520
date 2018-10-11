
build: build-log
	zip lukash-sde1.zip lambda1.c lambda1.in lambda1.y yyerror1.c lambda1.log readme.txt

build-log:
	sh build-lambda1.sh
	ls cases/ | xargs -I{} sh -c "echo 'cat cases/{}' && cat cases/{} && echo "" &&  echo "" && echo './lambda1 < cases/{}' && ./lambda1 < cases/{}" > lambda1.log