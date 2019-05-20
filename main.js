const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const fs = require('fs');

//Application variables
const url='https://api.github.com/gists/6bb69329f50efb7b79f7e5a2bf31597d';
const gistFile = "users.csv";
// Ensure you add the disk location to save the file
const diskLocation = "c:\\code\\files\\names.csv";
let responseTxt;

function pullGist(url, gistFile, diskLocation) {

    const Http = new XMLHttpRequest();

    Http.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            responseTxt = JSON.parse(this.responseText);
            responseTxt = responseTxt.files[gistFile].content;
            console.log(responseTxt)
            saveFileLocally(responseTxt, diskLocation);
            // appendBeforeSave(responseTxt);
        }
    }
    Http.open("GET", url);
    Http.send();

}

pullGist(url, gistFile, diskLocation);
