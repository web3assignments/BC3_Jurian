// Code for PD-11
var ipfs; // will be used as ipfs instance

// Upload image to IPFS
async function uploadImage() {
    var checkImage = document.getElementById("image");
    if (checkImage.value.length > 2) { // Check if there is an image, value bigger than 0 indicates something is uploaded
        const reader = new FileReader();
        reader.onloadend = async function () {
            const buff = buffer.Buffer(reader.result); // Convert data into buffer
            const result = await ipfs.add(buff).catch(log);
            log(`CID = ${result.path}`);
            console.log(`CID: ${result.path} , URL: https://ipfs.io/ipfs/${result.path}`);
        };
        //const image = document.getElementById("image"); // Get value from file input
        reader.readAsArrayBuffer(checkImage.files[0]); // Read file contents
    } else {
        alert('Please upload an image!');
        checkImage.focus();
    }
}

// Get image from IPFS
async function getImage() {
    var ui8arr = [];
    var hash = document.getElementById("imageHashId").value;
    if (hash.length != 46){ // All ipfs CID's are 46 characters long, anything is else invalid
        alert('Please enter a valid ipfs CID before submitting!');
        return;
    }
    log(`Checking hash ${hash} via IPFS on Infura`);
    for await (const result of ipfs.cat(hash)) {
        ui8arr.push(result); // get all parts of the image
    }

    // Fill array with the found result
    for await (const result of ipfs.cat(hash)) {
      ui8arr.push(result);
    }

    console.log(ui8arr); // Log contents of array

    var blob = new Blob(ui8arr, { type: "image/jpeg" }); // convert to blob
    var url = URL.createObjectURL(blob); // make usable in img
    document.getElementById("myImage").src = url;
}

// Get hash of uploaded file from IPFS
async function getHash() {
    var imageHash = document.getElementById("imageHashId").value;
    if (imageHash == "") {
      alert("image hash is empty, upload an image first!");
      return;
    }
    console.log(`Hash: ${imageHash}`);
    document.getElementById("myImage").innerText = imageHash;
}

function log(logstr) {
    document.getElementById("log").innerHTML += logstr + "\n";
}

// Check ipfs version at load
window.onload = getIpfs;
async function getIpfs() {
    log(`Connecting to IPFS`);
    ipfs = window.IpfsHttpClient("https://ipfs.infura.io:5001");
    const version = await ipfs.version().catch((x) => log(`Error: ${x}`));
    log(`IPFS Version ${JSON.stringify(version)}`);
}
