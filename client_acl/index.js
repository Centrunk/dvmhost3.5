/*
* **************************************
* Caleb, KO4UYJ and Centrunk Dev/SecOps
* Centrunk ACL Fetcher
* **************************************
*/

import fetch from 'node-fetch';
import fs from 'fs';
import yaml from 'js-yaml';


const fneHost = `http://10.147.17.8:3002/update/host/acl`;
const acl_path = "/opt/centrunk/configs/rid_acl.dat";
const dvm_config_path = "/opt/centrunk/configs/";

var dvm_node_id = null;
function logInfo(str){
    console.log("LOG: INFO: " + str);
}
function logWarning(str){
    console.log("LOG: WARNING: " + str);
}
function logError(str){
    console.log("LOG: ERROR: " + str);
}
const fileNames = ['configCC1.yml', 'configVC1.yml', 'configCONV1.yml', 'configDVRS1.yml'];
let found = false;

for (const fileName of fileNames) {
    const filePath = `${dvm_config_path}${fileName}`;

    if (fs.existsSync(filePath)) {
        try {
            const config = yaml.load(fs.readFileSync(filePath, 'utf8'));
            const nodeId = config.network.id;
            dvm_node_id = nodeId;
            console.log('Node ID:', nodeId);
        } catch (error) {
            console.log('Error parsing YAML:', error);
        }
        found = true;
        break;
    }
}

if (!found) {
    logWarning("No DVM Configs Found");
}
if (!dvm_node_id){
    dvm_node_id = "Error with Node ID";
}
const response = await fetch(`${fneHost}/${dvm_node_id}`, {
    method: 'get',
    headers: {
        'Content-Type': 'application/json',
    },
});

if (response.ok) {
    const responseData = await response.json();
    const rid_acl_data = responseData.requestBody;

    try {
        fs.writeFileSync(acl_path, rid_acl_data);
        logInfo("Wrote data to CSV: " + acl_path);
    } catch (err) {
        logError("Error writing to: " + acl_path);
    }
} else {
    logError('There was an error with ACL! Failed to send command. Contact NET OPS');
}
