#!/bin/bash

IP=$1

text='''<html> <head> <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> <script src="js/app.js"></script> </head> <style> input { width:70%; } .card { border: 1px solid black; width: 90%; font-family: sans-serif; padding: 10px; margin: 1% 5%; } .title { font-weight: bold; display: block; } .tn { width:200px; } .row { display: flex; } .description { flex: 70%; } </style> <body> <form> TED search:<input type="text" id="query"> </form> <div id="cards"> </div> </body> </html>'''

test=$(curl -X GET "http://$IP/")

if [[ $(echo $test) = $(echo $text) ]];then
    echo "test passed"
    exit 0
else
    echo "test failed"
    exit 1
fi