# Installs ANTLR for Java checks
mkdir antlr
git clone git@github.com:antlr/grammars-v4.git grammar
wget https://www.antlr.org/download/antlr-4.7.2-complete.jar -O antlr/antlr.jar
java -jar antlr/antlr.jar grammar/java8/Java8.g4
