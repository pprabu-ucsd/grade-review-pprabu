CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm ListExamples.class
rm TestListExamples.class
git clone $1 student-submission
echo 'finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then 
    echo 'file: exists'
else    
    echo 'are you sure you passed in the right file?'
    exit
fi

cd ..


cp student-submission/ListExamples.java ./

set +e

javac -cp $CPATH *.java

if [[ -f TestListExamples.class ]] && [[ -f ListExamples.class ]] && [[ $(wc -l < grep_results.txt) -eq 0 ]]
then
    echo 'compile: success'
else
    echo "you have a compile error. check through your code again to see if there is a syntax error.'
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

grep -h 'failures¡¡¡' output.txt > grep_results.txt


if [[ $(wc -l <grep_results.txt) -ge 1 ]]
then
    echo 'you have test failures. fix them.'
else
    echo 'you passed all of your tests¡'
fi
