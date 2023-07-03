/*
* **************************************
* Caleb, KO4UYJ and Centrunk Dev/SecOps
* Centrunk ACL Fetcher
* **************************************
*/

import fetch from 'node-fetch';
import fs from 'fs';
import yaml from 'js-yaml';
function logInfo(str, log_path){
    try {
        fs.appendFileSync(log_path, "LOG: INFO: " + str);
    }
    catch (err){
        console.log("LOG: ERROR: " + err);
    }
    console.log("LOG: INFO: " + str);
}
function logWarning(str, log_path){
    try {
        fs.appendFileSync(log_path, "LOG: WARNING: " + str);
    }
    catch (err){
        console.log("LOG: ERROR: " + err);
    }
    console.log("LOG: WARNING: " + str);
}
function logError(str, log_path){
    try {
        fs.appendFileSync(log_path, "LOG: ERROR: " + str);
    }
    catch (err){
        console.log("LOG: ERROR: " + err);
    }
    console.log("LOG: ERROR: " + str);
}
try {
    const config_file_data = yaml.load(fs.readFileSync("config.yml", 'utf8'));
    var fneHost = config_file_data.fneHost;
    var acl_path = config_file_data.aclPath;
    var dvm_config_path = config_file_data.dvmConfigPath;
    var log_path = config_file_data.logLocation;
    logInfo(`Read Config Data:\n   FNE Host: ${fneHost}\n   ACL Write Path: ${acl_path}\n   DVM Path: ${dvm_config_path}\n   client_acl Path: ${log_path}`, log_path)
} catch (error) {
    console.log('Error parsing config file: ', error);
}

var dvm_node_id = null;

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
    logWarning("No DVM Configs Found", log_path);
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
        logInfo("Wrote data to CSV: " + acl_path, log_path);
    } catch (err) {
        logError("Error writing to: " + acl_path, log_path);
    }
} else {
    logError('There was an error with ACL! Failed to send command. Contact NET OPS', log_path);
}