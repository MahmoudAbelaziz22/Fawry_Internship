```mermaid
flowchart TD
    start(Start) --> install_pyyaml(Install pyyaml);
    install_pyyaml--> load_yml_file(Load docker-compose.yml file);
    load_yml_file --> 
    parse_yml_file(Parse docker-compose.yml file to JSON);
    parse_yml_file-->print_data(Print Image and Port);
    print_data--> End(End);
```