import subprocess
import sys
import yaml
import json
 
#variables
yaml_file="docker-compose.yaml"
json_file="docker-compose.json"

#use pip to install package
def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

#load yaml file and parse it into a json file
def parse_yml_to_json(yaml_file,json_file):
    with open(yaml_file, 'r') as yaml_in, open(json_file, "w") as json_out:
        yaml_object = yaml.safe_load(yaml_in) # yaml_object will be a list or a dict
        json.dump(yaml_object, json_out)


#print image and ports of all services to the screen
def print_data_to_screen():
    output =json.load(open('docker-compose.json'))
    print(output)
    all_services= output["services"]
    for service_key in all_services:
            service=all_services[service_key]
            for key in service:
                if(key=="build"):
                    print("the service: " + service_key + "  using: "+"docker image build locally from: " + service[key]+"/")
                elif(key=="image"):
                    print("the service: " + service_key + "  using: " + service[key] + " docker image")
                    val= service[key]
                    new_val = input("Do you need to change the value: ")
                    if(new_val==""):
                        print("no value to change with")
                    elif(new_val.format.__str__):
                        service[key]=new_val
                    else:
                        print("value not correct")
                elif(key=="ports"):
                    print("the service: "+ service_key + " using this list of ports: " + str(service[key]))
    with open(yaml_file, 'w') as yaml_out:
            print(output)
            yaml.dump(output,yaml_out, allow_unicode=True)
           
#installing pyyaml liberary
install("pyyaml")

parse_yml_to_json(yaml_file,json_file)

print_data_to_screen()







        # print(service)
